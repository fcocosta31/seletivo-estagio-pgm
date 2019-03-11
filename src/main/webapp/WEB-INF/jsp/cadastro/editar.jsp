	
	<div>
		<h3>PROCESSO SELETIVO ESTÁGIO - 
			  <%=
			  	fmtyear.format(new java.util.Date())
			  %>			
		</h3>

		<h5>Formulário de Inscrição</h5>
	</div>
	

	<div class="card bg-faded">
		<div class="well mybox-shadow">
			<form action="<c:url value="/cadastro/inscricao"/>" method="post">
				
				<div class="row">
					<div class="col-md-5 col-xs-12">
						<label class="control-label">Nome</label>
						<input class="form-control toUpper" type="text" value="${cadastro.nome}" name="cadastro.nome" required>
					</div>
					<div class="col-md-2 col-xs-12">				
						<label class="control-label">CPF nº</label>
						<input class="form-control" type="text" value="${cadastro.cpf}" name="cadastro.cpf" placeholder="000.000.000-00" maxlength="14" OnKeyPress="formatar('###.###.###-##', this)" required>
					</div>				
					<div class="col-md-3 col-xs-12">
						<label class="control-label">RG nº</label>
						<input class="form-control" type="text" value="${cadastro.rg}" name="cadastro.rg" placeholder="apenas números" pattern="[0-9]+$" required>
					</div>
					<div class="col-md-2 col-xs-12">
						<label class="control-label">Emissor/UF</label>
						<input class="form-control" type="text" value="${cadastro.emissor}" name="cadastro.emissor" required>
					</div>															
				</div>
				
				
				<div class="row">
					<div class="col-md-3 col-xs-12">
						<label class="control-label">Data Nascimento</label>
						<input class="form-control" type="text" value="${cadastro.nascimento}" name="cadastro.nascimento" placeholder="dd/mm/aaaa" maxlength="10" OnKeyPress="formatar('##/##/####', this)" required>
					</div>					
					<div class="col-md-4 col-xs-12">					
						<label class="control-label">Celular</label>
						<input class="form-control" type="text" value="${cadastro.telefone}" name="cadastro.telefone" placeholder="00-00000-0000" OnKeyPress="formatar('##-#####-####', this)" required>
					</div>
					<div class="col-md-5 col-xs-12">
						<label class="control-label">E-mail</label>
						<input class="form-control" type="email" value="${cadastro.email}" name="cadastro.email" placeholder="email@exemplo.com" required>
					</div>										
				</div>
				
				<div class="row">
					<div class="col-md-2 col-xs-12">
						<c:set var="nenhum" value=""></c:set>
						<c:set var="doador" value=""></c:set>
						<c:set var="portador" value=""></c:set>
						
						<c:choose>
							<c:when test="${cadastro.isencao eq 'Doador'}">
								<c:set var="doador" value="selected"></c:set>
							</c:when>
							<c:when test="${cadastro.isencao eq 'Portador'}">
								<c:set var="portador" value="selected"></c:set>
							</c:when>
							<c:otherwise>
								<c:set var="nenhum" value="selected"></c:set>
							</c:otherwise>
						</c:choose>
						
						<label class="control-label">Tipo Isenção</label>
					    <select class="form-control toUpper" name="cadastro.isencao">
					    							
					        <option value="Nenhum" ${nenhum}>Nenhuma</option>
							<option value="Doador" ${doador}>Doador de Sangue</option>
							<option value="Portador" ${portador}>Portador de Deficiência</option>
							
					    </select>
					</div>				
					<div class="col-md-6 col-xs-12">
						<label class="control-label">Endereço</label>
						<input class="form-control toUpper" type="text" value="${cadastro.endereco}" name="cadastro.endereco" placeholder="avenida/rua/travessa, nº" required>
					</div>
					<div class="col-md-4 col-xs-12">					
						<label class="control-label">Bairro</label>
						<input class="form-control toUpper" type="text" value="${cadastro.bairro}" name="cadastro.bairro" required>
					</div>
				</div>
			

				<div class="row">
					<div class="col-md-5 col-xs-12">
						<label class="control-label">Complemento</label>
						<input class="form-control toUpper" type="text" value="${cadastro.complemento}" name="cadastro.complemento">
					</div>										
					<div class="col-md-2 col-xs-12">
						<label class="control-label">CEP</label>
						<input class="form-control" type="text" value="${cadastro.cep}" name="cadastro.cep" placeholder="00000-000" maxlength="9" OnKeyPress="formatar('#####-###', this)" required>
					</div>										
					<div class="col-md-2 col-xs-12">					
						<label class="control-label">Estado</label>
					    <select class="form-control" id="select_estados"
					            name="cadastro.estado">
					            					
					        <c:forEach var="cad" items="${estados}">
					        	<c:choose>					        	
					        		<c:when test="${cadastro.estado eq cad.uf}">
					        			<option value="${cad.uf}" selected>${cad.uf}</option>
					        		</c:when>
					        		<c:otherwise>
					        			<option value="${cad.uf}">${cad.uf}</option>
					        		</c:otherwise>
					        	</c:choose>						        
					        </c:forEach>
					        					
					    </select>
					</div>
					<div class="col-md-3 col-xs-12">
						<label class="control-label">Municipio</label>
					    <select class="form-control" id="select_municipios" 
					            name="cadastro.cidade">									
					    </select>
					</div>										
				</div>
				<div class="row">
					<div class="col-md-3 col-xs-12">
						<br><br>
						<label class="control-label">Necessidade Especial?</label>
						<c:choose>
							<c:when test="${cadastro.necessidade}">
								<input type="radio" name="cadastro.necessidade" checked value="true">SIM
								<input type="radio" name="cadastro.necessidade" value="false">NÃO
							</c:when>						
							<c:otherwise>
								<input type="radio" name="cadastro.necessidade" value="true">SIM
								<input type="radio" name="cadastro.necessidade" checked value="false">NÃO
							</c:otherwise>									
						</c:choose>
					</div>										
					<div class="col-md-9 col-xs-12">
						<label class="control-label">Especificar</label>
						<textarea rows="4" cols="4" class="form-control toUpper" name="cadastro.tiponecessidade">${cadastro.tiponecessidade}</textarea> 
					</div>										
				</div>
				<br>
				<div class="button-group ">
				    <input class="btn btn-md btn-primary" type="submit" value="Enviar" />
				    <input class="btn btn-md btn-warning" type="button" id="cancelar" value="Cancelar" />
			    </div>
				<input type="hidden" name="cadastro.id" value="${cadastro.id}">
				    
			</form>
		</div>
	</div>



<script>

function formatar(mascara, documento){
	  var i = documento.value.length;
	  var saida = mascara.substring(0,1);
	  var texto = mascara.substring(i);
	  
	  if (texto.substring(0,1) != saida){
	            documento.value += texto.substring(0,1);
	  }
	  
	}

$(document).ready(function()
{
	
	$('#cancelar').on('click', function(){
		location.href = "http://pgm.teresina.pi.gov.br/";
	});

    $.ajax({
        url: '<c:url value="/cadastro/cidades/${cadastro.estado}"/>',
        dataType: 'json',
        success: function(data) {
        	$("#select_municipios").empty();
        	var cidade = '${cadastro.cidade}';
            $.each(data, function(i, item){
            	if(cidade == item.nome){
            		$("#select_municipios").append("<option value='"+item.nome+"' selected>"+item.nome+"</option>");
            	}else{
            		$("#select_municipios").append("<option value='"+item.nome+"'>"+item.nome+"</option>");
            	}            	
            });

        },
        error: function() {

            alert('erro');

        }

    });
	
    $('#select_estados').on('change', function()
    {

        $.ajax({
            url: '<c:url value="/cadastro/cidades/"/>'+$(this).val(),
            dataType: 'json',
            success: function(data) {
            	$("#select_municipios").empty();
                $.each(data, function(i, item){
                	$("#select_municipios").append("<option value='"+item.nome+"'>"+item.nome+"</option>");
                });

            },
            error: function() {

                alert('erro');

            }

        });

    });
});

</script>