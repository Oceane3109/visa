package mg.visa.service;

import mg.visa.model.Demande;
import mg.visa.model.Dossier;
import mg.visa.model.ObjectifDemande;
import mg.visa.model.StatutDemande;
import mg.visa.repository.DossierRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class DossierService {

    private final DossierRepository dossierRepository;

    public DossierService(DossierRepository dossierRepository) {
        this.dossierRepository = dossierRepository;
    }

    public Dossier trouverOuCreerDossier(Demande demande) {
        Optional<Dossier> existant = dossierRepository.findByPasseportNumero(demande.getPasseportNumero());

        if (existant.isPresent()) {
            return existant.get();
        }

        Dossier dossier = new Dossier();
        dossier.setNumeroDossier(genererNumeroDossier());
        dossier.setPasseportNumero(demande.getPasseportNumero());
        dossier.setNom(demande.getNom());
        dossier.setPrenom(demande.getPrenom());
        dossier.setNationalite(demande.getNationalite());
        return dossierRepository.save(dossier);
    }

    public boolean isDuplicataOuTransfert(ObjectifDemande objectif) {
        return objectif == ObjectifDemande.DUPLICATA_CARTE || objectif == ObjectifDemande.TRANSFERT_VISA;
    }

    public List<Dossier> listerTousDossiers() {
        return dossierRepository.findAllByOrderByDateCreationDesc();
    }

    public Optional<Dossier> trouverParId(Long id) {
        return dossierRepository.findById(id);
    }

    public Optional<Dossier> trouverParNumero(String numeroDossier) {
        return dossierRepository.findByNumeroDossier(numeroDossier);
    }

    public Optional<Dossier> trouverParPasseport(String passeportNumero) {
        return dossierRepository.findByPasseportNumero(passeportNumero);
    }

    public long compterTotal() {
        return dossierRepository.count();
    }

    private String genererNumeroDossier() {
        String prefix = "DOS-" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMM"));
        long count = dossierRepository.count() + 1;
        return prefix + "-" + String.format("%04d", count);
    }
}
