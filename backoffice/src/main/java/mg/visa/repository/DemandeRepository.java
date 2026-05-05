package mg.visa.repository;

import mg.visa.model.Demande;
import mg.visa.model.StatutDemande;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DemandeRepository extends JpaRepository<Demande, Long> {
    Optional<Demande> findByNumeroDemande(String numeroDemande);
    List<Demande> findByStatut(StatutDemande statut);
    List<Demande> findAllByOrderByDateCreationDesc();
    long countByStatut(StatutDemande statut);
    List<Demande> findByPasseportNumeroOrderByDateCreationDesc(String passeportNumero);
}
