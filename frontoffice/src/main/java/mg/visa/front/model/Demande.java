package mg.visa.front.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Demande {
    private long id;
    private String numeroDemande;
    private LocalDateTime dateCreation;
    private String statut;

    private String nom;
    private String prenom;
    private String nomJeuneFille;
    private String situationFamiliale;
    private String nationalite;
    private String adresseMadagascar;
    private String profession;
    private String contact;

    private String passeportNumero;
    private LocalDate passeportDateDelivrance;
    private LocalDate passeportDateExpiration;

    private String visaReference;
    private LocalDate visaDateEntree;
    private String visaLieuEntree;
    private LocalDate visaDateExpiration;

    private long typeVisaId;
    private String typeVisaLibelle;
    private String informationsComplementaires;
    private String objectifDemande;

    private boolean donneesIncompletes;
    private String remarques;

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public String getNumeroDemande() { return numeroDemande; }
    public void setNumeroDemande(String numeroDemande) { this.numeroDemande = numeroDemande; }
    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }
    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }
    public String getNomJeuneFille() { return nomJeuneFille; }
    public void setNomJeuneFille(String nomJeuneFille) { this.nomJeuneFille = nomJeuneFille; }
    public String getSituationFamiliale() { return situationFamiliale; }
    public void setSituationFamiliale(String situationFamiliale) { this.situationFamiliale = situationFamiliale; }
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
    public long getTypeVisaId() { return typeVisaId; }
    public void setTypeVisaId(long typeVisaId) { this.typeVisaId = typeVisaId; }
    public String getTypeVisaLibelle() { return typeVisaLibelle; }
    public void setTypeVisaLibelle(String typeVisaLibelle) { this.typeVisaLibelle = typeVisaLibelle; }
    public String getInformationsComplementaires() { return informationsComplementaires; }
    public void setInformationsComplementaires(String informationsComplementaires) { this.informationsComplementaires = informationsComplementaires; }
    public String getObjectifDemande() { return objectifDemande; }
    public void setObjectifDemande(String objectifDemande) { this.objectifDemande = objectifDemande; }
    public boolean isDonneesIncompletes() { return donneesIncompletes; }
    public void setDonneesIncompletes(boolean donneesIncompletes) { this.donneesIncompletes = donneesIncompletes; }
    public String getRemarques() { return remarques; }
    public void setRemarques(String remarques) { this.remarques = remarques; }

    public String getStatutLibelle() {
        if (statut == null) return "";
        switch (statut) {
            case "SOUMISE": return "Soumise";
            case "EN_COURS": return "En cours de traitement";
            case "VALIDEE": return "Valid\u00e9e";
            case "REJETEE": return "Rejet\u00e9e";
            case "INCOMPLETE": return "Incompl\u00e8te";
            default: return statut;
        }
    }

    public String getStatutBadge() {
        if (statut == null) return "bg-secondary";
        switch (statut) {
            case "SOUMISE": return "bg-info";
            case "EN_COURS": return "bg-warning";
            case "VALIDEE": return "bg-success";
            case "REJETEE": return "bg-danger";
            case "INCOMPLETE": return "bg-secondary";
            default: return "bg-secondary";
        }
    }

    public String getObjectifLibelle() {
        if (objectifDemande == null) return "";
        switch (objectifDemande) {
            case "CARTE_RESIDENT": return "Carte de r\u00e9sident";
            case "VISA": return "Visa";
            case "DUPLICATA_CARTE": return "Duplicata de carte";
            case "TRANSFERT_VISA": return "Transfert de visa";
            default: return objectifDemande;
        }
    }

    public String getSituationLibelle() {
        if (situationFamiliale == null) return "";
        switch (situationFamiliale) {
            case "CELIBATAIRE": return "C\u00e9libataire";
            case "MARIE": return "Mari\u00e9(e)";
            case "DIVORCE": return "Divorc\u00e9(e)";
            case "VEUF": return "Veuf/Veuve";
            default: return situationFamiliale;
        }
    }
}
