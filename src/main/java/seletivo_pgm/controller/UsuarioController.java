package seletivo_pgm.controller;

import javax.inject.Inject;

import br.com.caelum.vraptor.Controller;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Result;
import seletivo_pgm.entity.Usuario;
import seletivo_pgm.entity.UsuarioWeb;
import seletivo_pgm.model.UsuarioDAO;

@Controller
public class UsuarioController {
	
	@Inject private UsuarioDAO dao;
	@Inject private Result result;
	@Inject private UsuarioWeb usuarioweb;
	
	public void login() {
		
	}
	
	@Post("/usuario/logon")
	public void logon(Usuario usuario) {
			
		if(dao.auth(usuario)!=null) {
			usuarioweb.setUsuario(usuario);
			result.redirectTo(CadastroController.class).lista();
		}else {
			result.include("errorlogin", "Usuário ou senha inválido!").redirectTo(this).login();
		}		
	}
}
