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

        <!-- Datepicker -->
        <link rel="stylesheet" href="dist/css/datepicker/bootstrap-datepicker.min.css">

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
                        <a href=""><img src="imagens/logo_sorority small.WebP" class="navbar-brand" style="padding: 10px"></a>

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
            <div class="container-fluid col-md-4" style="margin: 0 0 10px 0" role="group">
                <h4>Marcadores</h4>
                <div class="checkbox-inline">
                    <label>
                        <input type="checkbox" class="check_marker" id="check_ASSÉDIO" checked> Assédio
                    </label>
                </div>
                <div class="checkbox-inline">
                    <label>
                        <input type="checkbox" class="check_marker" id="check_ESTUPRO" checked> Estupro
                    </label>
                </div>
                <div class="checkbox-inline">
                    <label>
                        <input type="checkbox" class="check_marker" id="check_VIOLÊNCIA" checked> Violência
                    </label>
                </div>
                <div class="checkbox-inline">
                    <label>
                        <input type="checkbox" id="check_todos" checked> Todos
                    </label>
                </div>
                
                <input type="checkbox" id="check_heatmap" hidden>
                
            </div>            
            <div class="container-fluid col-md-8" style="margin: 0 0 10px 0" role="group">

                <h4>Filtrar por Data</h4>
                <div class="form-inline col-md-8">
                    <label for="Local" class="control-label">Início</label>
                    <div class="input-group date col-md-5 col-sm-5" id="datepicker1" data-provide="datepicker" data-date-format="dd/mm/yyyy">
                        <input type="text" class="form-control" id="dataInicio" name="dataInicio" placeholder="dd/mm/aaaa">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                    <label for="Local" class="control-label">Fim</label>
                    <div class="input-group date col-md-5 col-sm-5" id="datepicker1" data-provide="datepicker" data-date-format="dd/mm/yyyy">
                        <input type="text" class="form-control" id="dataFim" name="dataFim" placeholder="dd/mm/aaaa">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>

                </div>
                <button onclick="buscarPorData()" type="button" class="btn btn-default" aria-label="Buscar por data">
                    <span class="glyphicon glyphicon-search" aria-hidden="true"></span> Buscar
                </button>
                <button type="button" onclick="reset()" class="btn btn-default" aria-label="Left Align">
                    <span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> Reset 
                </button>

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

        <!--FOOTER-->
        <footer>

        </footer>

        <!-- Latest compiled and minified JavaScript -->
        <script src="dist/js/jquery-2.1.4.min.js"></script>

        <script src="dist/js/bootstrap.min.js"></script>

        <script src="dist/js/login.js"></script>
        <script type="text/javascript" src="dist/js/date.format.js"></script>
        <script src="dist/js/checkbuttons.js"></script>
        <!--        <script type="text/javascript"
                src="https://maps.googleapis.com/maps/api/js?libraries=visualization"></script>-->

        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyBab8JBkgtgI3IPJLQiCol30M8nEvE2ER4&libraries=visualization,places,geometry&callback=initMap"
        async defer></script>

        <script src="dist/js/mapsFunctions.js"></script>
        <script type="text/javascript" src="dist/js/datepicker/bootstrap-datepicker.min.js"></script>

        <script type="text/javascript" src="dist/js/datepicker/bootstrap-datepicker.pt-BR.min.js"></script>
        <script>
                                $(document).ready(function () {
                                    $('#datepicker1').datepicker({
                                        pickTime: false,
                                        format: 'dd/mm/yyyy',
                                        language: "pt-BR"
                                    });
                                });
        </script>


    </body> 
</html>

