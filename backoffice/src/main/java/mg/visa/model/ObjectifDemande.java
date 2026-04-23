package mg.visa.model;

public enum ObjectifDemande {
    CARTE_RESIDENT("Carte de résident"),
    VISA("Visa"),
    DUPLICATA_CARTE("Duplicata de carte"),
    TRANSFERT_VISA("Transfert de visa");

    private final String libelle;

    ObjectifDemande(String libelle) {
        this.libelle = libelle;
    }

    public String getLibelle() {
        return libelle;
    }
}
