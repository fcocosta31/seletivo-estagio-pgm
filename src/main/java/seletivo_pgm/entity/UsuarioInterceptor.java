package seletivo_pgm.entity;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;

import br.com.caelum.vraptor.Accepts;
import br.com.caelum.vraptor.BeforeCall;
import br.com.caelum.vraptor.Intercepts;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.controller.ControllerMethod;
import seletivo_pgm.controller.Audit;
import seletivo_pgm.controller.UsuarioController;

@Intercepts
@RequestScoped
public class UsuarioInterceptor {
	@Inject private UsuarioWeb usuarioweb;
	@Inject private Result result;
	
	@Accepts
	public boolean accepts(ControllerMethod method) {
		return method.containsAnnotation(Audit.class);
	 }
	
	@BeforeCall
	public void before() {
		 if(!this.usuarioweb.isLogged()) {
			 result.redirectTo(UsuarioController.class).login();
		 }	
	}
}
