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
 * Acceso a base de datos de Tipo de Evento
 * 
 * @author gonzale
 * @author jorbarr
 * @author juangar
 * @author lucgonz
 */
public class TipoDeEventoDB {
    public static String selectIdTipoByNombreTipo (String nombreTipo) {
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT IdTipo FROM TIPODEEVENTO WHERE nombreTipo = ?";

        try{
            ps = connection.prepareStatement(query); //(query,Statement.RETURN_GENERATED_KEYS)
            ps.setString(1, nombreTipo);
            rs = ps.executeQuery();
            String idTipo = null;
            if (rs.next()){
                idTipo = Integer.toString(rs.getInt("IdTipo"));
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return idTipo;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
