package mg.visa.controller;

import mg.visa.model.Demande;
import mg.visa.model.Dossier;
import mg.visa.model.PieceJustificative;
import mg.visa.model.StatutDemande;
import mg.visa.service.DemandeService;
import mg.visa.service.DossierService;
import mg.visa.service.PieceJustificativeService;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.nio.file.Path;
import java.util.Optional;

@Controller
@RequestMapping("")
public class BackOfficeController {

    private final DemandeService demandeService;
    private final DossierService dossierService;
    private final PieceJustificativeService pieceService;

    public BackOfficeController(DemandeService demandeService, DossierService dossierService,
                                PieceJustificativeService pieceService) {
        this.demandeService = demandeService;
        this.dossierService = dossierService;
        this.pieceService = pieceService;
    }

    @GetMapping("")
    public String dashboard(Model model) {
        model.addAttribute("totalDemandes", demandeService.compterTotal());
        model.addAttribute("soumises", demandeService.compterParStatut(StatutDemande.SOUMISE));
        model.addAttribute("enCours", demandeService.compterParStatut(StatutDemande.EN_COURS));
        model.addAttribute("validees", demandeService.compterParStatut(StatutDemande.VALIDEE));
        model.addAttribute("rejetees", demandeService.compterParStatut(StatutDemande.REJETEE));
        model.addAttribute("incompletes", demandeService.compterParStatut(StatutDemande.INCOMPLETE));
        model.addAttribute("approuvees", demandeService.compterParStatut(StatutDemande.APPROUVEE));
        model.addAttribute("totalDossiers", dossierService.compterTotal());
        model.addAttribute("dernieresDemandes", demandeService.listerToutesDemandes());
        return "back/dashboard";
    }

    @GetMapping("/demandes")
    public String listerDemandes(@RequestParam(value = "statut", required = false) String statut, Model model) {
        if (statut != null && !statut.isEmpty()) {
            model.addAttribute("demandes", demandeService.listerParStatut(StatutDemande.valueOf(statut)));
            model.addAttribute("filtreStatut", statut);
        } else {
            model.addAttribute("demandes", demandeService.listerToutesDemandes());
        }
        model.addAttribute("statuts", StatutDemande.values());
        return "back/demandes";
    }

    @GetMapping("/demandes/{id}")
    public String detailDemande(@PathVariable Long id, Model model) {
        Optional<Demande> demande = demandeService.trouverParId(id);
        if (demande.isEmpty()) {
            return "redirect:/demandes";
        }
        model.addAttribute("demande", demande.get());
        model.addAttribute("statuts", StatutDemande.values());
        return "back/demande-detail";
    }

    @PostMapping("/demandes/{id}/statut")
    public String changerStatut(@PathVariable Long id,
                                @RequestParam("statut") String statut,
                                RedirectAttributes redirectAttributes) {
        demandeService.changerStatut(id, StatutDemande.valueOf(statut));
        redirectAttributes.addFlashAttribute("success", "Statut mis à jour avec succès");
        return "redirect:/demandes/" + id;
    }

    @PostMapping("/demandes/{id}/incomplete")
    public String marquerIncomplete(@PathVariable Long id,
                                    @RequestParam("remarques") String remarques,
                                    RedirectAttributes redirectAttributes) {
        demandeService.marquerIncomplete(id, remarques);
        redirectAttributes.addFlashAttribute("success", "Demande marquée comme incomplète");
        return "redirect:/demandes/" + id;
    }

    @GetMapping("/dossiers")
    public String listerDossiers(Model model) {
        model.addAttribute("dossiers", dossierService.listerTousDossiers());
        return "back/dossiers";
    }

    @GetMapping("/dossiers/{id}")
    public String detailDossier(@PathVariable Long id, Model model) {
        Optional<Dossier> dossier = dossierService.trouverParId(id);
        if (dossier.isEmpty()) {
            return "redirect:/dossiers";
        }
        model.addAttribute("dossier", dossier.get());
        model.addAttribute("pieces", pieceService.listerParDossier(id));
        return "back/dossier-detail";
    }

    @PostMapping("/dossiers/{id}/pieces")
    public String ajouterPiece(@PathVariable Long id,
                               @RequestParam("typePiece") String typePiece,
                               @RequestParam("fichier") MultipartFile fichier,
                               RedirectAttributes redirectAttributes) {
        try {
            pieceService.ajouterPiece(id, typePiece, fichier);
            redirectAttributes.addFlashAttribute("success", "Pièce justificative ajoutée avec succès");
        } catch (IllegalStateException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de l'upload du fichier");
        }
        return "redirect:/dossiers/" + id;
    }

    @PostMapping("/dossiers/{dossierId}/pieces/{pieceId}/supprimer")
    public String supprimerPiece(@PathVariable Long dossierId,
                                 @PathVariable Long pieceId,
                                 RedirectAttributes redirectAttributes) {
        try {
            pieceService.supprimerPiece(pieceId);
            redirectAttributes.addFlashAttribute("success", "Pièce supprimée avec succès");
        } catch (IllegalStateException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la suppression");
        }
        return "redirect:/dossiers/" + dossierId;
    }

    @GetMapping("/dossiers/{dossierId}/pieces/{pieceId}/telecharger")
    public ResponseEntity<Resource> telechargerPiece(@PathVariable Long dossierId,
                                                      @PathVariable Long pieceId) {
        try {
            Optional<PieceJustificative> pieceOpt = pieceService.trouverParId(pieceId);
            if (pieceOpt.isEmpty()) {
                return ResponseEntity.notFound().build();
            }
            PieceJustificative piece = pieceOpt.get();
            Path filePath = pieceService.getCheminFichier(piece);
            Resource resource = new UrlResource(filePath.toUri());
            if (!resource.exists()) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + piece.getNomOriginal() + "\"")
                    .header(HttpHeaders.CONTENT_TYPE, piece.getContentType())
                    .body(resource);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    @PostMapping("/dossiers/{id}/scan-termine")
    public String terminerScan(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            dossierService.terminerScan(id);
            redirectAttributes.addFlashAttribute("success", "Scan terminé — le dossier est maintenant verrouillé");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/dossiers/" + id;
    }
}
