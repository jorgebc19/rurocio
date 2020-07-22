/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Acceso a base de datos de Anfitrion
 * 
 * @author gonzale
 * @author jorbarr
 * @author juangar
 * @author lucgonz
 */
public class AnfitrionDB {
    public static int insert(Anfitrion usuario, String password) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String queryUsuario = "INSERT INTO USUARIO (Login, Nombre, Email, Password) VALUES (?,?,?,?)";
        String queryAnfitrion = "INSERT INTO ANFITRION (Login, CIF) VALUES (?,?)";
        try{
            ps = connection.prepareStatement(queryUsuario);
            ps.setString(1, usuario.getLogin());
            ps.setString(2, usuario.getNombre());
            ps.setString(3, usuario.getEmail());
            ps.setString(4, password);
            int res = ps.executeUpdate();
            
            ps = connection.prepareStatement(queryAnfitrion);
            ps.setString(1, usuario.getLogin());
            ps.setString(2, usuario.getCif());
            res += ps.executeUpdate();
            
            ps.close();
            pool.freeConnection(connection);
            return res;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public static Anfitrion selectAnfitrion (String login, String password) {
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT * FROM ANFITRION A, USUARIO U WHERE A.Login = U.Login AND U.Login = ? AND U.Password = ?";

        try{
            ps = connection.prepareStatement(query); //(query,Statement.RETURN_GENERATED_KEYS)
            ps.setString(1, login);
            ps.setString(2, password);
            rs = ps.executeQuery();
            Anfitrion anfitrion = null;
            if (rs.next()){
                anfitrion = new Anfitrion(login, rs.getString("Nombre"), rs.getString("CIF"), rs.getString("Email"));
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return anfitrion;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
