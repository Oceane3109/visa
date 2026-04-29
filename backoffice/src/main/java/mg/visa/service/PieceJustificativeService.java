package mg.visa.service;

import mg.visa.model.Dossier;
import mg.visa.model.PieceJustificative;
import mg.visa.repository.DossierRepository;
import mg.visa.repository.PieceJustificativeRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class PieceJustificativeService {

    private final PieceJustificativeRepository pieceRepository;
    private final DossierRepository dossierRepository;

    private static final String UPLOAD_DIR = "/Users/oceanechristodoulou/Desktop/visa/uploads/pieces";

    public PieceJustificativeService(PieceJustificativeRepository pieceRepository,
                                      DossierRepository dossierRepository) {
        this.pieceRepository = pieceRepository;
        this.dossierRepository = dossierRepository;
    }

    public PieceJustificative ajouterPiece(Long dossierId, String typePiece, MultipartFile fichier) throws IOException {
        Optional<Dossier> dossierOpt = dossierRepository.findById(dossierId);
        if (dossierOpt.isEmpty()) {
            throw new IllegalArgumentException("Dossier introuvable");
        }

        Dossier dossier = dossierOpt.get();
        if (dossier.isScanTermine()) {
            throw new IllegalStateException("Le dossier est verrouillé, aucune modification possible");
        }

        Path uploadPath = Paths.get(UPLOAD_DIR, dossierId.toString());
        Files.createDirectories(uploadPath);

        String extension = "";
        String originalName = fichier.getOriginalFilename();
        if (originalName != null && originalName.contains(".")) {
            extension = originalName.substring(originalName.lastIndexOf("."));
        }
        String nomFichier = UUID.randomUUID() + extension;

        Path filePath = uploadPath.resolve(nomFichier);
        fichier.transferTo(filePath.toFile());

        PieceJustificative piece = new PieceJustificative();
        piece.setNomFichier(nomFichier);
        piece.setNomOriginal(originalName);
        piece.setTypePiece(typePiece);
        piece.setContentType(fichier.getContentType());
        piece.setTailleFichier(fichier.getSize());
        piece.setDossier(dossier);

        return pieceRepository.save(piece);
    }

    public void supprimerPiece(Long pieceId) throws IOException {
        Optional<PieceJustificative> pieceOpt = pieceRepository.findById(pieceId);
        if (pieceOpt.isEmpty()) {
            throw new IllegalArgumentException("Pièce introuvable");
        }

        PieceJustificative piece = pieceOpt.get();
        if (piece.getDossier().isScanTermine()) {
            throw new IllegalStateException("Le dossier est verrouillé, aucune modification possible");
        }

        Path filePath = Paths.get(UPLOAD_DIR, piece.getDossier().getId().toString(), piece.getNomFichier());
        Files.deleteIfExists(filePath);

        pieceRepository.delete(piece);
    }

    public List<PieceJustificative> listerParDossier(Long dossierId) {
        return pieceRepository.findByDossierIdOrderByDateAjoutDesc(dossierId);
    }

    public Optional<PieceJustificative> trouverParId(Long id) {
        return pieceRepository.findById(id);
    }

    public Path getCheminFichier(PieceJustificative piece) {
        return Paths.get(UPLOAD_DIR, piece.getDossier().getId().toString(), piece.getNomFichier());
    }
}
