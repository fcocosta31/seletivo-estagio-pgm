package seletivo_pgm.controller;

import static br.com.caelum.vraptor.view.Results.json;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;

import br.com.caelum.vraptor.Controller;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.jasperreports.Report;
import br.com.caelum.vraptor.jasperreports.download.ReportDownload;
import br.com.caelum.vraptor.jasperreports.formats.ExportFormats;
import br.com.caelum.vraptor.observer.download.Download;
import br.com.caelum.vraptor.simplemail.AsyncMailer;
import seletivo_pgm.entity.Cadastro;
import seletivo_pgm.entity.CadastroReport;
import seletivo_pgm.entity.Cidade;
import seletivo_pgm.entity.Estado;
import seletivo_pgm.entity.GeraMD5;
import seletivo_pgm.model.CadastroDAO;


@Controller
public class CadastroController {
		
	private CadastroDAO dao;
	@Inject private AsyncMailer mailer;
	
	@Inject private Result result;
	@Inject private Cadastro cadastro;
	@Inject private ServletContext ctx;
		
	
	@Get("/cadastro/cidades/{uf}")
	public void lista(String uf){
		
		dao = new CadastroDAO();
		
		List<Cidade> lista = dao.listaCidades(uf);
		
		result.use(json()).withoutRoot().from(lista).serialize();		
		
	}

	public void form() {

		dao = new CadastroDAO();
		
		List<Estado> lista = dao.listaEstados();
		
		result.include("estados", lista);
		
	}
	
	public void buscar() {}

	@Audit
	public void confirma(){}

	@Get("/cadastro/reimpressao/{id}/{cpf}")
	public void reimpressao(long id, String cpf) {
		
		String ncpf = formataCPF(cpf);
		
		dao = new CadastroDAO();				

		Cadastro cadastro = dao.recupera(id,ncpf);
		
		result.include("inscricao", cadastro);
	}

	@Audit
	@Get("/cadastro/confirmacao/{cpf}")
	public void confirmacao(String cpf){

		String ncpf = formataCPF(cpf);
		dao = new CadastroDAO();
		Cadastro cadastro = dao.recupera(ncpf);

		result.redirectTo(this).confirmainscricao(cadastro);

	}

	public void confirmainscricao(Cadastro cadastro){

		String mensagem = "Confirmação cancelada!";

		if(cadastro == null){
			mensagem = "Erro: CPF não encontrado!";
		}else{
			if(cadastro.isPago()) {
				cadastro.setPago(false);
				if(!cadastro.getIsencao().equalsIgnoreCase("Nenhum")) {
					mensagem = "Isenção cancelada!";
				}
			}else {
				cadastro.setPago(true);
				if(cadastro.getIsencao().equalsIgnoreCase("Nenhum")) {
					enviarRecibo(cadastro);
					mensagem = "Confirmação enviada para o e-mail "+cadastro.getEmail();
				}else {
					mensagem = "Isenção confirmada!";
				}
			}
			cadastro.setValidacao(GeraMD5.getMD5(cadastro.getNascimento()+cadastro.getCpf()).toUpperCase());
			dao = new CadastroDAO();
			dao.atualizar(cadastro);
		}

		result.use(json()).withoutRoot().from(mensagem).serialize();
	}

	@Get("/cadastro/reimpressao/{cpf}")
	public void reimpressao(String cpf) {

		String ncpf = formataCPF(cpf);
		
		dao = new CadastroDAO();				

		Cadastro cadastro = dao.recupera(ncpf);
		
		result.include("inscricao", cadastro);
	}
	

	@Post("/cadastro/inscricao")
	public void inscricao(Cadastro cadastro) {
		
		String cpf = cadastro.getCpf();

		String ncpf = formataCPF(cpf);

		cadastro.setCpf(ncpf);

		dao = new CadastroDAO();
		if(cadastro.getId() > 0) {
			cadastro.setValidacao(GeraMD5.getMD5(cadastro.getNascimento()+cadastro.getCpf()).toUpperCase());
			dao.atualizar(cadastro);
			result.include("inscricao", cadastro);
		}else {
			if(dao.recupera(cadastro.getCpf())!=null) {
				cadastro = dao.recupera(cadastro.getCpf());
				String mensagem = "Já existe inscrição registrada para este CPF ["+cadastro.getCpf()+"]! Deseja recuperar?";
				result.use(json()).withoutRoot().from(mensagem).serialize();
			}else {
				cadastro.setValidacao(GeraMD5.getMD5(cadastro.getNascimento()+cadastro.getCpf()).toUpperCase());			
				dao.salvar(cadastro);
				String mensagem = "Inscrição nº "+String.format("%04d", cadastro.getId())+" efetuada com sucesso! Deseja imprimir?";
				result.use(json()).withoutRoot().from(mensagem).serialize();
			}
		}		
	}
	
	@Audit
	@Get("/cadastro/lista")
	public void lista() {
		dao = new CadastroDAO();
		List<Cadastro> lista = dao.listar();
		
		result.include("lista", lista);
	}

	@Audit
	@Get("/cadastro/listaadmingeral")
	public void listaadmingeral() {
		dao = new CadastroDAO();
		List<Cadastro> lista = dao.listar();
		
		result.include("lista", lista);
	}
	
	@Get("/cadastro/pagamento/{id}")
	public void pagamento(long id) {

		dao = new CadastroDAO();
		cadastro = dao.recupera(id);
		String mensagem = "Confirmação cancelada!";
		if(cadastro.isPago()) {
			cadastro.setPago(false);
			if(!cadastro.getIsencao().equalsIgnoreCase("Nenhum")) {
				mensagem = "Isenção cancelada!";
			}
		}else {
			cadastro.setPago(true);
			if(cadastro.getIsencao().equalsIgnoreCase("Nenhum")) {
				enviarRecibo(cadastro);
				mensagem = "Confirmação enviada para o e-mail "+cadastro.getEmail();
			}else {
				mensagem = "Isenção confirmada!";
			}
		}
		cadastro.setValidacao(GeraMD5.getMD5(cadastro.getNascimento()+cadastro.getCpf()).toUpperCase());
		dao.atualizar(cadastro);
		
		result.use(json()).withoutRoot().from(mensagem).serialize();
		
	}
	

	public Cadastro editar(Long id) {

		dao = new CadastroDAO();
		
		List<Estado> lista = dao.listaEstados();
		
		result.include("estados", lista);
		
		return dao.recupera(id);
		
	}

	@Audit
	@Get("/cadastro/deletar/{id}")
	public void deletar(Long id) {
		dao = new CadastroDAO();
		Cadastro cadastro = dao.recupera(id);
		dao.deletar(cadastro);
		result.redirectTo("/cadastro/listaadmingeral");
	}

	@Audit
	@Path("/cadastro/pdf/{tipo}") 
	public Download pdfReport(String tipo) {
		Report report = generateReport(tipo);
		report.addParameter("logo", ctx.getRealPath("/myresources/images/logo.png"));
		return new ReportDownload(report, ExportFormats.pdf());
	}

	@Audit
	@Path("/cadastro/xls/{tipo}") 
	public Download xlsReport(String tipo) {
		Report report = generateReport(tipo);
		report.addParameter("logo", ctx.getRealPath("/myresources/images/logo.png"));
		return new ReportDownload(report, ExportFormats.xls());
	}

	@Audit
	@Path("/cadastro/docx/{tipo}")
	public Download docxReport(String tipo) {
		Report report = generateReport(tipo);
		report.addParameter("logo", ctx.getRealPath("/myresources/images/logo.png"));
		return new ReportDownload(report, ExportFormats.docx());		
	}


	private Report generateReport(String tipo) {
		dao = new CadastroDAO();
		
		CadastroReport cr;
		if(tipo.equals("todos"))
			cr = new CadastroReport(dao.listarTodos(), "todos_pgm_land.jasper");
		else
			cr = new CadastroReport(dao.listarInscritos(), "inscritos_pgm.jasper");
		
		return cr;
	}


	public void enviarRecibo(Cadastro cadastro) {
		
		Email email = new SimpleEmail();
		email.setSubject("Confirmação de Inscrição");
		try {
			email.addTo(cadastro.getEmail());
		} catch (EmailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		email.setContent(cadastro.getRecibo(), "text/html; charset=UTF-8");
		mailer.asyncSend(email);
		
	}

	public String formataCPF(String cpf){
		cpf = cpf.replace(" ", "");
		cpf = cpf.replace(".", "");
		cpf = cpf.replace("-", "");

		String ncpf = cpf.substring(0, 3) + "." + cpf.substring(3, 6) + "." + cpf.substring(6, 9) + "-" + cpf.substring(9, 11);
		return  ncpf;
	}
	
}

