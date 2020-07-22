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
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;

/**
 * Acceso a base de datos de Cliente
 * 
 * @author gonzale
 * @author jorbarr
 * @author juangar
 * @author lucgonz
 */
public class ClienteDB {
    public static int insert(Cliente usuario, String password) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String queryUsuario = "INSERT INTO USUARIO (Login, Nombre, Email, Password) VALUES (?,?,?,?)";
        String queryCliente = "INSERT INTO CLIENTE (Login, NIF, FechaNacimiento) VALUES (?,?,?)";
        try{
            ps = connection.prepareStatement(queryUsuario);
            ps.setString(1, usuario.getLogin());
            ps.setString(2, usuario.getNombre());
            ps.setString(3, usuario.getEmail());
            ps.setString(4, password);
            int res = ps.executeUpdate();
            
            ps = connection.prepareStatement(queryCliente);
            ps.setString(1, usuario.getLogin());
            ps.setString(2, usuario.getNif());
            ps.setString(3, usuario.getFechaNacimiento().toString());
            res += ps.executeUpdate();
            
            ps.close();
            pool.freeConnection(connection);
            return res;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public static Cliente selectClient (String login, String password) {
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT * FROM CLIENTE C, USUARIO U WHERE C.Login = U.Login AND U.Login = ? AND U.Password = ?";

        try{
            ps = connection.prepareStatement(query); //(query,Statement.RETURN_GENERATED_KEYS)
            ps.setString(1, login);
            ps.setString(2, password);
            rs = ps.executeQuery();
            Cliente cliente = null;
            if (rs.next()){
                cliente = new Cliente(login, rs.getString("Nombre"), rs.getString("NIF"), rs.getString("Email"), rs.getDate("FechaNacimiento").toLocalDate());
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return cliente;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static Cliente[] selectClientByEvent (String eventId) {
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT U.Login, U.Nombre, U.Email, C.NIF, C.FechaNacimiento "
                + "FROM CLIENTE C, USUARIO U, RESERVA R "
                + "WHERE C.Login = U.Login AND R.IdEvento = ? AND R.LoginCliente = C.Login";

        try{
            ps = connection.prepareStatement(query); //(query,Statement.RETURN_GENERATED_KEYS)
            ps.setString(1, eventId);
            rs = ps.executeQuery();
            Cliente cliente = null;
            
            ArrayList<Cliente> listaInscritos = new ArrayList<>();
            
            while (rs.next()){
                cliente = new Cliente(rs.getString("Login"), rs.getString("Nombre"), rs.getString("NIF"), rs.getString("Email"), rs.getDate("FechaNacimiento").toLocalDate());
                listaInscritos.add(cliente);
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return listaInscritos.toArray(new Cliente[0]);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
