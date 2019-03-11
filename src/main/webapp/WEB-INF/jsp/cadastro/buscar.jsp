	
	
	<div>
		<h3>PROCESSO SELETIVO ESTÁGIO - 
			  <%=
			  	fmtyear.format(new java.util.Date())
			  %>			
		</h3>
		<h5>Reimpressão de comprovante</h5>
	</div>
	

	<div class="card bg-faded">
		<div class="well">
			<form>
				
				<div class="row">
					<div class="col-md-2 col-xs-12">				
						<label class="control-label">CPF nº</label>
						<input class="form-control" type="text" id="cpf" placeholder="000.000.000-00" maxlength="14" OnKeyPress="formatar('###.###.###-##', this)" required>
					</div>				
				</div>

			    <br>

				<div class="button-group">
				    <input class="btn btn-md btn-primary" id="enviar" type="button" value="Enviar" />
				    <input class="btn btn-md btn-primary" type="button" id="cancelar" value="Cancelar" />
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
	
	$('#cancelar').on('click', function(){
		location.href = "http://pgm.teresina.pi.gov.br/";
	});
	
	$('#enviar').on('click', function(){
		location.href = "<c:url value='/cadastro/reimpressao/'/>"+$('#cpf').val();
	});
});

</script>