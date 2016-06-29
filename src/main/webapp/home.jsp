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
            <div class="container-fluid" style="margin: 0 0 10px 0" role="group">
                <h4>Marcadores</h4>
                <div class="checkbox-inline">
                    <label>
                        <input type="checkbox" class="check_marker" id="check_assedio"> Assédio
                    </label>
                </div>
                <div class="checkbox-inline">
                    <label>
                        <input type="checkbox" class="check_marker" id="check_estupro"> Estupro
                    </label>
                </div>
                <div class="checkbox-inline">
                    <label>
                        <input type="checkbox" class="check_marker" id="check_violencia"> Violência
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
            <div class="container-fluid btn-group " role="group">
                <button onclick="enableAddMarker()" type="button" class="btn btn-default" aria-label="Enable Marker">
                    <span class="glyphicon glyphicon-pushpin" aria-hidden="true"></span> Adicionar
                </button>
                <button onclick="disableAddMarker()" type="button" class="btn btn-default" aria-label="Left Align">
                    <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> Visualizar
                </button>
                <button type="button" onclick="closeMarker()" class="btn btn-default" aria-label="Left Align">
                    <span class="glyphicon glyphicon-align-left" aria-hidden="true"></span> Remover
                </button>
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

        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBab8JBkgtgI3IPJLQiCol30M8nEvE2ER4&libraries=places,geometry&callback=initMap"
        async defer></script>        

        <script src="dist/js/mapsFunctions.js"></script>

    </body> 
</html>

