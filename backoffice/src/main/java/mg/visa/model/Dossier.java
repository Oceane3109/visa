package mg.visa.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "dossier")
public class Dossier {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String numeroDossier;

    private LocalDateTime dateCreation;

    private String passeportNumero;

    private String nom;

    private String prenom;

    private String nationalite;

    private boolean scanTermine;

    @OneToMany(mappedBy = "dossier", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Demande> demandes = new ArrayList<>();

    @OneToMany(mappedBy = "dossier", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<PieceJustificative> piecesJustificatives = new ArrayList<>();

    @PrePersist
    public void prePersist() {
        this.dateCreation = LocalDateTime.now();
    }

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNumeroDossier() { return numeroDossier; }
    public void setNumeroDossier(String numeroDossier) { this.numeroDossier = numeroDossier; }

    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }

    public String getPasseportNumero() { return passeportNumero; }
    public void setPasseportNumero(String passeportNumero) { this.passeportNumero = passeportNumero; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getNationalite() { return nationalite; }
    public void setNationalite(String nationalite) { this.nationalite = nationalite; }

    public boolean isScanTermine() { return scanTermine; }
    public void setScanTermine(boolean scanTermine) { this.scanTermine = scanTermine; }

    public List<Demande> getDemandes() { return demandes; }
    public void setDemandes(List<Demande> demandes) { this.demandes = demandes; }

    public List<PieceJustificative> getPiecesJustificatives() { return piecesJustificatives; }
    public void setPiecesJustificatives(List<PieceJustificative> piecesJustificatives) { this.piecesJustificatives = piecesJustificatives; }
}
