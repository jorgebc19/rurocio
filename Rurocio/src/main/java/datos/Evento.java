/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datos;

import java.time.LocalDate;
import javax.servlet.http.Part;

/**
 * Modelo de Evento
 * 
 * @author gonzale
 * @author jorbarr
 * @author juangar
 * @author lucgonz
 */
public class Evento{
    private String id;
    private String loginAnfitrion;
    private String nombre;
    private LocalDate fechaInicio;
    private LocalDate fechaFin;
    private String descripcion;
    private TipoDeEvento tipo;
    private double[] coordenadas;
    private Part imagen;
    private int aforo;
    
    /**
     * 
     * @param nombre
     * @param loginAnfitrion
     * @param fechaInicio
     * @param fechaFin
     * @param tipo
     * @param descripcion
     * @param latitud
     * @param longitud
     * @param imagen
     * @param aforo 
     */
    public Evento (String nombre, String loginAnfitrion, LocalDate fechaInicio, LocalDate fechaFin, TipoDeEvento tipo, String descripcion, double latitud, double longitud, Part imagen, int aforo){
        this.nombre = nombre;
        this.loginAnfitrion = loginAnfitrion;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.descripcion = descripcion;
        this.tipo = tipo;
        this.coordenadas = new double[] {latitud, longitud};
        this.imagen = imagen;
        this.aforo = aforo;
    }
    
    /**
     * 
     * @param nombre
     * @param loginAnfitrion
     * @param fechaInicio
     * @param fechaFin
     * @param tipo
     * @param descripcion
     * @param latitud
     * @param longitud
     * @param aforo 
     */
    public Evento (String nombre, String loginAnfitrion, LocalDate fechaInicio, LocalDate fechaFin, TipoDeEvento tipo, String descripcion, double latitud, double longitud, int aforo){
        this.nombre = nombre;
        this.loginAnfitrion = loginAnfitrion;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.descripcion = descripcion;
        this.tipo = tipo;
        this.coordenadas = new double[] {latitud, longitud};
        this.aforo = aforo;
    }
    
    /**
     * 
     * @param id
     * @param nombre
     * @param loginAnfitrion
     * @param fechaInicio
     * @param fechaFin
     * @param tipo
     * @param descripcion
     * @param latitud
     * @param longitud
     * @param imagen
     * @param aforo 
     */
    public Evento (String id, String nombre, String loginAnfitrion, LocalDate fechaInicio, LocalDate fechaFin, TipoDeEvento tipo, String descripcion, double latitud, double longitud, Part imagen, int aforo){
        this.id = id;
        this.nombre = nombre;
        this.loginAnfitrion = loginAnfitrion;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.descripcion = descripcion;
        this.tipo = tipo;
        this.coordenadas = new double[] {latitud, longitud};
        this.imagen = imagen;
        this.aforo = aforo;
    }
    
    /**
     * 
     * @param id
     * @param nombre
     * @param loginAnfitrion
     * @param fechaInicio
     * @param fechaFin
     * @param tipo
     * @param descripcion
     * @param latitud
     * @param longitud
     * @param imagen
     * @param aforo 
     */
    public Evento (String id, String nombre, String loginAnfitrion, LocalDate fechaInicio, LocalDate fechaFin, TipoDeEvento tipo, String descripcion, double latitud, double longitud, int aforo){
        this.id = id;
        this.nombre = nombre;
        this.loginAnfitrion = loginAnfitrion;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.descripcion = descripcion;
        this.tipo = tipo;
        this.coordenadas = new double[] {latitud, longitud};
        this.aforo = aforo;
    }


    /**
     * 
     * @return 
     */
    public String getId() {
        return id;
    }
    
    /**
     * 
     * @return 
     */
    public String getNombre() {
        return nombre;
    }
    
    /**
     * 
     * @return 
     */
    public String getLoginAnfitrion() {
        return loginAnfitrion;
    }

    /**
     * 
     * @return 
     */
    public String getTipo() {
        return tipo.toString();
    }
    
    /**
     * 
     * @return 
     */
    public LocalDate getFechaInicio() {
        return fechaInicio; //Comprobar la fecha de retorno
    }
    
    /**
     * 
     * @return 
     */
    public LocalDate getFechaFin() {
        return fechaFin; //Comporbar la fecha de retorno
    }
    
    /**
     * 
     * @return 
     */
    public String getDescripcion() {
        return descripcion;
    }
    
    /**
     * 
     * @return 
     */
    public Double getLatitud() {
        return coordenadas[0];
    }
    
    /**
     * 
     * @return 
     */
    public Double getLongitud() {
        return coordenadas[1];
    }
    
    /**
     * 
     * @return 
     */
    public Part getImagen() {
        return imagen;
    }
    
    /**
     * 
     * @return 
     */
    public int getAforo() {
        return aforo;
    }
}
