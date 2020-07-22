/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datos;

/**
 * Modelo de Usuario
 * 
 * @author gonzale
 * @author jorbarr
 * @author juangar
 * @author lucgonz
 */
public abstract class Usuario {
    private String login;
    private String nombre;
    private String email;

    
    public Usuario (String login, String nombre, String email){
        this.login = login;
        this.nombre = nombre;
        this.email = email;
    }
    
    public String getLogin(){
        return login;
    }
    
    public String getNombre(){
        return nombre;
    }
    
    public String getEmail(){
        return email;
    }
    
}
