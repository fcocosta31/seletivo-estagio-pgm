
	<!-- EXPORTA A LISTA DE INSCRITOS EM FORMATO PDF, EXCEL -->
	
	<div class="noPrint button-group row">
		<div class="col-md-1 col-sx-12 pull-left">
			<a href="#" onclick="gera_report_pdf()"><img
				src="../myresources/images/logo_pdf.png" title="Exportar para PDF"></a>
		</div>
		<div class="col-md-1 col-sx-12 pull-left">	
			<a href="#" onclick="gera_report_xls()"><img
				src="../myresources/images/export_excel.png" title="Exportar para Excel"></a>
		</div>
		<div class="col-md-1 col-sx-12 pull-left">	
			<a href="#" onclick="gera_report_docx()"><img
				src="../myresources/images/export_word.png" title="Exportar para Word"></a>
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
				<th>#</th>								
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
						<c:if test="${i.pago eq false}">
							SIM
							<!--
							<input class="form-control mySpinner" type="checkbox" id="${i.id}" onchange="pagamento(${i.id})">
							-->
						</c:if>
						<c:if test="${i.pago eq true}">
							NÃO
							<!--
							<input class="form-control mySpinner" type="checkbox" checked="checked" id="${i.id}" onchange="pagamento(${i.id})">
							-->
						</c:if>
					</td>
					<td><a href="<c:url value='/cadastro/deletar/${i.id}'/>" class="mySpinner">Deletar</a></td>
				</tr>
			</c:forEach>
		</tbody>
		<tfoot><tr><td colspan="10"></td></tr></tfoot>
	</table>
	</div>
	


<script>
$(document).ready(function() {
    $('#table_lista').DataTable();
} );

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

function pagamento(cadastro_id){
	
    $.ajax({
        url: '<c:url value="/cadastro/pagamento/"/>'+cadastro_id,
        dataType: 'json',
        success: function(data) {
        	bootbox.hideAll();
        	bootbox.alert(data);
			
        },
        error: function() {
        	bootbox.hideAll();
            bootbox.alert('erro');

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