package gestionhotelera;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JOptionPane;

public class Conexion {
    Connection conectar = null;
    String usuario = "root";
    String contrasenia = "1234";
    String bd = "basedatoshotel";
    String ip = "localhost";
    String puerto = "3306";

    String cadena = "jdbc:mysql://" + ip + ":" + puerto + "/" + bd + "?useSSL=false&serverTimezone=UTC";

    public Connection estableceConexion() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conectar = DriverManager.getConnection(cadena, usuario, contrasenia);
        } catch (ClassNotFoundException | SQLException e) {
            JOptionPane.showMessageDialog(null, "No se conectó a la base de datos, error: " + e.toString());
        }
        return conectar;
    }
}