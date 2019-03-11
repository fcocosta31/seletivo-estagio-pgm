package seletivo_pgm.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="usuario")
public class Usuario{
	

	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	
	private String login;
	private String senha;
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getLogin() {
		return login;
	}
	public void setLogin(String login) {
		this.login = login;
	}
	public String getSenha() {
		return senha;
	}
	public void setSenha(String senha) {
		this.senha = senha;
	}
	
    public boolean isLogged() {
        return login != null && senha.length() > 0 ? true : false;
   }
	
	public String toString() {
		return "Usuario: "+this.login+"/n Senha: "+this.senha;
	}
	
}
