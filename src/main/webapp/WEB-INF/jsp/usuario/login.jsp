	
	
	<div class="card bg-faded">
		<div class="well col-md-4 col-xs-12 col-md-offset-4" id="login">
			<div class="col-md-12 col-xs-12">
				<img alt="Login" 
					src="https://sldlivros.com.br/financeiro/assets/images/user_login.png"
					width="20%" height="auto" class="img-responsive center-block">
			</div>			
			<form action="<c:url value="/usuario/logon"/>" method="post">
				
				<div class="row">
					<div class="col-md-12 col-xs-12">
						<label class="control-label">Usuário</label>
						<input class="form-control" type="text" name="usuario.login" required>
					</div>
				</div>
				<div class="row">	
					<div class="col-md-12 col-xs-12">				
						<label class="control-label">Senha</label>
						<input class="form-control" type="password" name="usuario.senha" required>
					</div>				
				</div>
			    <br>
				<div class="button-group">
				    <input class="btn btn-md btn-primary" type="submit" value="Enviar" />
				    <input class="btn btn-md btn-warning" type="button" id="cancelar" value="Cancelar" />
			    </div>
				    
			</form>
			<p style="color: red; font-size: 10pt; text-align: left;">${errorlogin}</p>
		</div>
	</div>



<script>

$(document).ready(function()
{
	
	$('#cancelar').on('click', function(){
		location.href = "http://pgm.teresina.pi.gov.br/";
	});
	
});

</script>