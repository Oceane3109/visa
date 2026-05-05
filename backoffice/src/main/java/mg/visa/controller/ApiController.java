package mg.visa.controller;

import mg.visa.model.*;
import mg.visa.repository.TypeVisaRepository;
import mg.visa.service.DemandeService;
import mg.visa.service.DossierService;
import mg.visa.service.QrCodeService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
public class ApiController {

    private final DemandeService demandeService;
    private final DossierService dossierService;
    private final TypeVisaRepository typeVisaRepository;
    private final QrCodeService qrCodeService;

    public ApiController(DemandeService demandeService, DossierService dossierService,
                         TypeVisaRepository typeVisaRepository, QrCodeService qrCodeService) {
        this.demandeService = demandeService;
        this.dossierService = dossierService;
        this.typeVisaRepository = typeVisaRepository;
        this.qrCodeService = qrCodeService;
    }

    // --- Recherche par numéro de passeport ---
    @GetMapping("/demandes/passeport/{numero}")
    public ResponseEntity<?> rechercherParPasseport(@PathVariable String numero) {
        List<Demande> demandes = demandeService.listerParPasseport(numero);
        if (demandes.isEmpty()) {
            return ResponseEntity.ok(Map.of("demandes", List.of(), "message", "Aucune demande trouvée pour ce passeport"));
        }

        List<Map<String, Object>> result = demandes.stream()
                .map(this::demandeToMap)
                .collect(Collectors.toList());

        Optional<Dossier> dossier = dossierService.trouverParPasseport(numero);
        Map<String, Object> response = new LinkedHashMap<>();
        response.put("passeportNumero", numero);
        response.put("demandes", result);
        response.put("nombreDemandes", demandes.size());
        dossier.ifPresent(d -> {
            Map<String, Object> dossierMap = new LinkedHashMap<>();
            dossierMap.put("id", d.getId());
            dossierMap.put("numeroDossier", d.getNumeroDossier());
            dossierMap.put("scanTermine", d.isScanTermine());
            dossierMap.put("dateCreation", d.getDateCreation());
            response.put("dossier", dossierMap);
        });

        return ResponseEntity.ok(response);
    }

    // --- Recherche par numéro de demande ---
    @GetMapping("/demandes/{numeroDemande}")
    public ResponseEntity<?> rechercherParNumeroDemande(@PathVariable String numeroDemande) {
        Optional<Demande> demandeOpt = demandeService.trouverParNumero(numeroDemande);
        if (demandeOpt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("error", "Demande introuvable", "numeroDemande", numeroDemande));
        }
        return ResponseEntity.ok(demandeToMap(demandeOpt.get()));
    }

    // --- Création de demande ---
    @PostMapping("/demandes")
    public ResponseEntity<?> creerDemande(@RequestBody Map<String, Object> body) {
        try {
            Demande demande = new Demande();

            demande.setNom((String) body.get("nom"));
            demande.setPrenom((String) body.get("prenom"));
            demande.setNomJeuneFille((String) body.get("nomJeuneFille"));
            demande.setSituationFamiliale(SituationFamiliale.valueOf((String) body.get("situationFamiliale")));
            demande.setNationalite((String) body.get("nationalite"));
            demande.setAdresseMadagascar((String) body.get("adresseMadagascar"));
            demande.setProfession((String) body.get("profession"));
            demande.setContact((String) body.get("contact"));

            demande.setPasseportNumero((String) body.get("passeportNumero"));
            demande.setPasseportDateDelivrance(LocalDate.parse((String) body.get("passeportDateDelivrance")));
            demande.setPasseportDateExpiration(LocalDate.parse((String) body.get("passeportDateExpiration")));

            demande.setVisaReference((String) body.get("visaReference"));
            demande.setVisaDateEntree(LocalDate.parse((String) body.get("visaDateEntree")));
            demande.setVisaLieuEntree((String) body.get("visaLieuEntree"));
            demande.setVisaDateExpiration(LocalDate.parse((String) body.get("visaDateExpiration")));

            Long typeVisaId = Long.valueOf(body.get("typeVisaId").toString());
            TypeVisa typeVisa = typeVisaRepository.findById(typeVisaId)
                    .orElseThrow(() -> new RuntimeException("Type de visa introuvable"));
            demande.setTypeVisa(typeVisa);

            demande.setObjectifDemande(ObjectifDemande.valueOf((String) body.get("objectifDemande")));
            demande.setInformationsComplementaires((String) body.get("informationsComplementaires"));

            Demande saved = demandeService.soumettreDemande(demande);

            Map<String, Object> response = demandeToMap(saved);
            response.put("qrCodeUrl", "/api/demandes/" + saved.getNumeroDemande() + "/qrcode");

            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    // --- QR Code ---
    @GetMapping("/demandes/{numeroDemande}/qrcode")
    public ResponseEntity<byte[]> genererQrCode(@PathVariable String numeroDemande) {
        try {
            Optional<Demande> demandeOpt = demandeService.trouverParNumero(numeroDemande);
            if (demandeOpt.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            String url = "http://172.20.10.7:8080/visa-front4-react/demandes/" + numeroDemande + "?from=qrcode";
            byte[] qrCode = qrCodeService.genererQrCode(url, 300, 300);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.IMAGE_PNG);
            headers.setContentLength(qrCode.length);

            return new ResponseEntity<>(qrCode, headers, HttpStatus.OK);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    // --- Types de visa ---
    @GetMapping("/types-visa")
    public ResponseEntity<?> listerTypesVisa() {
        return ResponseEntity.ok(typeVisaRepository.findAll());
    }

    // --- Objectifs de demande ---
    @GetMapping("/objectifs")
    public ResponseEntity<?> listerObjectifs() {
        List<Map<String, String>> objectifs = Arrays.stream(ObjectifDemande.values())
                .map(o -> Map.of("code", o.name(), "libelle", o.getLibelle()))
                .collect(Collectors.toList());
        return ResponseEntity.ok(objectifs);
    }

    // --- Situations familiales ---
    @GetMapping("/situations-familiales")
    public ResponseEntity<?> listerSituationsFamiliales() {
        List<Map<String, String>> situations = Arrays.stream(SituationFamiliale.values())
                .map(s -> Map.of("code", s.name(), "libelle", s.getLibelle()))
                .collect(Collectors.toList());
        return ResponseEntity.ok(situations);
    }

    // --- Helper: convertir Demande en Map ---
    private Map<String, Object> demandeToMap(Demande d) {
        Map<String, Object> map = new LinkedHashMap<>();
        map.put("id", d.getId());
        map.put("numeroDemande", d.getNumeroDemande());
        map.put("dateCreation", d.getDateCreation());
        map.put("statut", d.getStatut().name());
        map.put("statutLibelle", d.getStatut().getLibelle());
        map.put("nom", d.getNom());
        map.put("prenom", d.getPrenom());
        map.put("nomJeuneFille", d.getNomJeuneFille());
        map.put("situationFamiliale", d.getSituationFamiliale() != null ? d.getSituationFamiliale().name() : null);
        map.put("situationFamilialeLibelle", d.getSituationFamiliale() != null ? d.getSituationFamiliale().getLibelle() : null);
        map.put("nationalite", d.getNationalite());
        map.put("adresseMadagascar", d.getAdresseMadagascar());
        map.put("profession", d.getProfession());
        map.put("contact", d.getContact());
        map.put("passeportNumero", d.getPasseportNumero());
        map.put("passeportDateDelivrance", d.getPasseportDateDelivrance());
        map.put("passeportDateExpiration", d.getPasseportDateExpiration());
        map.put("visaReference", d.getVisaReference());
        map.put("visaDateEntree", d.getVisaDateEntree());
        map.put("visaLieuEntree", d.getVisaLieuEntree());
        map.put("visaDateExpiration", d.getVisaDateExpiration());
        if (d.getTypeVisa() != null) {
            map.put("typeVisa", Map.of(
                    "id", d.getTypeVisa().getId(),
                    "code", d.getTypeVisa().getCode(),
                    "libelle", d.getTypeVisa().getLibelle()
            ));
        }
        map.put("objectifDemande", d.getObjectifDemande() != null ? d.getObjectifDemande().name() : null);
        map.put("objectifDemandeLibelle", d.getObjectifDemande() != null ? d.getObjectifDemande().getLibelle() : null);
        map.put("informationsComplementaires", d.getInformationsComplementaires());
        map.put("donneesIncompletes", d.isDonneesIncompletes());
        map.put("remarques", d.getRemarques());
        if (d.getDossier() != null) {
            map.put("dossier", Map.of(
                    "id", d.getDossier().getId(),
                    "numeroDossier", d.getDossier().getNumeroDossier(),
                    "scanTermine", d.getDossier().isScanTermine()
            ));
        }
        map.put("qrCodeUrl", "/api/demandes/" + d.getNumeroDemande() + "/qrcode");
        return map;
    }
}
