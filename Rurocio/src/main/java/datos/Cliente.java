/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datos;

import java.time.LocalDate;

/**
 * Modelo de Cliente
 * 
 * @author gonzale
 * @author jorbarr
 * @author juangar
 * @author lucgonz
 */
public class Cliente extends Usuario{

    private String nif;
    private LocalDate fechaNacimiento;
    
    public Cliente (String login, String nombre, String nif, String email, LocalDate fechaNacimiento){
        super(login, nombre, email);
        this.nif = nif;
        this.fechaNacimiento = fechaNacimiento;
    }
    
    public String getNif() {
        return nif;
    }
    
    public LocalDate getFechaNacimiento(){
        return fechaNacimiento;
    }
    
  
}
