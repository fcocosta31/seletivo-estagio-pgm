	
	<div class="jumbotron col-md-8 col-xs-12 col-md-offset-2 mybox-shadow">
		<img alt="" src="http://pgm.teresina.pi.gov.br/img/header.png" width="60%" height="auto">
		<h3>PROCESSO SELETIVO EST�GIO -
			  <%=
			  	fmtyear.format(new java.util.Date())
			  %>			
		</h3>
		<h5>DADOS DA INSCRI��O</h5>
		<hr>
		<span><b>Data: </b></span>
		<span><fmt:formatDate value="${inscricao.emissao}" type="both"/></span>
		<br>
		<span><b>N� Inscri��o: </b></span>
		<span><fmt:formatNumber type="number" value="${inscricao.id}" minIntegerDigits="4" pattern="####"></fmt:formatNumber></span>
		<br>
		<span><b>Nome: </b></span>
		<span>${inscricao.nome}</span>
		<br>
		<span><b>CPF n�: </b></span>
		<span>${inscricao.cpf}</span>
		<br>
		<span><b>RG n�: </b></span>
		<span>${inscricao.rg} - ${inscricao.emissor}</span>
		<br>
		<span><b>Data Nascimento: </b></span>
		<span>${inscricao.nascimento}</span>
		<br>
		<span><b>Telefone: </b></span>
		<span>${inscricao.telefone}</span>
		<br>
		<span><b>E-mail: </b></span>
		<span>${inscricao.email}</span>
		<br>
		<span><b>Endere�o: </b></span>
		<span>${inscricao.endereco}, ${inscricao.bairro} - ${inscricao.complemento} ${inscricao.cep} / ${inscricao.cidade} - ${inscricao.estado}</span>
		<br>
		<span><b>Tipo de isen��o: </b></span>
		<span>${inscricao.isencao}</span>
		<br>
		<span><b>Inscri��o Confirmada? </b></span>
		<c:set var="pgto" value="N�O"></c:set>
		<c:if test="${inscricao.pago}">
			<c:set var="pgto" value="SIM"></c:set>
		</c:if>
		<span>${pgto}</span>
		<br>
		<span><b>Necessidade Especial? </b></span>
		<c:set var="necs" value="N�O"></c:set>
		<c:if test="${inscricao.necessidade}">
			<c:set var="necs" value="SIM"></c:set>
		</c:if>		
		<span>${necs}</span>
		<c:if test="${inscricao.necessidade}">
		<br>		
		<span><b>Tipo de Necessidade: </b></span>
		<span>${inscricao.tiponecessidade}</span>			
		</c:if>
		<br>
		<span><b>C�digo de valida��o: </b></span>
		<span>${inscricao.validacao}</span>
		<hr>
		<article class="fontsize">A confirma��o da inscri��o est� condicionada � doa��o de 3Kg de alimentos
			n�o perec�veis a serem entregues na Procuradoria Geral do Munic�pio - PGM localizada na Rua Firmino Pires,
			Ed. Saraiva Center 2� Andar, Centro, Sul, CEP: 64001-070, Teresina- PI
			Telefones: (86) 3215 7600 / 7602  </article>
		<hr>		
		<div class="noPrint">
			<button type="button" class="btn btn-md btn-primary" onclick="window.print();">Imprimir</button>
			<c:if test="${!inscricao.pago}">
				<button type="button" class="btn btn-md btn-warning mySpinner" id="retornar">Alterar</button>
			</c:if>
		</div>		
	</div>


<script>

$(document).ready(function()
{
	
	$('#retornar').on('click', function(){
		location.href = '<c:url value="/cadastro/editar?id=${inscricao.id}"/>';
	});
	
});

</script>

<style>
.fontsize{
	font-size: 10pt;
}

@media print {
	.noPrint, .noPrint * {
		display: none !important;
	}
}
</style>