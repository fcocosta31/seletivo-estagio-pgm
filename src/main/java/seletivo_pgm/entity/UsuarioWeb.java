package seletivo_pgm.entity;

import java.io.Serializable;

import javax.enterprise.context.SessionScoped;


@SessionScoped
public class UsuarioWeb implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Usuario usuario;
	
	public boolean isLogged() {
		return this.getUsuario() != null && this.getUsuario().isLogged();
	}
	
	public void logout() {
		this.setUsuario(null);
	}
	
	public String toString() {
		return this.getUsuario().toString();
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	
}
