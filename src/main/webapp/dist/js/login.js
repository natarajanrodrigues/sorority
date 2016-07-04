/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//INICIO FUNCOES LOGIN
$("#modal-login").on("shown.bs.modal", function () {
    $("#email").focus();
});

$("#modal-login").on("hidden.bs.modal", function () {
    $('#alertaErroLogin').hide();
});

//funções para quando o botão entrar é clicado 
$('#btnEntrar').click(function ()
{

    var email = $('#email').val();
    var pwd = $('#password').val();

    $.ajax({
        type: "POST",
        url: "Login",
        data: {"email": email, "password": pwd},
        success: function (response) {
            if (response === "TRUE") {
                $(location).attr('href', 'home.jsp');
            } else {
                $('#alertaErroLogin').show(250);
            }
        }
    });
});

//função para quando pressiona ENTER dentro do input da senha ou login 
$('#email').keypress(function (e) {
    if (e.which === 13) { // se digitar um enter nesse componente (password)
        $('#btnEntrar').click();
    }
});

$('#password').keypress(function (e) {
    if (e.which === 13) { // se digitar um enter nesse componente (password)
        $('#btnEntrar').click();
    }
});
//FIM FUNCOES LOGIN


//FUNÇÕES CADASTRO
function processaCadastro() {
    event.preventDefault();

    $('#alertaErroLogin').hide();

    var dados = $("#formulario_cadastro").serialize();

    var data = dados;

    $.post("cadastrar", data, function (responseJson) {

        var resultado = responseJson.passou;
        $('p').addClass("hidden");
        $("div").removeClass("has-error");

        if (resultado === "true") {
            $(location).attr('href', 'home');
        } else {
            $.each(responseJson, function (key, value) {
                if (key === "emailJaExiste") {
                    $('#alertaErroCadastro').show(250).text(value);
                    $("#emailCadastro").parent("div").addClass("has-error");
                } else {
                    $("#" + key).next("p").html(value).removeClass("hidden");
                }

                $("#" + key).parent("div").addClass("has-error");

            });
        }
    });

}

$('#btnCadastrar').click(processaCadastro);

