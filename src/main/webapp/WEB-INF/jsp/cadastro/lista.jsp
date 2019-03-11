	<!-- EXPORTA A LISTA DE INSCRITOS EM FORMATO PDF, EXCEL -->
	<div class="row">
		
		<div class="noPrint button-group col-md-4 col-xs-12">
			<div class="col-md-4 col-sx-12 pull-left">
				<a href="#" onclick="gera_report_pdf()"><img
					src="../myresources/images/logo_pdf.png" title="Exportar para PDF"></a>
			</div>
			<div class="col-md-4 col-sx-12 pull-left">	
				<a href="#" onclick="gera_report_xls()"><img
					src="../myresources/images/export_excel.png" title="Exportar para Excel"></a>
			</div>
			<div class="col-md-4 col-sx-12 pull-left">	
				<a href="#" onclick="gera_report_docx()"><img
					src="../myresources/images/export_word.png" title="Exportar para Word"></a>
			</div>
		</div>
		
		<div class="col-md-8 col-xs-12">
			<c:set var="cfampla" value="0"></c:set>
			<c:set var="cfdoador" value="0"></c:set>
			<c:set var="cfportador" value="0"></c:set>
			<c:set var="ctampla" value="0"></c:set>
			<c:set var="ctdoador" value="0"></c:set>
			<c:set var="ctportador" value="0"></c:set>
			
			<c:forEach var="j" items="${lista}">
				<c:choose>
					
					<c:when test="${j.pago eq false}">
					
						<c:if test="${j.ampla eq true}">
							<c:set var="ctampla" value="${ctampla + 1}"></c:set>
							<c:if test="${j.isencao eq 'Doador'}">
							    <c:set var="ctampla" value="${ctampla - 1}"></c:set>
								<c:set var="ctdoador" value="${ctdoador + 1}"></c:set>
							</c:if>
						</c:if>
						
						<c:if test="${j.ampla eq false}">
							<c:set var="ctportador" value="${ctportador + 1}"></c:set>
						</c:if>
						
					</c:when>
					
					<c:otherwise>

						<c:if test="${j.ampla eq true}">
							<c:set var="ctampla" value="${ctampla + 1}"></c:set>
							<c:set var="cfampla" value="${cfampla + 1}"></c:set>
							
							<c:if test="${j.isencao eq 'Doador'}">
							    <c:set var="ctampla" value="${ctampla - 1}"></c:set>							
								<c:set var="ctdoador" value="${ctdoador + 1}"></c:set>
								<c:set var="cfdoador" value="${cfdoador + 1}"></c:set>
							</c:if>
						</c:if>
						
						<c:if test="${j.ampla eq false}">
							<c:set var="ctportador" value="${ctportador + 1}"></c:set>
							<c:set var="cfportador" value="${cfportador + 1}"></c:set>
						</c:if>
					
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<table class="table table-fluid">
				<thead>
					<tr>
						<th>Inscrições</th>
						<th>Ampla (sem Isenção)</th>
						<th>Ampla (Doador)</th>
						<th>Portador</th>
						<th>Total</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Realizadas</td>
						<td>
							<fmt:formatNumber type="number" value="${ctampla}" minIntegerDigits="4" pattern="####"></fmt:formatNumber>
						</td>
						<td>
							<fmt:formatNumber type="number" value="${ctdoador}" minIntegerDigits="4" pattern="####"></fmt:formatNumber>
						</td>
						<td>
							<fmt:formatNumber type="number" value="${ctportador}" minIntegerDigits="4" pattern="####"></fmt:formatNumber>
						</td>
						<td>
							<fmt:formatNumber type="number" value="${ctampla + ctdoador + ctportador}" minIntegerDigits="4" pattern="####"></fmt:formatNumber>
						</td>
					</tr>
					<tr>
						<td>Confirmadas</td>
						<td>
							<fmt:formatNumber type="number" value="${cfampla - cfdoador}" minIntegerDigits="4" pattern="####"></fmt:formatNumber>
						</td>
						<td>
							<fmt:formatNumber type="number" value="${cfdoador}" minIntegerDigits="4" pattern="####"></fmt:formatNumber>
						</td>
						<td>
							<fmt:formatNumber type="number" value="${cfportador}" minIntegerDigits="4" pattern="####"></fmt:formatNumber>
						</td>
						<td>
							<fmt:formatNumber type="number" value="${cfampla + cfportador}" minIntegerDigits="4" pattern="####"></fmt:formatNumber>
						</td>
					</tr>
					
				</tbody>
				<tfoot>
					<tr>
						<fmt:setLocale value="pt-BR"/>						
						<td colspan="5">
							<!--
						    <strong>Total arrecadado <fmt:formatNumber value="${(cfampla - cfdoador) * 30}" minFractionDigits="2" type="currency"></fmt:formatNumber>
						    </strong>
						    -->
						</td>
					</tr>
				</tfoot>
			</table>
		</div>

		<div class="col-md-12 col-sx-12 pull-left">
			<a href="<c:url value="/cadastro/confirma"/>"><img
					src="../myresources/images/tick.png" title="Confirmar Inscrição com CPF"
					width="32px" height="auto"> Confirmação de Inscrição</a>
		</div>

	</div>
	<hr>		
	
	<div class="row-fluid">
		
	<table class="table table-fluid table-striped" id="table_lista">
		<thead style="background-color: #315084; color: white;">
			<tr>
				<th>Nº de Inscrição</th>
				<th>Nome</th>
				<th>CPF</th>
				<th>RG / Órgão Emissor</th>
				<th>Telefone</th>
				<th>E-mail</th>
				<th>Cidade</th>
				<th>Isenção</th>
				<th>Neces.Esp.</th>
				<th>Ok?</th>								
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" items="${lista}">
				<tr>
					<td><fmt:formatNumber type="number" value="${i.id}" minIntegerDigits="4" pattern="####"></fmt:formatNumber></td>
					<td>${i.nome}</td>
					<td><a href="<c:url value='/cadastro/reimpressao/${i.id}/${i.cpf}'/>" class="mySpinner">${i.cpf}</a></td>
					<td>${i.rg} - ${i.emissor}</td>
					<td>${i.telefone}</td>
					<td>${i.email}</td>
					<td>${i.cidade}</td>
					<td>${i.isencao}</td>
					<td>
						<c:choose>
							<c:when test="${i.necessidade}">
								SIM
							</c:when>
							<c:otherwise>
								NÃO
							</c:otherwise>							
						</c:choose>
					</td>
					<td>
						<c:set var="textpgto" value="NÃO" />
						<c:set var="colorpgto" value="btn-danger" />
						<c:if test="${i.pago eq true}">
							<c:set var="textpgto" value="SIM" />
							<c:set var="colorpgto" value="btn-primary" />
						</c:if>
						<button type="button" class="btn ${colorpgto} btn-xs" id="${i.id}" onclick="pagamento(${i.id}, this)">${textpgto}</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
		<tfoot><tr><td colspan="10"></td></tr></tfoot>
	</table>
	</div>


<script>
$(document).ready(function() {

	var table = $('#table_lista').DataTable();

});

function gera_report_pdf(){

	bootbox.dialog({
		title: 'Relatório de Inscrições - Estagiários',
		message: 'Escolha uma opção:',
		buttons: {
		    cancel: {
		        label: "Imprime todos",
		        className: 'btn-warning',
		        callback: function(){
		            location.href = "<c:url value='/cadastro/pdf/todos'/>";		            
		        }
		    },
		    ok: {
		        label: "Somente confirmados",
		        className: 'btn-primary',
		        callback: function(){
		        	location.href = "<c:url value='/cadastro/pdf/inscritos'/>";
		        }
		    },
		    onEscape: {
		    	label:"Fechar",
		    	className: 'btn-info',
		    	callback: function(){bootbox.hideAll();}
		    }
		}
	});	
}

function gera_report_xls(){

	bootbox.dialog({
        title: 'Relatório de Inscrições - Estagiários',
        message: 'Escolha uma opção:',
		buttons: {
		    cancel: {
		        label: "Imprime todos",
		        className: 'btn-warning',
		        callback: function(){
		            location.href = "<c:url value='/cadastro/xls/todos'/>";
		        }
		    },
		    ok: {
		        label: "Somente confirmados",
		        className: 'btn-primary',
		        callback: function(){
		        	location.href = "<c:url value='/cadastro/xls/inscritos'/>";
		        }
		    },
		    onEscape: {
		    	label:"Fechar",
		    	className: 'btn-info',
		    	callback: function(){bootbox.hideAll();}
		    }
		}
	});	
}


function gera_report_docx(){

	bootbox.dialog({
        title: 'Relatório de Inscrições - Estagiários',
        message: 'Escolha uma opção:',
		buttons: {
		    cancel: {
		        label: "Imprime todos",
		        className: 'btn-warning',
		        callback: function(){
		            location.href = "<c:url value='/cadastro/docx/todos'/>";
		        }
		    },
		    ok: {
		        label: "Somente confirmados",
		        className: 'btn-primary',
		        callback: function(){
		        	location.href = "<c:url value='/cadastro/docx/inscritos'/>";
		        }
		    },
		    onEscape: {
		    	label:"Fechar",
		    	className: 'btn-info',
		    	callback: function(){bootbox.hideAll();}
		    }
		}
	});	
}


function pagamento(cadastro_id, element){

	bootbox.confirm("Tem certeza?", function (result) {
		if(result){
            $.ajax({
                url: '<c:url value="/cadastro/pagamento/"/>'+cadastro_id,
                dataType: 'json',
                success: function(data) {

                    if($(element).hasClass("btn-primary")){
                        $(element).removeClass("btn-primary").addClass("btn-danger");
                        $(element).text("NÃO");
                    }else{
                        $(element).removeClass("btn-danger").addClass("btn-primary");
                        $(element).text("SIM");
                    }
                    $(element).button("refresh");
                    $(element).button();

                    bootbox.hideAll();
                    bootbox.alert(data);

                },
                error: function() {
                    bootbox.hideAll();
                    bootbox.alert('erro');

                }
            });
		}
    });

}


function exportaConsultaExcel(e){
	
	e.preventDefault();
	
    $.fileDownload($(this).prop('href'), {
        prepareCallback: function (responseHtml, url) {
        	            
        },	    	
        failCallback: function (responseHtml, url) {
        	
            bootbox.alert("Erro o tentar processar o arquivo!");
            
        },
        successCallback: function(url){
        	        	
        },
        httpMethod: "GET"
    });
    
    return false;		
}

</script>