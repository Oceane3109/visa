package mg.visa.controller;

import mg.visa.model.Demande;
import mg.visa.model.Dossier;
import mg.visa.model.StatutDemande;
import mg.visa.service.DemandeService;
import mg.visa.service.DossierService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("")
public class BackOfficeController {

    private final DemandeService demandeService;
    private final DossierService dossierService;

    public BackOfficeController(DemandeService demandeService, DossierService dossierService) {
        this.demandeService = demandeService;
        this.dossierService = dossierService;
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
        return "back/dossier-detail";
    }
}
