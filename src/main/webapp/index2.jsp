<%-- 
    Document   : index
    Created on : 23/06/2016, 18:11:49
    Author     : Natarajan 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt_BR">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sorority</title>
        <meta name="description" content="Sorority index">
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="dist/css/bootstrap.min.css">

        <!-- Optional theme -->
        <link rel="stylesheet" href="dist/css/bootstrap-theme.min.css">        
        <link rel="stylesheet" href="dist/css/sororitypersonalcss.css">
    </head>

    <body>

        <!--Modal Login-->
        <div class="modal fade" id="modal-login">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h3 class="modal-title modal-title-center form-singin-heading">Login</h3>
                    </div>
                    <div class="modal-body" id="corpoModalLogin">
                        <form id="formulario" class="form-signin" method="post">
                            <div class="form-group">
                                <label for="email" class="control-label">Email</label>
                                <input type="text" id="email" name="email" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="password" class="control-label">Senha</label>
                                <input type="password" id="password" name="password" class="form-control" required>
                            </div>
                            <div id="alertaErroLogin" class="alert alert-danger alert-dismissible" role="alert" hidden>
                                <strong>Falha no login!</strong> Informações de email e senha incorretas.
                            </div>
                        </form>
                    </div>

                    <div class="modal-footer">
                        <a href="" class="btn btn-default" data-dismiss="modal">Cancelar</a>
                        <a id="btnEntrar" type="submit" class="btn btn-primary">Entrar</a>
                    </div>
                </div>
            </div>
        </div>

        <header>
            <nav class="navbar navbar-default navbar-fixed-top">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#example">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a href="" class="navbar-brand">Sorority</a>
                    </div>

                    <input id="pac-input" type="text" class="navbar-brand2 navbar-collapse controls" placeholder="Digite uma localidade aqui">

                    <div class="collpase navbar-collapse" id="example">

                        <div class="groupButtonIndex">

                            <button type="button" class="btn btn-primary navbar-btn navbar-right" data-toggle="modal" data-target="#modal-login">Login</button>

                            <ul class="nav navbar-nav navbar-right">
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Cadastre-se</a>

                                    <div class="dropdown-menu" style="padding:10px; min-width:300px;">

                                        <form action="cadastro" id="formulario_cadastro" method="post" class="col-md-12">
                                            <div class="form-group has-feedback">
                                                <label for="element-1" class="control-label">Nome Completo</label>
                                                <input type="text" id="nome" class="form-control" name="nome" placeholder="Digite seu nome" pattern="[A-Za-zÀ-ú0-9 ]+" title="Nome não pode conter caracteres especiais (% - $ _ # @, por exemplo)." required>
                                                <p class="help-block hidden"></p>
                                            </div>

                                            <div class="container row " style="width: 100%">
                                                <div class="form-group has-feedback">
                                                    <label for="element-7" class="control-label">Email</label>
                                                    <input type="text" id="emailCadastro" class="form-control" name="email" 
                                                           placeholder="Informe seu email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" title="Digite um email válido" required>
                                                    <p class="help-block hidden"></p>
                                                </div>

                                                <div class="form-group has-feedback">
                                                    <label for="element-8" class="control-label">Senha</label>
                                                    <input type="password" id="senhaCadastro" class="form-control" name="senha" placeholder="Escolha sua senha" required>
                                                    <p class="help-block hidden"></p>

                                                </div>
                                                <div id="alertaErroCadastro" class="alert alert-danger alert-dismissible" role="alert" hidden></div>


                                                <!--<button type="submit" class="btn btn-primary" form="formulario_cadastro">Enviar</button>-->
                                            </div>
                                            <a id="btnCadastrar" form="formulario_cadastro" type="submit" class="btn btn-primary">Cadastrar</a>    
                                        </form>



                                    </div>
                                </li>
                            </ul>



                            <!--<a class="btn navbar-btn navbar-right" data-toggle="modal" data-target="#modal-login">Cadastrar-se</a>-->
                        </div>

                    </div>

                </div>
            </nav>
        </header>
        <div class="container">
            <!--<input id="pac-input" class="controls" type="text" placeholder="Search Box">-->
            <div id="map">

            </div>            
        </div>

        <div class="container" >
            <div class="container-fluid" style="margin: 0 0 10px 0" role="group">
                <h4>Marcadores</h4>
                <div class="checkbox-inline">
                    <label>
                        <input type="checkbox" class="check_marker" id="check_assedio" checked> Assédio
                    </label>
                </div>
                <div class="checkbox-inline">
                    <label>
                        <input type="checkbox" class="check_marker" id="check_estupro" checked> Estupro
                    </label>
                </div>
                <div class="checkbox-inline">
                    <label>
                        <input type="checkbox" class="check_marker" id="check_violencia" checked> Violência
                    </label>
                </div>
                <div class="checkbox-inline">
                    <label>
                        <input type="checkbox" id="check_todos" checked> Todos
                    </label>
                </div>
            </div>            
        </div>

        <div class="container">
            <div class="">
                <div class="btn-group btn-group-justified ">
                    <div class="col-md-4">
                        <div class="btn-group" role="group ">
                            <button type="button" onclick="toogleHeatmap()" class="btn btn-default" aria-label="Left Align">
                                <span class="glyphicon glyphicon-fire" aria-hidden="true"></span> Heatmap
                            </button>
                        </div>    
                    </div>


                </div>            
            </div>
        </div>

        <br><br><br>
        <div class="container col-md-6 col-md-push-3">
            <form action="DenunciaAddController" id="formDenuncia" method="post">

                <div class="form-group">
                    <label for="Local" class="control-label">Local</label>
                    <input type="text" id="local" name="local" class="form-control">
                </div>

                <div class="form-group ">
                    <label for="isbn" class="control-label">Tipo</label>
                    <select class="form-control" id="tipo" name="tipo" required> 
                        <option value="ASSEDIO">Assédio</option> 
                        <option value="VIOLENCIA">Violência</option> 
                        <option value="ESTUPRO">Estupro</option> 
                    </select>
                </div>

                <div class="form-group">
                    <label for="informacao" class="control-label">Informações adicionais</label>
                    <textarea id="informacao" name="informacao" class="form-control" rows="5"></textarea>
                </div>


            </form>
            <div>
                <input type="submit" form="formDenuncia" class="btn btn-primary" value="Salvar">
                <a id="bntCancela" href="administrativo.jsp" class="btn btn-default ">Cancelar</a>
            </div>

            <br><br><br>
        </div>

        <br><br><br>

        <!--FOOTER-->
        <footer>

        </footer>

        <!-- Latest compiled and minified JavaScript -->
        <script src="dist/js/jquery-2.1.4.min.js"></script>

        <script src="dist/js/bootstrap.min.js"></script>

        <script src="dist/js/login.js"></script>
        <script src="dist/js/checkbuttons.js"></script>
        <!--        <script type="text/javascript"
                src="https://maps.googleapis.com/maps/api/js?libraries=visualization"></script>-->

        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyBab8JBkgtgI3IPJLQiCol30M8nEvE2ER4&libraries=visualization,places,geometry&callback=initMap"
        async defer></script>

        <script src="dist/js/mapsFunctions.js"></script>
        

    </body> 
</html>

