package mg.visa.front.dao;

import mg.visa.front.Db;
import mg.visa.front.model.TypeVisa;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TypeVisaDao {

    public List<TypeVisa> findAll() throws SQLException {
        List<TypeVisa> list = new ArrayList<>();
        String sql = "SELECT id, code, libelle, description FROM type_visa ORDER BY libelle";
        try (Connection conn = Db.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new TypeVisa(
                    rs.getLong("id"),
                    rs.getString("code"),
                    rs.getString("libelle"),
                    rs.getString("description")
                ));
            }
        }
        return list;
    }

    public TypeVisa findById(long id) throws SQLException {
        String sql = "SELECT id, code, libelle, description FROM type_visa WHERE id = ?";
        try (Connection conn = Db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new TypeVisa(
                        rs.getLong("id"),
                        rs.getString("code"),
                        rs.getString("libelle"),
                        rs.getString("description")
                    );
                }
            }
        }
        return null;
    }
}
