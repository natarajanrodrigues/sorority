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
