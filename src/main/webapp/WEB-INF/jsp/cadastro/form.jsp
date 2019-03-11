
	
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
			<form action="<c:url value="/cadastro/inscricao"/>" method="post" id="form_cad_insc">
				
				<div class="row">
					<div class="col-md-5 col-xs-12">
						<label class="control-label">Nome</label>
						<input class="form-control toUpper" type="text" name="cadastro.nome" required>
					</div>
					<div class="col-md-2 col-xs-12">				
						<label class="control-label">CPF nº</label>
						<input class="form-control" type="text" id="cpf" name="cadastro.cpf" onblur="validaCPF()"
						placeholder="000.000.000-00" maxlength="14" OnKeyPress="formatar('###.###.###-##', this)" required>
					</div>				
					<div class="col-md-3 col-xs-12">
						<label class="control-label">RG nº</label>
						<input class="form-control" type="text" name="cadastro.rg" placeholder="apenas números" pattern="[0-9]+$" required>
					</div>
					<div class="col-md-2 col-xs-12">
						<label class="control-label">Emissor/UF</label>
						<input class="form-control toUpper" type="text" name="cadastro.emissor" required>
					</div>															
				</div>
				
				
				<div class="row">
					<div class="col-md-3 col-xs-12">
						<label class="control-label">Data Nascimento</label>
						<input class="form-control" type="text" name="cadastro.nascimento" placeholder="dd/mm/aaaa" maxlength="10" OnKeyPress="formatar('##/##/####', this)" required>
					</div>					
					<div class="col-md-4 col-xs-12">					
						<label class="control-label">Celular</label>
						<input class="form-control" type="text" name="cadastro.telefone" placeholder="00-00000-0000" OnKeyPress="formatar('##-#####-####', this)" required>
					</div>
					<div class="col-md-5 col-xs-12">
						<label class="control-label">E-mail</label>
						<input class="form-control" type="email" name="cadastro.email" placeholder="email@exemplo.com" required>
					</div>										
				</div>
				
				<div class="row">
					<div class="col-md-2 col-xs-12">
						<label class="control-label">Tipo Isenção</label>
					    <select class="form-control" name="cadastro.isencao">
					
					        <option value="Nenhum">Nenhuma</option>
							<option value="Doador">Doador de Sangue</option>
							<option value="Portador">Portador de Deficiência</option>
							
					    </select>
					</div>
					<div class="col-md-6 col-xs-12">
						<label class="control-label">Endereço</label>
						<input class="form-control toUpper" type="text" name="cadastro.endereco" placeholder="avenida/rua/travessa, nº" required>
					</div>
					<div class="col-md-4 col-xs-12">					
						<label class="control-label">Bairro</label>
						<input class="form-control toUpper" type="text" name="cadastro.bairro" required>
					</div>
				</div>
			

				<div class="row">
					<div class="col-md-5 col-xs-12">
						<label class="control-label">Complemento</label>
						<input class="form-control toUpper" type="text" name="cadastro.complemento">
					</div>										
					<div class="col-md-2 col-xs-12">
						<label class="control-label">CEP</label>
						<input class="form-control" type="text" name="cadastro.cep" placeholder="00000-000" maxlength="9" OnKeyPress="formatar('#####-###', this)" required>
					</div>										
					<div class="col-md-2 col-xs-12">					
						<label class="control-label">Estado</label>
					    <select class="form-control" id="select_estados"
					            name="cadastro.estado" required>
					
					        <option></option>
					        
					        <c:forEach var="cad" items="${estados}">
						        <option value="${cad.uf}">${cad.uf}</option>
					        </c:forEach>
					
					    </select>
					</div>
					<div class="col-md-3 col-xs-12">
						<label class="control-label">Municipio</label>
					    <select class="form-control" id="select_municipios" 
					            name="cadastro.cidade" required>  
					
					        <option></option>
					
					    </select>
					</div>										
				</div>

				<div class="row">
					<div class="col-md-3 col-xs-12">
						<br><br>
						<label class="control-label">Necessidade Especial?</label>
						<input type="radio" name="cadastro.necessidade" value="true">SIM
						<input type="radio" name="cadastro.necessidade" checked value="false">NÃO
					</div>										
					<div class="col-md-9 col-xs-12">
						<label class="control-label">Especificar</label>
						<textarea rows="4" cols="4" class="form-control toUpper" name="cadastro.tiponecessidade"></textarea> 
					</div>										
				</div>
				<br>
				<div class="button-group ">
				    <input class="btn btn-md btn-primary" type="submit" value="Enviar" />
				    <input class="btn btn-md btn-warning" type="button" id="cancelar" value="Cancelar" />
			    </div>
				    
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
		
	$("#form_cad_insc").submit(function(e){
		
		e.preventDefault();		

		var formulario = $(this).serialize();

		if(validaCPF()){

	        $.ajax({
	            type: 'POST',
	            url: '<c:url value="/cadastro/inscricao"/>',
	            data: formulario,
	            dataType: 'json',
	            success: function(msg) {
	            	bootbox.hideAll();
	            	bootbox.confirm({
	            	    message: msg,
	            	    buttons: {
	            	        confirm: {
	            	            label: 'Sim',
	            	            className: 'btn-success'
	            	        },
	            	        cancel: {
	            	            label: 'Não',
	            	            className: 'btn-danger'
	            	        }
	            	    },
	            	    callback: function (result) {
	            	    	if(result){
	            	    		location.href = '<c:url value="/cadastro/reimpressao/"/>'+$('#cpf').val();
	            	    	}	            	        
	            	    }
	            	});
	            },
	            error: function() {

	                alert('erro');

	            }

	        });
			
		}else{
			alert("CPF inválido!");
			bootbox.hideAll();
		}
		
		
	});
	
	$('#cancelar').on('click', function(){
		location.href = "http://pgm.teresina.pi.gov.br/";
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



function validaCPF()
{
  var cpf = $('#cpf').val();

  cpf = cpf.replace(/[^\d]+/g,'');
  
  var numeros, digitos, soma, i, resultado, digitos_iguais;
  digitos_iguais = 1;
  if (cpf.length < 11)
        return false;
  for (i = 0; i < cpf.length - 1; i++)
        if (cpf.charAt(i) != cpf.charAt(i + 1))
              {
              digitos_iguais = 0;
              break;
              }
  if (!digitos_iguais)
        {
        numeros = cpf.substring(0,9);
        digitos = cpf.substring(9);
        soma = 0;
        for (i = 10; i > 1; i--)
              soma += numeros.charAt(10 - i) * i;
        resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
        if (resultado != digitos.charAt(0))
              return false;
        numeros = cpf.substring(0,10);
        soma = 0;
        for (i = 11; i > 1; i--)
              soma += numeros.charAt(11 - i) * i;
        resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
        if (resultado != digitos.charAt(1))
              return false;
        return true;
        }
  else
      return false;
}


</script>