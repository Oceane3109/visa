package mg.visa.repository;

import mg.visa.model.PieceJustificative;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PieceJustificativeRepository extends JpaRepository<PieceJustificative, Long> {
    List<PieceJustificative> findByDossierIdOrderByDateAjoutDesc(Long dossierId);
    long countByDossierId(Long dossierId);
}
