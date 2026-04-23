package mg.visa.front.dao;

import mg.visa.front.Db;
import mg.visa.front.model.Demande;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class DemandeDao {

    public String insert(Demande d) throws SQLException {
        String numeroDemande = genererNumeroDemande();
        boolean isDuplicataOuTransfert = "DUPLICATA_CARTE".equals(d.getObjectifDemande())
                || "TRANSFERT_VISA".equals(d.getObjectifDemande());

        String statut = isDuplicataOuTransfert ? "APPROUVEE" : "SOUMISE";
        Long dossierId = null;

        if (isDuplicataOuTransfert) {
            dossierId = trouverOuCreerDossier(d);
        }

        String sql = "INSERT INTO demande (numero_demande, date_creation, statut, " +
                "nom, prenom, nom_jeune_fille, situation_familiale, nationalite, adresse_madagascar, profession, contact, " +
                "passeport_numero, passeport_date_delivrance, passeport_date_expiration, " +
                "visa_reference, visa_date_entree, visa_lieu_entree, visa_date_expiration, " +
                "type_visa_id, informations_complementaires, objectif_demande, donnees_incompletes, dossier_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, false, ?)";

        try (Connection conn = Db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, numeroDemande);
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setString(3, statut);
            ps.setString(4, d.getNom());
            ps.setString(5, d.getPrenom());
            ps.setString(6, d.getNomJeuneFille());
            ps.setString(7, d.getSituationFamiliale());
            ps.setString(8, d.getNationalite());
            ps.setString(9, d.getAdresseMadagascar());
            ps.setString(10, d.getProfession());
            ps.setString(11, d.getContact());
            ps.setString(12, d.getPasseportNumero());
            ps.setDate(13, d.getPasseportDateDelivrance() != null ? Date.valueOf(d.getPasseportDateDelivrance()) : null);
            ps.setDate(14, d.getPasseportDateExpiration() != null ? Date.valueOf(d.getPasseportDateExpiration()) : null);
            ps.setString(15, d.getVisaReference());
            ps.setDate(16, d.getVisaDateEntree() != null ? Date.valueOf(d.getVisaDateEntree()) : null);
            ps.setString(17, d.getVisaLieuEntree());
            ps.setDate(18, d.getVisaDateExpiration() != null ? Date.valueOf(d.getVisaDateExpiration()) : null);
            ps.setLong(19, d.getTypeVisaId());
            ps.setString(20, d.getInformationsComplementaires());
            ps.setString(21, d.getObjectifDemande());
            if (dossierId != null) {
                ps.setLong(22, dossierId);
            } else {
                ps.setNull(22, java.sql.Types.BIGINT);
            }
            ps.executeUpdate();
        }
        return numeroDemande;
    }

    public Demande findByNumeroDemande(String numeroDemande) throws SQLException {
        String sql = "SELECT d.*, tv.libelle as type_visa_libelle, dos.numero_dossier FROM demande d " +
                "LEFT JOIN type_visa tv ON d.type_visa_id = tv.id " +
                "LEFT JOIN dossier dos ON d.dossier_id = dos.id " +
                "WHERE d.numero_demande = ?";
        try (Connection conn = Db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, numeroDemande);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        }
        return null;
    }

    private Demande mapRow(ResultSet rs) throws SQLException {
        Demande d = new Demande();
        d.setId(rs.getLong("id"));
        d.setNumeroDemande(rs.getString("numero_demande"));
        Timestamp ts = rs.getTimestamp("date_creation");
        if (ts != null) d.setDateCreation(ts.toLocalDateTime());
        d.setStatut(rs.getString("statut"));
        d.setNom(rs.getString("nom"));
        d.setPrenom(rs.getString("prenom"));
        d.setNomJeuneFille(rs.getString("nom_jeune_fille"));
        d.setSituationFamiliale(rs.getString("situation_familiale"));
        d.setNationalite(rs.getString("nationalite"));
        d.setAdresseMadagascar(rs.getString("adresse_madagascar"));
        d.setProfession(rs.getString("profession"));
        d.setContact(rs.getString("contact"));
        d.setPasseportNumero(rs.getString("passeport_numero"));
        Date dd = rs.getDate("passeport_date_delivrance");
        if (dd != null) d.setPasseportDateDelivrance(dd.toLocalDate());
        Date de = rs.getDate("passeport_date_expiration");
        if (de != null) d.setPasseportDateExpiration(de.toLocalDate());
        d.setVisaReference(rs.getString("visa_reference"));
        Date ve = rs.getDate("visa_date_entree");
        if (ve != null) d.setVisaDateEntree(ve.toLocalDate());
        d.setVisaLieuEntree(rs.getString("visa_lieu_entree"));
        Date vx = rs.getDate("visa_date_expiration");
        if (vx != null) d.setVisaDateExpiration(vx.toLocalDate());
        d.setTypeVisaId(rs.getLong("type_visa_id"));
        d.setTypeVisaLibelle(rs.getString("type_visa_libelle"));
        d.setInformationsComplementaires(rs.getString("informations_complementaires"));
        d.setObjectifDemande(rs.getString("objectif_demande"));
        d.setDonneesIncompletes(rs.getBoolean("donnees_incompletes"));
        d.setRemarques(rs.getString("remarques"));
        long dosId = rs.getLong("dossier_id");
        if (!rs.wasNull()) d.setDossierId(dosId);
        try { d.setNumeroDossier(rs.getString("numero_dossier")); } catch (SQLException ignored) {}
        return d;
    }

    private Long trouverOuCreerDossier(Demande d) throws SQLException {
        String selectSql = "SELECT id FROM dossier WHERE passeport_numero = ?";
        try (Connection conn = Db.getConnection();
             PreparedStatement ps = conn.prepareStatement(selectSql)) {
            ps.setString(1, d.getPasseportNumero());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getLong("id");
            }
        }

        String numeroDossier = genererNumeroDossier();
        String insertSql = "INSERT INTO dossier (numero_dossier, date_creation, passeport_numero, nom, prenom, nationalite, type_dossier) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?) RETURNING id";
        try (Connection conn = Db.getConnection();
             PreparedStatement ps = conn.prepareStatement(insertSql)) {
            ps.setString(1, numeroDossier);
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setString(3, d.getPasseportNumero());
            ps.setString(4, d.getNom());
            ps.setString(5, d.getPrenom());
            ps.setString(6, d.getNationalite());
            ps.setString(7, d.getObjectifDemande());
            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                return rs.getLong("id");
            }
        }
    }

    private String genererNumeroDossier() throws SQLException {
        String prefix = "DOS-" + java.time.LocalDateTime.now().format(
                java.time.format.DateTimeFormatter.ofPattern("yyyyMM"));
        long count = 0;
        try (Connection conn = Db.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM dossier")) {
            if (rs.next()) count = rs.getLong(1);
        }
        return prefix + "-" + String.format("%04d", count + 1);
    }

    private String genererNumeroDemande() throws SQLException {
        String prefix = "VT-" + java.time.LocalDateTime.now().format(
                java.time.format.DateTimeFormatter.ofPattern("yyyyMM"));
        long count = 0;
        try (Connection conn = Db.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM demande")) {
            if (rs.next()) count = rs.getLong(1);
        }
        return prefix + "-" + String.format("%04d", count + 1);
    }
}
