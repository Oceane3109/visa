package mg.visa.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "demande")
public class Demande {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String numeroDemande;

    private LocalDateTime dateCreation;

    @Enumerated(EnumType.STRING)
    private StatutDemande statut;

    // --- Etat civil ---
    @NotBlank(message = "Le nom est obligatoire")
    private String nom;

    @NotBlank(message = "Le prénom est obligatoire")
    private String prenom;

    private String nomJeuneFille;

    @Enumerated(EnumType.STRING)
    @NotNull(message = "La situation familiale est obligatoire")
    private SituationFamiliale situationFamiliale;

    @NotBlank(message = "La nationalité est obligatoire")
    private String nationalite;

    @NotBlank(message = "L'adresse est obligatoire")
    private String adresseMadagascar;

    private String profession;

    @NotBlank(message = "Le contact est obligatoire")
    private String contact;

    // --- Passeport ---
    @NotBlank(message = "Le numéro de passeport est obligatoire")
    private String passeportNumero;

    @NotNull(message = "La date de délivrance est obligatoire")
    private LocalDate passeportDateDelivrance;

    @NotNull(message = "La date d'expiration est obligatoire")
    private LocalDate passeportDateExpiration;

    // --- Visa transformable ---
    @NotBlank(message = "La référence du visa est obligatoire")
    private String visaReference;

    @NotNull(message = "La date d'entrée est obligatoire")
    private LocalDate visaDateEntree;

    @NotBlank(message = "Le lieu d'entrée est obligatoire")
    private String visaLieuEntree;

    @NotNull(message = "La date d'expiration du visa est obligatoire")
    private LocalDate visaDateExpiration;

    // --- Type de visa demandé ---
    @ManyToOne
    @JoinColumn(name = "type_visa_id")
    @NotNull(message = "Le type de visa est obligatoire")
    private TypeVisa typeVisa;

    @Column(columnDefinition = "TEXT")
    private String informationsComplementaires;

    // --- Objectif de la demande ---
    @Enumerated(EnumType.STRING)
    @NotNull(message = "L'objectif de la demande est obligatoire")
    private ObjectifDemande objectifDemande;

    // --- Dossier lié ---
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dossier_id")
    private Dossier dossier;

    // --- Données incomplètes ---
    private boolean donneesIncompletes;

    @Column(columnDefinition = "TEXT")
    private String remarques;

    @PrePersist
    public void prePersist() {
        this.dateCreation = LocalDateTime.now();
        if (this.statut == null) {
            this.statut = StatutDemande.SOUMISE;
        }
    }

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNumeroDemande() { return numeroDemande; }
    public void setNumeroDemande(String numeroDemande) { this.numeroDemande = numeroDemande; }

    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }

    public StatutDemande getStatut() { return statut; }
    public void setStatut(StatutDemande statut) { this.statut = statut; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getNomJeuneFille() { return nomJeuneFille; }
    public void setNomJeuneFille(String nomJeuneFille) { this.nomJeuneFille = nomJeuneFille; }

    public SituationFamiliale getSituationFamiliale() { return situationFamiliale; }
    public void setSituationFamiliale(SituationFamiliale situationFamiliale) { this.situationFamiliale = situationFamiliale; }

    public String getNationalite() { return nationalite; }
    public void setNationalite(String nationalite) { this.nationalite = nationalite; }

    public String getAdresseMadagascar() { return adresseMadagascar; }
    public void setAdresseMadagascar(String adresseMadagascar) { this.adresseMadagascar = adresseMadagascar; }

    public String getProfession() { return profession; }
    public void setProfession(String profession) { this.profession = profession; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }

    public String getPasseportNumero() { return passeportNumero; }
    public void setPasseportNumero(String passeportNumero) { this.passeportNumero = passeportNumero; }

    public LocalDate getPasseportDateDelivrance() { return passeportDateDelivrance; }
    public void setPasseportDateDelivrance(LocalDate passeportDateDelivrance) { this.passeportDateDelivrance = passeportDateDelivrance; }

    public LocalDate getPasseportDateExpiration() { return passeportDateExpiration; }
    public void setPasseportDateExpiration(LocalDate passeportDateExpiration) { this.passeportDateExpiration = passeportDateExpiration; }

    public String getVisaReference() { return visaReference; }
    public void setVisaReference(String visaReference) { this.visaReference = visaReference; }

    public LocalDate getVisaDateEntree() { return visaDateEntree; }
    public void setVisaDateEntree(LocalDate visaDateEntree) { this.visaDateEntree = visaDateEntree; }

    public String getVisaLieuEntree() { return visaLieuEntree; }
    public void setVisaLieuEntree(String visaLieuEntree) { this.visaLieuEntree = visaLieuEntree; }

    public LocalDate getVisaDateExpiration() { return visaDateExpiration; }
    public void setVisaDateExpiration(LocalDate visaDateExpiration) { this.visaDateExpiration = visaDateExpiration; }

    public TypeVisa getTypeVisa() { return typeVisa; }
    public void setTypeVisa(TypeVisa typeVisa) { this.typeVisa = typeVisa; }

    public String getInformationsComplementaires() { return informationsComplementaires; }
    public void setInformationsComplementaires(String informationsComplementaires) { this.informationsComplementaires = informationsComplementaires; }

    public ObjectifDemande getObjectifDemande() { return objectifDemande; }
    public void setObjectifDemande(ObjectifDemande objectifDemande) { this.objectifDemande = objectifDemande; }

    public Dossier getDossier() { return dossier; }
    public void setDossier(Dossier dossier) { this.dossier = dossier; }

    public boolean isDonneesIncompletes() { return donneesIncompletes; }
    public void setDonneesIncompletes(boolean donneesIncompletes) { this.donneesIncompletes = donneesIncompletes; }

    public String getRemarques() { return remarques; }
    public void setRemarques(String remarques) { this.remarques = remarques; }
}
