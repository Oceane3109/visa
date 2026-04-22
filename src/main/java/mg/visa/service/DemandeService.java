package mg.visa.service;

import mg.visa.model.Demande;
import mg.visa.model.StatutDemande;
import mg.visa.repository.DemandeRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class DemandeService {

    private final DemandeRepository demandeRepository;

    public DemandeService(DemandeRepository demandeRepository) {
        this.demandeRepository = demandeRepository;
    }

    public Demande soumettreDemande(Demande demande) {
        demande.setNumeroDemande(genererNumeroDemande());
        demande.setStatut(StatutDemande.SOUMISE);
        return demandeRepository.save(demande);
    }

    public List<Demande> listerToutesDemandes() {
        return demandeRepository.findAllByOrderByDateCreationDesc();
    }

    public List<Demande> listerParStatut(StatutDemande statut) {
        return demandeRepository.findByStatut(statut);
    }

    public Optional<Demande> trouverParId(Long id) {
        return demandeRepository.findById(id);
    }

    public Optional<Demande> trouverParNumero(String numeroDemande) {
        return demandeRepository.findByNumeroDemande(numeroDemande);
    }

    public Demande changerStatut(Long id, StatutDemande nouveauStatut) {
        Demande demande = demandeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Demande non trouvée"));
        demande.setStatut(nouveauStatut);
        return demandeRepository.save(demande);
    }

    public Demande marquerIncomplete(Long id, String remarques) {
        Demande demande = demandeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Demande non trouvée"));
        demande.setDonneesIncompletes(true);
        demande.setStatut(StatutDemande.INCOMPLETE);
        demande.setRemarques(remarques);
        return demandeRepository.save(demande);
    }

    public long compterParStatut(StatutDemande statut) {
        return demandeRepository.countByStatut(statut);
    }

    public long compterTotal() {
        return demandeRepository.count();
    }

    private String genererNumeroDemande() {
        String prefix = "VT-" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMM"));
        long count = demandeRepository.count() + 1;
        return prefix + "-" + String.format("%04d", count);
    }
}
