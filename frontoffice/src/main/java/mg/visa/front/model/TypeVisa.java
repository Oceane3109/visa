package mg.visa.front.model;

public class TypeVisa {
    private long id;
    private String code;
    private String libelle;
    private String description;

    public TypeVisa() {}

    public TypeVisa(long id, String code, String libelle, String description) {
        this.id = id;
        this.code = code;
        this.libelle = libelle;
        this.description = description;
    }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    public String getLibelle() { return libelle; }
    public void setLibelle(String libelle) { this.libelle = libelle; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
