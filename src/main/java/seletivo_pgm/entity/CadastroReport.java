package seletivo_pgm.entity;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import br.com.caelum.vraptor.jasperreports.Report;

public class CadastroReport implements Report{
	
	private final List<Cadastro> data;
	private Map<String, Object> parameters;
	private String templatereport;
	
	public CadastroReport(List<Cadastro> data, String templatereport) {
		this.data = data;
		this.parameters = new HashMap<String, Object>();
		this.templatereport = templatereport;
	}
	
	@Override
	public Report addParameter(String key, Object value) {
		// TODO Auto-generated method stub
		this.parameters.put(key, value);
		
		return this;
	}

	@Override
	public Collection<Cadastro> getData() {
		// TODO Auto-generated method stub
		return data;
	}

	@Override
	public String getFileName() {
		// TODO Auto-generated method stub
		return this.templatereport + System.currentTimeMillis();
	}

	@Override
	public Map<String, Object> getParameters() {
		// TODO Auto-generated method stub
		return this.parameters;
	}

	@Override
	public String getTemplate() {
		// TODO Auto-generated method stub
		return this.templatereport;
	}

	@Override
	public boolean isCacheable() {
		// TODO Auto-generated method stub
		return true;
	}

	public void setParameters(Map<String, Object> parameters) {
		this.parameters = parameters;
	}

	public String getTemplatereport() {
		return templatereport;
	}

	public void setTemplatereport(String templatereport) {
		this.templatereport = templatereport;
	}

}
