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

        <!--Modal Cadastrar Denúncia-->
        <div class="modal fade" id="modal-denuncia">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h3 class="modal-title modal-title-center form-singin-heading">Denunciar Ocorrência</h3>
                    </div>
                    <div class="modal-body" id="corpoModalLogin">
                        <form action="DenunciaAddController" id="formDenuncia" method="post">

                            <div class="form-group">
                                <label for="Local" class="control-label">Local</label>
                                <input type="text" id="local" name="local" class="form-control">
                                <!--<input type="hidden" id="local" name="local" class="form-control">-->
                            </div>

                            <div class="form-group">
                                <label for="Local" class="control-label">Data</label>
                                <div class="input-group date col-md-5 col-sm-5" id="datepicker1" data-provide="datepicker" data-date-format="dd/mm/yyyy">
                                    <input type="text" class="form-control" id="data" name="data" placeholder="dd/mm/aaaa">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                </div>
                            </div>

                            <div class="form-group ">
                                <label for="isbn" class="control-label">Ocorrência</label>
                                <select class="form-control" id="tipo" name="tipo" required> 
                                    <option value="ASSÉDIO">Assédio</option> 
                                    <option value="VIOLÊNCIA">Violência</option> 
                                    <option value="ESTUPRO">Estupro</option> 
                                </select>
                            </div>

                            <div class="form-group ">
                                <label for="isbn" class="control-label">Tipo de Denunciador</label>
                                <select class="form-control" id="denunciador" name="denunciador" required> 
                                    <option value="TESTEMUNHA">Testemunha</option> 
                                    <option value="VITIMA">Vítima</option> 
                                </select>
                            </div>

                            <div class="form-group ">

                                <label>
                                    <input type="checkbox" name="anonima" checked> Denúncia anônima
                                </label>
                            </div>

                            <div class="form-group">
                                <label for="informacao" class="control-label">Informações adicionais</label>
                                <textarea id="informacao" name="informacao" class="form-control" rows="5"></textarea>
                            </div>
                        </form>
                    </div>

                    <div class="modal-footer">
                        <!--<input type="submit" form="formDenuncia" class="btn btn-primary" value="Salvar">-->
                        <input id="btnDenunciar" type="submit" class="btn btn-primary" value="Denunciar"/>
                        <!--                            <a id="bntCancela" href="administrativo.jsp" class="btn btn-default ">Cancelar</a>-->
                        <a href="" class="btn btn-default" data-dismiss="modal">Cancelar</a>
                        <!--<a id="btnEntrar" type="submit" class="btn btn-primary">Entrar</a>-->
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

                    <div class="collapse navbar-collapse navbar-right" id="example">
                        <ul class="nav navbar-nav">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <img src="" class="profile-image img-circle"style="width: 25px; height:25px; object-fit: cover">  ${usuario.nome}<span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="editarPerfil"><i class="fa fa-user fa-fw"></i> Editar Perfil</a></li>
<!--                                    <c:if test="${usuario.admin}">
                                        <li><a href="administrativo.jsp"><i class="fa fa-cog fa-fw"></i> Painel Administrativo</a></li>
                                    </c:if>-->
                                    <li class="divider"></li>
                                    <li><a href="Logout"><i class="fa fa-sign-out fa-fw"></i> Sair</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>

                </div>
            </nav>
        </header>
        <div class="container">
            <!--<input id="pac-input" class="controls" type="text" placeholder="Search Box">-->
            <div id="map" >

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
            <div class="col-md-4 col-sm-2">
                <div class="btn-group btn-group-justified">
                    <div class="btn-group" role="group">
                        <button onclick="enableAddMarker()" type="button" class="btn btn-default" aria-label="Enable Marker">
                            <span class="glyphicon glyphicon-pushpin" aria-hidden="true"></span> Adicionar
                        </button>
                    </div>

<!--                    <div class="btn-group" role="group">
                        <button onclick="disableAddMarker()" type="button" class="btn btn-default" aria-label="Left Align">
                            <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> Visualizar
                        </button>
                    </div>-->


<!--                    <div class="btn-group" role="group">
                        <button type="button" onclick="closeMarker()" class="btn btn-default" aria-label="Left Align">
                            <span class="glyphicon glyphicon-align-left" aria-hidden="true"></span> Remover
                        </button>
                    </div>-->

                    <div class="btn-group" role="group">
                        <button type="button" onclick="toogleHeatmap()" class="btn btn-default" aria-label="Left Align">
                            <span class="glyphicon glyphicon-fire" aria-hidden="true"></span> Heatmap
                        </button>
                    </div>

<!--                    <div class="btn-group" role="group">
                        <button type="button" onclick="teste()" class="btn btn-default" aria-label="Left Align">
                            <span class="glyphicon glyphicon-fire" aria-hidden="true"></span> Teste
                        </button>
                    </div>-->

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

