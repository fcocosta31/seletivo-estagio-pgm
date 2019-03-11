package seletivo_pgm.entity;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.persistence.*;


@Entity
@Table(name="cadastro")
public class Cadastro {
	
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	
	private Date emissao = new Date();

	private String nome;
	private String cpf;
	private String rg;
	private String emissor;
	private String nascimento;
	private String telefone;
	private String email;
	private String endereco;
	private String bairro;
	private String complemento;
	private String cep;
	
	private String cidade;
	private String estado;	
	private String isencao;
	private String validacao;

	@Lob
	@Column(length=100000)
	private String tiponecessidade;

	
	@Column(name="necessidade", columnDefinition="boolean default false", nullable=false)
	private boolean necessidade;
	
	@Column(name="ampla", columnDefinition="boolean default false", nullable=false)
	private boolean ampla;
	
	@Column(name="pago", columnDefinition="boolean default false", nullable=false)
	private boolean pago = false;

	
	public Date getEmissao() {
		return emissao;
	}

	public void setEmissao(Date emissao) {
		this.emissao = emissao;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome.toUpperCase();
	}

	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public String getRg() {
		return rg;
	}

	public void setRg(String rg) {
		this.rg = rg;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email.toLowerCase();
	}

	public String getEndereco() {
		return endereco;
	}

	public void setEndereco(String endereco) {
		this.endereco = endereco.toUpperCase();
	}

	public String getBairro() {
		return bairro;
	}

	public void setBairro(String bairro) {
		this.bairro = bairro.toUpperCase();
	}

	public String getComplemento() {
		return complemento;
	}

	public void setComplemento(String complemento) {
		this.complemento = complemento;
	}

	public String getCidade() {
		return cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	public String toString() {
		return "<table><p>Emiss�o: "+this.emissao+"</p>"
				+"<p>Inscri��o: "+this.id+"</p>"
				+"<p>Nome: "+this.nome+"</p>"
				+"<p>CPF: "+this.cpf+"</p>"
				+"<p>RG: "+this.rg+"</p>"
				+"<p>�rg�o: "+this.emissor+"</p>"
				+"<p>Nascimento: "+this.nascimento+"</p>"
				+"<p>Fone: "+this.telefone+"</p>"
				+"<p>E-mail: "+this.email+"</p>"
				+"<p>Endere�o: "+this.endereco+"</p>"
				+"<p>Complemento: "+this.complemento+"</p>"
				+"<p>Bairro: "+this.bairro+"</p>"
				+"<p>CEP: "+this.cep+"</p>"
				+"<p>Cidade: "+this.cidade+"</p>"
				+"<p>Estado: "+this.estado+"</p></table>";
	}

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

	public String getEmissor() {
		return emissor;
	}

	public void setEmissor(String emissor) {
		this.emissor = emissor.toUpperCase();
	}

	public String getNascimento() {
		return nascimento;
	}

	public void setNascimento(String nascimento) {
		this.nascimento = nascimento;
	}

	public String getCep() {
		return cep;
	}

	public void setCep(String cep) {
		this.cep = cep;
	}

	public boolean isPago() {
		return pago;
	}

	public void setPago(boolean pago) {
		this.pago = pago;
	}
		
	public String getRecibo() {
		Locale local = new Locale("pt", "BR");
		
		String begin = "<html><body>";
		String end = "</doby></html>";
		String fechadiv = "</div>";
		String cabeca = "<div style='width: 600px; height: 420px; padding: 10px; border-width: 3px; border-style: ridge; background-color: #f0f1f0;'>\r\n" +
				"<div style='border-radius: 5px; background-color: white; height: 68px'>\r\n" + 
				"\r\n" + 
				"	<img alt='' src='http://pgm.teresina.pi.gov.br/img/header.png' width='640' height='auto' style='float: left; margin-right: 10px'>	\r\n" + 
				"</div>	\r\n" + 
				"\r\n" + 
				"<div style='position: relative; padding-bottom: 10px; padding-top: 10px;'>\r\n" + 
				"\r\n" + 
				"<div style='height: 40px ;border-width: 1px; border-style: groove; border-radius: 5px; padding-top: 7px; text-align: center; background-color: white;'>\r\n" + 
				"	<span style='font-size: 2em; font-weight: bold;'>Cartão de Inscrição</span>\r\n" + 
				"</div>				\r\n" + 
				"";
		String divcb1 = "<div style='width: 100%; height: auto; font-size: 1.2em; margin-top: 15px; text-align: center;'>";
		String divitcb11 = "<div style='position: relative; width: 32%; float: left; border-radius: 5px; background-color: white;'>";
		String ctitcb11 = "<strong>Nº Inscrição: </strong>"+String.format("%04d",this.id);
		String divitcb12 = "<div style='position: relative; width: 32%; float: left; border-radius: 5px; background-color: white; margin-left: 2%'>";
		String ctitcb12 = "<strong>Data Insc.: </strong>"+new SimpleDateFormat("dd/MM/yyyy").format(this.emissao);
		String divitcb13 = "<div style='position: relative; width: 32%; float: left; border-radius: 5px; background-color: white; margin-left: 2%'>";
		String ctitcb13 = "<span style='font-size: 8pt;'>"+this.validacao+"</span>";
		
		String corpo = "<div style='margin-top: 25px;'>\r\n" + 
				"	<hr>\r\n" + 
				"	<table>\r\n" + 
				"		<tbody style='font-size: 1.2em; text-align: justify;'>\r\n" + 
				"			<tr>\r\n" + 
				"				<td>\r\n" + 
				"					Nome: <span><strong>"+this.nome+"</strong></span><br>CPF nº "+this.cpf+
				"<br>RG nº "+this.rg+" "+this.emissor+"<br>Endereço: "+this.endereco+" - "+this.complemento+" - "+this.bairro+" / "+this.cidade+"-"+this.estado+"<br> \r\n" +
				"					Confirmamos a inscrição no \r\n" + 
				"					<span><strong>Processo Seletivo Estágio - "+new SimpleDateFormat("yyyy", local).format(new Date())+"</strong></span>.\r\n" + 
				"				</td>\r\n" + 
				"			</tr>\r\n" + 
				"			<tr>\r\n" + 
				"				<td>\r\n" + 
				"					<hr>\r\n" + 
				"				</td>\r\n" + 
				"			</tr>\r\n" + 
				"			<tr>\r\n" + 
				"				<td>\r\n" + 
				"					<span><strong>Teresina</strong></span>, "+new SimpleDateFormat("d 'de' MMMM 'de' yyyy", local).format(new Date())+".\r\n" + 
				"				</td>\r\n" + 
				"			</tr>			\r\n" + 
				"		</tbody>\r\n" + 
				"	</table>\r\n" + 
				"\r\n" + 
				"</div>\r\n" + 
				"<div style='text-align: center; margin-top: 20px;'>\r\n" + 
				"	<article style='font-size: 0.8em'>\r\n" + 
				"		<span style='font-size: 1.5em'><strong>Procuradoria Geral do Município</strong></span><br>\r\n" + 
				"		Rua Firmino Pires, Ed. Saraiva Center 2º Andar\r\n" + 
				"		Centro, Sul, CEP: 64001-070, Teresina- PI<br>\r\n" + 
				"		Telefones: (86) 3215 7600 / 7602\r\n" + 
				"	</article>\r\n" + 
				"\r\n" + 
				"</div>\r\n" + 
				"</div>\r\n" + 
				"";
		
		return begin
				+
				cabeca
				
				+divcb1
					+divitcb11
						+ctitcb11
					+fechadiv
					+divitcb12
						+ctitcb12
					+fechadiv
					+divitcb13
						+ctitcb13
					+fechadiv
				+fechadiv
				+fechadiv
				
				+corpo
					
				+end;
	}

	public String getIsencao() {
		return isencao;
	}

	public void setIsencao(String isencao) {
		this.isencao = isencao;
	}

	public String getValidacao() {
		return validacao;
	}

	public void setValidacao(String validacao) {
		this.validacao = validacao;
	}

	public boolean isAmpla() {
		return ampla;
	}

	public void setAmpla(boolean ampla) {
		this.ampla = ampla;
	}

	public String getTiponecessidade() {
		return tiponecessidade;
	}

	public void setTiponecessidade(String tiponecessidade) {
		this.tiponecessidade = tiponecessidade;
	}

	public boolean isNecessidade() {
		return necessidade;
	}

	public void setNecessidade(boolean necessidade) {
		this.necessidade = necessidade;
	}
	
}
