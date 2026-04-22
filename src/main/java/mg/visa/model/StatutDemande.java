package mg.visa.model;

public enum StatutDemande {
    SOUMISE("Soumise", "bg-info"),
    EN_COURS("En cours de traitement", "bg-warning"),
    VALIDEE("Validée", "bg-success"),
    REJETEE("Rejetée", "bg-danger"),
    INCOMPLETE("Incomplète", "bg-secondary");

    private final String libelle;
    private final String badgeClass;

    StatutDemande(String libelle, String badgeClass) {
        this.libelle = libelle;
        this.badgeClass = badgeClass;
    }

    public String getLibelle() {
        return libelle;
    }

    public String getBadgeClass() {
        return badgeClass;
    }
}
