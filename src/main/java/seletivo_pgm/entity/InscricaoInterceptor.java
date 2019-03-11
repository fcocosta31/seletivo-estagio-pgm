package seletivo_pgm.entity;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;

import br.com.caelum.vraptor.Accepts;
import br.com.caelum.vraptor.BeforeCall;
import br.com.caelum.vraptor.Intercepts;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.controller.ControllerMethod;
import seletivo_pgm.controller.Audit2;
import seletivo_pgm.controller.IndexController;

@Intercepts
@RequestScoped
public class InscricaoInterceptor {

	@Inject private Result result;
	
	@Accepts
	public boolean accepts(ControllerMethod method) {
		return method.containsAnnotation(Audit2.class);
	 }
	
	@BeforeCall
	public void before() {
		
			 result.redirectTo(IndexController.class).index();
			 
	}
}
