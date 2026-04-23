package mg.visa.repository;

import mg.visa.model.Dossier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DossierRepository extends JpaRepository<Dossier, Long> {
    Optional<Dossier> findByPasseportNumero(String passeportNumero);
    Optional<Dossier> findByNumeroDossier(String numeroDossier);
    List<Dossier> findAllByOrderByDateCreationDesc();
}
