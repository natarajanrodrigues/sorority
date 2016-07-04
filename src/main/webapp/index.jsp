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

        <header>
            <nav class="navbar navbar-default navbar-fixed-top">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#example">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <!--<a href="" class="navbar-brand">Sorority</a>-->
                        <img src="/imagens/logo_sorority small.WebP" class="navbar-brand">
                    </div>

                    <input id="pac-input" type="text" class="navbar-brand2 navbar-collapse controls" placeholder="Digite uma localidade aqui">

                    <div class="collpase navbar-collapse" id="example">
                        <!--                        <form action="" class="navbar-form navbar-left" role="search">
                                                    <div class="form-group">
                                                        <input id="pac-input" type="text" class="form-control controls" placeholder="Digite uma localidade aqui">
                                                    </div>
                                                    <button type="submit" class="btn btn-primary">Buscar</button>
                                                </form>-->

                        <!--                        <input id="pac-input" type="text" class="navbar-form controls" placeholder="Digite uma localidade aqui">-->

                        <!--<button type="button" class="btn btn-primary navbar-btn navbar-right" data-toggle="modal" data-target="#modal-login">Login</button>-->

                        <a class="btn navbar-btn navbar-right" data-toggle="modal" data-target="#modal-login">Cadastrar-se</a>
                    </div>

                </div>
            </nav>
        </header>
        <div class="container">
            <br><br><br>
            <!--<input id="pac-input" class="controls" type="text" placeholder="Search Box">-->
            <div id="map" >

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
            <form action="/sislivros/logged/livro/cadastrar.do" id="formLivro" method="post" enctype="multipart/form-data">

                <div class="form-group">
                    <label for="Local" class="control-label">Local</label>
                    <input type="text" id="local" name="local" class="form-control">
                </div>

                <div class="form-group ">
                    <label for="isbn" class="control-label">Tipo</label>
                    <select class="form-control" id="tipo" name="tipo" required> 
                        <option value="1">Assédio</option> 
                        <option value="2">Violência</option> 
                        <option value="3">Estupro</option> 
                    </select>
                </div>

                <div class="form-group">
                    <label for="informacao" class="control-label">Informações adicionais</label>
                    <textarea id="informacao" name="informacao" class="form-control" rows="5"></textarea>
                </div>
            </form>
        </div>

        <br><br><br>

        <!--FOOTER-->
        <footer>

        </footer>

        <!-- Latest compiled and minified JavaScript -->
        <script src="dist/js/jquery-2.1.4.min.js"></script>
        <script src="dist/js/bootstrap.min.js"></script>

        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBab8JBkgtgI3IPJLQiCol30M8nEvE2ER4&libraries=places,geometry&callback=initMap"
        async defer></script>

        <script>
                    var map;

                    var markers = [];

                    $(document).ready(function () {
                        
                    });


                    function initMap() {
                        map = new google.maps.Map(document.getElementById('map'), {
                            center: {lat: -34.397, lng: 150.644},
                            zoom: 15
                        });

                        var infoWindow = new google.maps.InfoWindow({map: map});

                        // Try HTML5 geolocation.
                        if (navigator.geolocation) {
                            navigator.geolocation.getCurrentPosition(function (position) {
                                var pos = {
                                    lat: position.coords.latitude,
                                    lng: position.coords.longitude
                                };

                                infoWindow.setPosition(pos);
                                infoWindow.setContent('Você está aqui.');
                                map.setCenter(pos);
                            }, function () {
                                handleLocationError(true, infoWindow, map.getCenter());
                            });
                        } else {
                            // Browser doesn't support Geolocation
                            handleLocationError(false, infoWindow, map.getCenter());
                        }

                        //RELATIVO AO BUSCADOR

                        // Create the search box and link it to the UI element.
                        var input = document.getElementById('pac-input');
                        var searchBox = new google.maps.places.SearchBox(input);

                        // Bias the SearchBox results towards current map's viewport.
                        map.addListener('bounds_changed', function () {
                            searchBox.setBounds(map.getBounds());
                        });

                        // Listen for the event fired when the user selects a prediction and retrieve
                        // more details for that place.
                        searchBox.addListener('places_changed', function () {
                            var places = searchBox.getPlaces();

                            if (places.length === 0) {
                                return;
                            }

                            // Clear out the old markers.
                            markers.forEach(function (marker) {
                                marker.setMap(null);
                            });
                            markers = [];

                            // For each place, get the icon, name and location.
                            var bounds = new google.maps.LatLngBounds();
                            places.forEach(function (place) {
                                var icon = {
                                    url: place.icon,
                                    size: new google.maps.Size(71, 71),
                                    origin: new google.maps.Point(0, 0),
                                    anchor: new google.maps.Point(17, 34),
                                    scaledSize: new google.maps.Size(25, 25)
                                };

                                // Create a marker for each place.
                                markers.push(new google.maps.Marker({
                                    map: map,
                                    icon: icon,
                                    title: place.name,
                                    position: place.geometry.location
                                }));

                                if (place.geometry.viewport) {
                                    // Only geocodes have viewport.
                                    bounds.union(place.geometry.viewport);
                                } else {
                                    bounds.extend(place.geometry.location);
                                }
                            });
                            map.fitBounds(bounds);
                        });
                    }

                    function handleLocationError(browserHasGeolocation, infoWindow, pos) {
                        infoWindow.setPosition(pos);
                        infoWindow.setContent(browserHasGeolocation ?
                                'Error: The Geolocation service failed.' :
                                'Error: Your browser doesn\'t support geolocation.');
                    }

                    //This function enable adding markers to map
                    function enableAddMarker() {
                        google.maps.event.addListenerOnce(map, 'click', function (event) {
                            addMarker(event.latLng);
                        });
                    }

                    function disableAddMarker() {
                        //map.clearListeners(map,'click');
                        addListener.remove();
                    }

                    // Adds a marker to the map and push to the array.
                    function addMarker(location) {
                        var marker = new google.maps.Marker({
                            position: location,
                            map: map
                        });

                        $('#local').val(marker.position.lat());

                        var infowindow = new google.maps.InfoWindow({
                            content: '<div><button type="button" onclick="closeThisMarker()" class="btn btn-default" aria-label="Left Align">' +
                                    '<span class="glyphicon glyphicon-align-left" aria-hidden="true"></span> Remover ' +
                                    '</button></div>',
                            maxWidth: 200
                        });

                        marker.addListener('click', function () {
                            infowindow.open(map, marker);
                            infowindow.marker = marker;
                            $('#local').val(marker.position.lat());
                        });

                        markers.push(marker);
                    }

                    function closeMarker() {
                        for (var i = 0; i < markers.length; i++) {

                            google.maps.event.clearInstanceListeners(markers[i], 'click');

                            markers[i].addListener('click', function () {
                                this.setMap(null);
                                $('#local').val(" ");
                            });
                        }
                    }

                    function closeThisMarker() {
                        infoWindow.marker.setMap(null);
                    }

        </script>

        <!--        
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBab8JBkgtgI3IPJLQiCol30M8nEvE2ER4&libraries=places&signed_in=true&callback=initMap"
                        async defer>
                </script>-->
        <!--<script type="text/javascript" src="http://maps.google.com/maps/api/js?libraries=places&sensor=false"></script>-->



    </body> 
</html>

