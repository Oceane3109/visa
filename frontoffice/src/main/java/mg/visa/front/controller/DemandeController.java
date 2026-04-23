package mg.visa.front.controller;

import mg.framework.annotations.Controlleur;
import mg.framework.annotations.GetMapping;
import mg.framework.annotations.PostMapping;
import mg.framework.annotations.RequestParam;
import mg.framework.model.ModelView;
import mg.visa.front.dao.DemandeDao;
import mg.visa.front.dao.TypeVisaDao;
import mg.visa.front.model.Demande;

import java.time.LocalDate;

@Controlleur
public class DemandeController {

    private final DemandeDao demandeDao = new DemandeDao();
    private final TypeVisaDao typeVisaDao = new TypeVisaDao();

    @GetMapping("/nouvelle-demande")
    public ModelView formulaire() {
        ModelView mv = new ModelView("/WEB-INF/jsp/nouvelle-demande.jsp");
        try {
            mv.addAttribute("typesVisa", typeVisaDao.findAll());
        } catch (Exception e) {
            mv.addAttribute("error", "Erreur lors du chargement des types de visa: " + e.getMessage());
        }
        return mv;
    }

    @PostMapping("/nouvelle-demande")
    public ModelView soumettre(
            @RequestParam("nom") String nom,
            @RequestParam("prenom") String prenom,
            @RequestParam("nomJeuneFille") String nomJeuneFille,
            @RequestParam("situationFamiliale") String situationFamiliale,
            @RequestParam("nationalite") String nationalite,
            @RequestParam("adresseMadagascar") String adresseMadagascar,
            @RequestParam("profession") String profession,
            @RequestParam("contact") String contact,
            @RequestParam("passeportNumero") String passeportNumero,
            @RequestParam("passeportDateDelivrance") String passeportDateDelivrance,
            @RequestParam("passeportDateExpiration") String passeportDateExpiration,
            @RequestParam("visaReference") String visaReference,
            @RequestParam("visaDateEntree") String visaDateEntree,
            @RequestParam("visaLieuEntree") String visaLieuEntree,
            @RequestParam("visaDateExpiration") String visaDateExpiration,
            @RequestParam("typeVisaId") String typeVisaId,
            @RequestParam("informationsComplementaires") String informationsComplementaires,
            @RequestParam("objectifDemande") String objectifDemande
    ) {
        ModelView mv = new ModelView("/WEB-INF/jsp/confirmation.jsp");

        if (nom == null || nom.trim().isEmpty() || prenom == null || prenom.trim().isEmpty()) {
            mv = new ModelView("/WEB-INF/jsp/nouvelle-demande.jsp");
            mv.addAttribute("error", "Le nom et le pr\u00e9nom sont obligatoires");
            try { mv.addAttribute("typesVisa", typeVisaDao.findAll()); } catch (Exception ignored) {}
            return mv;
        }

        try {
            Demande d = new Demande();
            d.setNom(nom.trim());
            d.setPrenom(prenom.trim());
            d.setNomJeuneFille(nomJeuneFille != null ? nomJeuneFille.trim() : null);
            d.setSituationFamiliale(situationFamiliale);
            d.setNationalite(nationalite != null ? nationalite.trim() : "");
            d.setAdresseMadagascar(adresseMadagascar != null ? adresseMadagascar.trim() : "");
            d.setProfession(profession != null ? profession.trim() : "");
            d.setContact(contact != null ? contact.trim() : "");
            d.setPasseportNumero(passeportNumero != null ? passeportNumero.trim() : "");
            if (passeportDateDelivrance != null && !passeportDateDelivrance.isEmpty())
                d.setPasseportDateDelivrance(LocalDate.parse(passeportDateDelivrance));
            if (passeportDateExpiration != null && !passeportDateExpiration.isEmpty())
                d.setPasseportDateExpiration(LocalDate.parse(passeportDateExpiration));
            d.setVisaReference(visaReference != null ? visaReference.trim() : "");
            if (visaDateEntree != null && !visaDateEntree.isEmpty())
                d.setVisaDateEntree(LocalDate.parse(visaDateEntree));
            d.setVisaLieuEntree(visaLieuEntree != null ? visaLieuEntree.trim() : "");
            if (visaDateExpiration != null && !visaDateExpiration.isEmpty())
                d.setVisaDateExpiration(LocalDate.parse(visaDateExpiration));
            d.setTypeVisaId(Long.parseLong(typeVisaId));
            d.setInformationsComplementaires(informationsComplementaires);
            d.setObjectifDemande(objectifDemande);

            String numeroDemande = demandeDao.insert(d);
            mv.addAttribute("numeroDemande", numeroDemande);
        } catch (Exception e) {
            mv = new ModelView("/WEB-INF/jsp/nouvelle-demande.jsp");
            mv.addAttribute("error", "Erreur lors de l'enregistrement: " + e.getMessage());
            try { mv.addAttribute("typesVisa", typeVisaDao.findAll()); } catch (Exception ignored) {}
        }
        return mv;
    }
}
