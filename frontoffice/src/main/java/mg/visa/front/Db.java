package mg.visa.front;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class Db {
    private Db() {}

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("PostgreSQL Driver not found", e);
        }
        String url = "jdbc:postgresql://localhost:5432/visa";
        String user = "oceanechristodoulou";
        String password = "";
        return DriverManager.getConnection(url, user, password);
    }
}
