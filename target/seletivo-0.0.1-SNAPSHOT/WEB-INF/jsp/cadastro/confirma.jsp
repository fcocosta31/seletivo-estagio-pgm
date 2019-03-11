

<div>
    <h3>PROCESSO SELETIVO ESTÁGIO -
        <%=
        fmtyear.format(new java.util.Date())
        %>
    </h3>
    <h5>Confirmação de Inscrição</h5>
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
                <input class="btn btn-md btn-danger" type="button" id="listarinscritos" value="Listar Inscritos" />
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

        $('#listarinscritos').on('click', function(){
            location.href = '<c:url value="/cadastro/lista"/>';
        });

        $('#enviar').on('click', function(){
            $.ajax({
                url: '<c:url value="/cadastro/confirmacao/"/>'+$("#cpf").val(),
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
        });
    });

</script>