/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.management.bean;

/**
 *
 * @author mati
 */
public class UsuarioBean {
    
    private Integer id = 0;
    private String login = "";
    private String password = "";        
    private Enum tipoUsuario = null;

    
    public UsuarioBean (){
        
    }
    
    public UsuarioBean(Integer id){
        this.id = id;
    }
    /**
     * @return the id
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return the login
     */
    public String getLogin() {
        return login;
    }

    /**
     * @param login the login to set
     */
    public void setLogin(String login) {
        this.login = login;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * @return the tipoUsuario
     */
    public Enum getTipoUsuario() {
        return tipoUsuario;
    }

    /**
     * @param tipoUsuario the tipoUsuario to set
     */
    public void setTipoUsuario(Enum tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }
}
