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
import java.util.ArrayList;

/**
 * Acceso a base de datos de Reserva
 * 
 * @author gonzale
 * @author jorbarr
 * @author juangar
 * @author lucgonz
 */
public class ReservaDB {
    
     public static int insert(Reserva reserva) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String query = "INSERT INTO RESERVA (LoginCliente, IdEvento, Valoracion) VALUES (?,?,?)";
        try{
            ps = connection.prepareStatement(query);
            ps.setString(1, reserva.getLoginCliente());
            ps.setString(2, reserva.getIdEvento());
            ps.setString(3, Float.toString(reserva.getValoracion()));
            int res =ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
            return res;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public static Reserva getReserva(String loginCliente, String IdEvento) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT * FROM RESERVA WHERE LoginCliente = ? AND IdEvento = ?";
        try{
            ps = connection.prepareStatement(query);
            ps.setString(1, loginCliente);
            ps.setString(2, IdEvento);
            rs = ps.executeQuery();
            Reserva reserva = null;
            if (rs.next()) {
                reserva = new Reserva(loginCliente, IdEvento, rs.getFloat("Valoracion"));
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return reserva;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static Reserva[] selectReservaByIdCliente(String idCliente) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT R.LoginCliente, R.IdEvento, R.Valoracion FROM RESERVA R WHERE R.LoginCliente = ?";
        try{
            ps = connection.prepareStatement(query); //(query,Statement.RETURN_GENERATED_KEYS)
            ps.setString(1, idCliente);
            rs = ps.executeQuery();
            Cliente cliente = null;
            ArrayList<Reserva> misReservas = new ArrayList<>();
            while (rs.next()){
                Reserva e = new Reserva(rs.getString("LoginCliente"), rs.getString("IdEvento"), rs.getInt("Valoracion"));
                misReservas.add(e);
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return misReservas.toArray(new Reserva[0]);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static Reserva addValoracion(String id, String idCliente, float valoracion) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        int rs;
        String query = "UPDATE RESERVA SET Valoracion=? WHERE LoginCliente=? AND IdEvento=?";
        try{
            ps = connection.prepareStatement(query);
            ps.setFloat(1, valoracion);
            ps.setString(2, idCliente);
            ps.setString(3, id);
            rs = ps.executeUpdate();
            Reserva reserva = null;
            if (rs >= 0) {
                reserva = new Reserva(idCliente, id, valoracion);
            }
            ps.close();
            pool.freeConnection(connection);
            return reserva;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static void removeReservaByIdAndLoginCliente(String login, String id){
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String query = "DELETE FROM RESERVA WHERE LoginCliente = ? AND IdEvento = ?";
        try{
            ps = connection.prepareStatement(query);
            ps.setString(1,login);
            ps.setString(2,id);
            ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
        } catch (SQLException e){
            e.printStackTrace();
        }
    }
    
    public static void removeReservasById(String id){
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String query = "DELETE FROM RESERVA WHERE IdEvento = ?";
        try{
            ps = connection.prepareStatement(query);
            ps.setString(1, id);
            ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
        } catch (SQLException e){
            e.printStackTrace();
        }
    }
}
