/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datos;

import java.time.LocalDate;

/**
 * Modelo Anfitrion
 * 
 * @author gonzale
 * @author jorbarr
 * @author juangar
 * @author lucgonz
 */
public class Anfitrion extends Usuario{
    private String cif;
    
    public Anfitrion (String login, String nombre, String cif, String email){
        super(login, nombre, email);
        this.cif = cif;
    }
    
    
    public String getCif() {
        return cif;
    }
    
}
