package mg.visa.controller;

import jakarta.validation.Valid;
import mg.visa.model.Demande;
import mg.visa.model.ObjectifDemande;
import mg.visa.model.SituationFamiliale;
import mg.visa.repository.TypeVisaRepository;
import mg.visa.service.DemandeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("/front")
public class FrontOfficeController {

    private final DemandeService demandeService;
    private final TypeVisaRepository typeVisaRepository;

    public FrontOfficeController(DemandeService demandeService, TypeVisaRepository typeVisaRepository) {
        this.demandeService = demandeService;
        this.typeVisaRepository = typeVisaRepository;
    }

    @GetMapping("")
    public String index() {
        return "front/index";
    }

    @GetMapping("/nouvelle-demande")
    public String nouvelleDemande(Model model) {
        model.addAttribute("demande", new Demande());
        model.addAttribute("typesVisa", typeVisaRepository.findAll());
        model.addAttribute("situations", SituationFamiliale.values());
        model.addAttribute("objectifs", ObjectifDemande.values());
        return "front/nouvelle-demande";
    }

    @PostMapping("/nouvelle-demande")
    public String soumettreNouvelleDemande(@Valid @ModelAttribute("demande") Demande demande,
                                           BindingResult result,
                                           Model model,
                                           RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("typesVisa", typeVisaRepository.findAll());
            model.addAttribute("situations", SituationFamiliale.values());
            model.addAttribute("objectifs", ObjectifDemande.values());
            return "front/nouvelle-demande";
        }
        Demande saved = demandeService.soumettreDemande(demande);
        redirectAttributes.addFlashAttribute("numeroDemande", saved.getNumeroDemande());
        return "redirect:/front/confirmation";
    }

    @GetMapping("/confirmation")
    public String confirmation() {
        return "front/confirmation";
    }

    @GetMapping("/suivi")
    public String suivi() {
        return "front/suivi";
    }

    @PostMapping("/suivi")
    public String rechercherDemande(@RequestParam("numeroDemande") String numeroDemande, Model model) {
        Optional<Demande> demande = demandeService.trouverParNumero(numeroDemande);
        if (demande.isPresent()) {
            model.addAttribute("demande", demande.get());
        } else {
            model.addAttribute("erreur", "Aucune demande trouvée avec le numéro : " + numeroDemande);
        }
        model.addAttribute("numeroDemande", numeroDemande);
        return "front/suivi";
    }
}
