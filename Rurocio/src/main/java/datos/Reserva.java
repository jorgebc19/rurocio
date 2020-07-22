/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datos;

/**
 * Modelo de Reserva
 * 
 * @author gonzale
 * @author jorbarr
 * @author juangar
 * @author lucgonz
 */
public class Reserva {
    private String loginCliente;
    private String idEvento;
    private float valoracion;
    
    public Reserva (String loginCliente, String idEvento, float valoracion){
        this.loginCliente = loginCliente;
        this.idEvento = idEvento;
        this.valoracion = valoracion;
    }
    
    public Reserva (String loginCliente, String idEvento){
        this.loginCliente = loginCliente;
        this.idEvento = idEvento;
    }
    
    public String getLoginCliente() {
        return loginCliente;
    }
    
    public String getIdEvento() {
        return idEvento;
    }
    
    public float getValoracion() {
        return valoracion;
    }
    
    public void setValoracion(float valoracion) {
        this.valoracion = valoracion;
    }
    
}
