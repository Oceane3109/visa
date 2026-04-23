package mg.visa.front.controller;

import mg.framework.annotations.Controlleur;
import mg.framework.annotations.GetMapping;
import mg.framework.annotations.PostMapping;
import mg.framework.annotations.RequestParam;
import mg.framework.model.ModelView;
import mg.visa.front.dao.DemandeDao;
import mg.visa.front.model.Demande;

@Controlleur
public class SuiviController {

    private final DemandeDao demandeDao = new DemandeDao();

    @GetMapping("/suivi")
    public ModelView formulaireSuivi() {
        return new ModelView("/WEB-INF/jsp/suivi.jsp");
    }

    @PostMapping("/suivi")
    public ModelView rechercher(@RequestParam("numeroDemande") String numeroDemande) {
        ModelView mv = new ModelView("/WEB-INF/jsp/suivi.jsp");
        mv.addAttribute("numeroDemande", numeroDemande);

        if (numeroDemande == null || numeroDemande.trim().isEmpty()) {
            mv.addAttribute("error", "Veuillez entrer un num\u00e9ro de demande");
            return mv;
        }

        try {
            Demande demande = demandeDao.findByNumeroDemande(numeroDemande.trim());
            if (demande != null) {
                mv.addAttribute("demande", demande);
            } else {
                mv.addAttribute("error", "Aucune demande trouv\u00e9e avec le num\u00e9ro : " + numeroDemande);
            }
        } catch (Exception e) {
            mv.addAttribute("error", "Erreur lors de la recherche : " + e.getMessage());
        }
        return mv;
    }
}
