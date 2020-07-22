/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datos;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import java.time.Month;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.UUID;
import javax.servlet.http.Part;

/**
 * Acceso a base de datos de Evento
 * 
 * @author gonzale
 * @author jorbarr
 * @author juangar
 * @author lucgonz
 */
public class EventoDB {

    /**
     *
     * @param lat1
     * @param lon1
     * @param lat2
     * @param lon2
     * @return
     */
    public static double distance(double lat1, double lon1, double lat2, double lon2) {
        if ((lat1 == lat2) && (lon1 == lon2)) {
            return 0;
        } else {
            double theta = lon1 - lon2;
            double dist = Math.sin(Math.toRadians(lat1)) * Math.sin(Math.toRadians(lat2)) + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) * Math.cos(Math.toRadians(theta));
            dist = Math.acos(dist);
            dist = Math.toDegrees(dist);
            dist = dist * 60 * 1.1515;
            dist = dist * 1.609344;
            return dist;
        }

    }

    /**
     * Buscamos todos los eventos de cualquier tipo en el rango de kilometros
     * indicado
     *
     * @param latitud
     * @param longitud
     * @param distancia
     * @return
     */
    public static Evento[] selectEventoOnlyByDistance(final double latitud, final double longitud, int distancia) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT e.*, t.nombreTipo "
                + "FROM EVENTO e, TIPODEEVENTO t "
                + "WHERE t.IdTipo = e.IdTipo";
        try {
            ps = connection.prepareStatement(query); //(query,Statement.RETURN_GENERATED_KEYS)
            rs = ps.executeQuery();
            ArrayList<Evento> eventos = new ArrayList<>();
            while (rs.next()) {
                Evento e = new Evento(rs.getString("Id"), rs.getString("Nombre"), rs.getString("LoginAnfitrion"), rs.getDate("FechaInicio").toLocalDate(), rs.getDate("FechaFin").toLocalDate(), TipoDeEvento.valueOf(rs.getString("nombreTipo")), rs.getString("Descripcion"), rs.getDouble("Latitud"), rs.getDouble("Longitud"), rs.getInt("Aforo"));
                eventos.add(e);
            }

            ArrayList<Evento> misEventos = new ArrayList<>();
            for (int i = 0; i < eventos.size(); i++) {
                if (distance(eventos.get(i).getLatitud(), eventos.get(i).getLongitud(), latitud, longitud) <= distancia) {
                    misEventos.add(eventos.get(i));
                }
            }

            //Ordenamos por cercania
            Collections.sort(misEventos, new Comparator<Evento>() {
                @Override
                public int compare(Evento e1, Evento e2) {
                    return Double.compare(distance(e1.getLatitud(), e1.getLongitud(), latitud, longitud), distance(e2.getLatitud(), e2.getLongitud(), latitud, longitud));
                }
            });
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return misEventos.toArray(new Evento[0]);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static int insert(Evento event) throws IOException {

        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String query = "INSERT INTO EVENTO (Id, LoginAnfitrion, Nombre, FechaInicio, FechaFin, Descripcion, IdTipo, Latitud, Longitud, Imagen, Aforo) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        try {
            ps = connection.prepareStatement(query);
            UUID idOne = UUID.randomUUID();
            ps.setString(1, idOne.toString());  //Random unique ID 
            ps.setString(2, event.getLoginAnfitrion());
            ps.setString(3, event.getNombre());

//            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d/MM/yyyy");
//            LocalDate dateInicio = event.getFechaInicio();
//            String fecha = dateInicio.toString();
//            String array[] = fecha.split("-");
//            String nuevo = array[2]+"/"+array[1]+"/"+array[0]; 
//            System.out.println(nuevo);
//            
//            LocalDate l = new LocalDate.of(nuevo);
            ps.setDate(4, java.sql.Date.valueOf(event.getFechaInicio()));

//            LocalDate dateFin = event.getFechaInicio();
//            String fecha2 = dateFin.toString();
//            String array2[] = fecha2.split("-");
//            String nuevo2 = array2[2]+"/"+array2[1]+"/"+array2[0];   
            ps.setDate(5, java.sql.Date.valueOf(event.getFechaFin()));

            ps.setString(6, event.getDescripcion());
            ps.setInt(7, Integer.valueOf(TipoDeEventoDB.selectIdTipoByNombreTipo(event.getTipo())));
            ps.setFloat(8, event.getLatitud().floatValue());
            ps.setFloat(9, event.getLongitud().floatValue());

            try {
                ps.setBlob(10, event.getImagen().getInputStream());
            } catch (IOException e) {
                e.printStackTrace();
            }
            //ps.setString(10, null);

            ps.setInt(11, event.getAforo());

            int res = ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
            return res;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    /**
     * Consultamos los 10 eventos mas cercanos de el tipo indicado
     *
     * @param latitud
     * @param longitud
     * @param distancia
     * @return
     */
    public static Evento[] selectEventoOnlyByType(final double latitud, final double longitud, TipoDeEvento tipo) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT e.*, t.nombreTipo "
                + "FROM EVENTO e, TIPODEEVENTO t "
                + "WHERE t.IdTipo = e.IdTipo AND t.nombreTipo = ?";

        try {
            ps = connection.prepareStatement(query); //(query,Statement.RETURN_GENERATED_KEYS)
            ps.setString(1, tipo.toString());
            rs = ps.executeQuery();
            ArrayList<Evento> misEventos = new ArrayList<>();
            while (rs.next()) {
                Evento e = new Evento(rs.getString("Id"), rs.getString("Nombre"), rs.getString("LoginAnfitrion"), rs.getDate("FechaInicio").toLocalDate(), rs.getDate("FechaFin").toLocalDate(), TipoDeEvento.valueOf(rs.getString("nombreTipo")), rs.getString("Descripcion"), rs.getDouble("Latitud"), rs.getDouble("Longitud"), rs.getInt("Aforo"));
                misEventos.add(e);
            }
            //Ordenamos por cercania
            Collections.sort(misEventos, new Comparator<Evento>() {
                @Override
                public int compare(Evento e1, Evento e2) {
                    return Double.compare(distance(e1.getLatitud(), e1.getLongitud(), latitud, longitud), distance(e2.getLatitud(), e2.getLongitud(), latitud, longitud));
                }
            });
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return misEventos.toArray(new Evento[0]);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static Evento[] selectEventoOnlyByName(final double latitud, final double longitud, String nombre) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT e.*, t.nombreTipo "
                + "FROM EVENTO e, TIPODEEVENTO t "
                + "WHERE t.IdTipo = e.IdTipo AND e.Nombre = ?";

        try {
            ps = connection.prepareStatement(query); //(query,Statement.RETURN_GENERATED_KEYS)
            ps.setString(1, nombre);
            rs = ps.executeQuery();
            ArrayList<Evento> misEventos = new ArrayList<>();
            while (rs.next()) {
                Evento e = new Evento(rs.getString("Id"), rs.getString("Nombre"), rs.getString("LoginAnfitrion"), rs.getDate("FechaInicio").toLocalDate(), rs.getDate("FechaFin").toLocalDate(), TipoDeEvento.valueOf(rs.getString("nombreTipo")), rs.getString("Descripcion"), rs.getDouble("Latitud"), rs.getDouble("Longitud"), rs.getInt("Aforo"));
                misEventos.add(e);
            }
            //Ordenamos por cercania
            Collections.sort(misEventos, new Comparator<Evento>() {
                @Override
                public int compare(Evento e1, Evento e2) {
                    return Double.compare(distance(e1.getLatitud(), e1.getLongitud(), latitud, longitud), distance(e2.getLatitud(), e2.getLongitud(), latitud, longitud));
                }
            });
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return misEventos.toArray(new Evento[0]);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static Evento[] selectEventoOnlyByDateStart(final double latitud, final double longitud, LocalDate fechaInicio) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT e.*, t.nombreTipo "
                + "FROM EVENTO e, TIPODEEVENTO t "
                + "WHERE t.IdTipo = e.IdTipo AND e.FechaInicio >= ?";

        try {
            ps = connection.prepareStatement(query); //(query,Statement.RETURN_GENERATED_KEYS)
            ps.setString(1, fechaInicio.toString());
            rs = ps.executeQuery();
            ArrayList<Evento> misEventos = new ArrayList<>();
            while (rs.next()) {
                Evento e = new Evento(rs.getString("Id"), rs.getString("Nombre"), rs.getString("LoginAnfitrion"), rs.getDate("FechaInicio").toLocalDate(), rs.getDate("FechaFin").toLocalDate(), TipoDeEvento.valueOf(rs.getString("nombreTipo")), rs.getString("Descripcion"), rs.getDouble("Latitud"), rs.getDouble("Longitud"), rs.getInt("Aforo"));
                misEventos.add(e);
            }
            //Ordenamos por cercania
            Collections.sort(misEventos, new Comparator<Evento>() {
                @Override
                public int compare(Evento e1, Evento e2) {
                    return Double.compare(distance(e1.getLatitud(), e1.getLongitud(), latitud, longitud), distance(e2.getLatitud(), e2.getLongitud(), latitud, longitud));
                }
            });
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return misEventos.toArray(new Evento[0]);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static Evento[] selectEventoOnlyByDateStartSortByDate (final double latitud, final double longitud, LocalDate fechaInicio) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT e.*, t.nombreTipo "
                + "FROM EVENTO e, TIPODEEVENTO t "
                + "WHERE t.IdTipo = e.IdTipo AND e.FechaInicio >= ?";

        try {
            ps = connection.prepareStatement(query); //(query,Statement.RETURN_GENERATED_KEYS)
            ps.setString(1, fechaInicio.toString());
            rs = ps.executeQuery();
            ArrayList<Evento> misEventos = new ArrayList<>();
            while (rs.next()) {
                Evento e = new Evento(rs.getString("Id"), rs.getString("Nombre"), rs.getString("LoginAnfitrion"), rs.getDate("FechaInicio").toLocalDate(), rs.getDate("FechaFin").toLocalDate(), TipoDeEvento.valueOf(rs.getString("nombreTipo")), rs.getString("Descripcion"), rs.getDouble("Latitud"), rs.getDouble("Longitud"), rs.getInt("Aforo"));
                misEventos.add(e);
            }
            //Ordenamos por cercania
            Collections.sort(misEventos, new Comparator<Evento>() {
                @Override
                public int compare(Evento e1, Evento e2) {
                    return e1.getFechaInicio().compareTo(e2.getFechaInicio());
                }
            });
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return misEventos.toArray(new Evento[0]);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static Evento[] selectEventoOnlyByDateEnd(final double latitud, final double longitud, LocalDate fechaFin) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT e.*, t.nombreTipo "
                + "FROM EVENTO e, TIPODEEVENTO t "
                + "WHERE t.IdTipo = e.IdTipo AND e.FechaFin <= ?";

        try {
            ps = connection.prepareStatement(query); //(query,Statement.RETURN_GENERATED_KEYS)
            ps.setString(1, fechaFin.toString());
            rs = ps.executeQuery();
            ArrayList<Evento> misEventos = new ArrayList<>();
            while (rs.next()) {
                Evento e = new Evento(rs.getString("Id"), rs.getString("Nombre"), rs.getString("LoginAnfitrion"), rs.getDate("FechaInicio").toLocalDate(), rs.getDate("FechaFin").toLocalDate(), TipoDeEvento.valueOf(rs.getString("nombreTipo")), rs.getString("Descripcion"), rs.getDouble("Latitud"), rs.getDouble("Longitud"), rs.getInt("Aforo"));
                misEventos.add(e);
            }
            //Ordenamos por cercania
            Collections.sort(misEventos, new Comparator<Evento>() {
                @Override
                public int compare(Evento e1, Evento e2) {
                    return Double.compare(distance(e1.getLatitud(), e1.getLongitud(), latitud, longitud), distance(e2.getLatitud(), e2.getLongitud(), latitud, longitud));
                }
            });
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return misEventos.toArray(new Evento[0]);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void getImagen(String id, OutputStream respuesta) throws IOException {

        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT e.Imagen "
                + "FROM EVENTO e "
                + "WHERE e.Id = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                Blob blob = rs.getBlob("Imagen");
                if (!rs.wasNull() && blob.length() > 1) {
                    InputStream imagen = blob.getBinaryStream();
                    byte[] buffer = new byte[1000];
                    int len = imagen.read(buffer);
                    while (len != -1) {
                        respuesta.write(buffer, 0, len);
                        len = imagen.read(buffer);
                    }
                    imagen.close();
                }
            }
            pool.freeConnection(connection);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static Evento selectEventoById(String id) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT e.*, t.nombreTipo "
                + "FROM EVENTO e, TIPODEEVENTO t "
                + "WHERE t.IdTipo = e.IdTipo AND e.Id = ?";
        try {
            ps = connection.prepareStatement(query); //(query,Statement.RETURN_GENERATED_KEYS)
            ps.setString(1, id);
            rs = ps.executeQuery();
            Cliente cliente = null;
            Evento e = null;
            if (rs.next()) {
                e = new Evento(rs.getString("Id"), rs.getString("Nombre"), rs.getString("LoginAnfitrion"), rs.getDate("FechaInicio").toLocalDate(), rs.getDate("FechaFin").toLocalDate(), TipoDeEvento.valueOf(rs.getString("nombreTipo")), rs.getString("Descripcion"), rs.getDouble("Latitud"), rs.getDouble("Longitud"), rs.getInt("Aforo"));
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return e;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static Evento[] selectEventoByLoginAnfitrion(String loginAnfitrion) throws IOException {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT e.*, t.nombreTipo "
                + "FROM EVENTO e, TIPODEEVENTO t "
                + "WHERE t.IdTipo = e.IdTipo AND e.LoginAnfitrion = ?";
        try {
            ps = connection.prepareStatement(query); //(query,Statement.RETURN_GENERATED_KEYS)
            ps.setString(1, loginAnfitrion);
            rs = ps.executeQuery();
            Cliente cliente = null;
            ArrayList<Evento> misEventos = new ArrayList<>();
            while (rs.next()) {       
                Evento e = new Evento(rs.getString("Id"), rs.getString("Nombre"), rs.getString("LoginAnfitrion"), rs.getDate("FechaInicio").toLocalDate(), rs.getDate("FechaFin").toLocalDate(), TipoDeEvento.valueOf(rs.getString("nombreTipo")), rs.getString("Descripcion"), rs.getDouble("Latitud"), rs.getDouble("Longitud"), rs.getInt("Aforo"));
                misEventos.add(e);
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return misEventos.toArray(new Evento[0]);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static void removeEventByIdAndLoginAnfitrion(String loginAnfitrion, String id){
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String query = "DELETE FROM EVENTO WHERE LoginAnfitrion = ? AND Id = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1,loginAnfitrion);
            ps.setString(2, id);
            ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
        } catch (SQLException e){
            e.printStackTrace();
        }
    }
    
    public static void editEventByIdAndLoginAnfitrion(Evento modificacion, String id){
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String query = "UPDATE EVENTO SET Nombre = ?, FechaInicio = ?, FechaFin = ?, Descripcion = ?, IdTipo = ?, Latitud = ?, Longitud = ?, Imagen = ?, Aforo = ? WHERE Id = ? AND LoginAnfitrion = ?";
        try{
            ps = connection.prepareStatement(query);
            ps.setString(1, modificacion.getNombre());
            ps.setDate(2, java.sql.Date.valueOf(modificacion.getFechaInicio()));
            ps.setDate(3, java.sql.Date.valueOf(modificacion.getFechaFin()));
            ps.setString(4,modificacion.getDescripcion());
            ps.setInt(5, Integer.valueOf(TipoDeEventoDB.selectIdTipoByNombreTipo(modificacion.getTipo())));
            ps.setFloat(6, modificacion.getLatitud().floatValue());
            ps.setFloat(7,modificacion.getLongitud().floatValue());
            try {
                ps.setBlob(8, modificacion.getImagen().getInputStream());
            } catch (IOException e) {
                e.printStackTrace();
            }
            ps.setInt(9, modificacion.getAforo());
            ps.setString(10,id);
            ps.setString(11, modificacion.getLoginAnfitrion());
            ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
        }catch(SQLException e){
            e.printStackTrace();
        }
    }
}
