package mg.visa.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "piece_justificative")
public class PieceJustificative {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String nomFichier;

    @Column(nullable = false)
    private String nomOriginal;

    @Column(nullable = false)
    private String typePiece;

    private String contentType;

    private Long tailleFichier;

    private LocalDateTime dateAjout;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dossier_id", nullable = false)
    private Dossier dossier;

    @PrePersist
    public void prePersist() {
        this.dateAjout = LocalDateTime.now();
    }

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNomFichier() { return nomFichier; }
    public void setNomFichier(String nomFichier) { this.nomFichier = nomFichier; }

    public String getNomOriginal() { return nomOriginal; }
    public void setNomOriginal(String nomOriginal) { this.nomOriginal = nomOriginal; }

    public String getTypePiece() { return typePiece; }
    public void setTypePiece(String typePiece) { this.typePiece = typePiece; }

    public String getContentType() { return contentType; }
    public void setContentType(String contentType) { this.contentType = contentType; }

    public Long getTailleFichier() { return tailleFichier; }
    public void setTailleFichier(Long tailleFichier) { this.tailleFichier = tailleFichier; }

    public LocalDateTime getDateAjout() { return dateAjout; }
    public void setDateAjout(LocalDateTime dateAjout) { this.dateAjout = dateAjout; }

    public Dossier getDossier() { return dossier; }
    public void setDossier(Dossier dossier) { this.dossier = dossier; }
}
