/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var map, heatmap, localLayer;
var infowindow2;
var markers = [];



function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: -7.057282352971568, lng: -38.58467135578394},
        zoom: 5
    });

    var infoWindow = new google.maps.InfoWindow({map: map});

    map.addListener('click', function (event) {
        infoWindow.close(map);
    });

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

    //load saved markers
    loadLocations();


    //markers visible checkbuttons
    $('#check_ASSÉDIO').change(function () {

        var check_value = $('#check_ASSÉDIO').prop('checked');
        localLayer.forEach(function (feature) {
            if (feature.getProperty('tipo') === 'ASSÉDIO') {
                localLayer.overrideStyle(feature, {'visible': check_value});
            }
        });

    });

    $('#check_ESTUPRO').change(function () {

        var check_value = $('#check_ESTUPRO').prop('checked');
        localLayer.forEach(function (feature) {
            if (feature.getProperty('tipo') === 'ESTUPRO') {
                localLayer.overrideStyle(feature, {'visible': check_value});
//                feature.setProperty('visible', false);
            }
        });
    });

    $('#check_VIOLÊNCIA').change(function () {
        var check_value = $('#check_VIOLÊNCIA').prop('checked');
        localLayer.forEach(function (feature) {
            if (feature.getProperty('tipo') === 'VIOLÊNCIA') {
                localLayer.overrideStyle(feature, {'visible': check_value});
            }
        });
    });


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
                scaledSize: new google.maps.Size(35, 35)
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


function loadLocations() {

    infowindow2 = new google.maps.InfoWindow({map: null, zindex: 100});

    //mapping icons 
    iconMarker = {
        ASSÉDIO: {icon: 'icons/letter_a.png'},
        VIOLÊNCIA: {icon: 'icons/letter_v.png'},
        ESTUPRO: {icon: 'icons/letter_e.png'}
    };


    if (localLayer === undefined) {
        localLayer = new google.maps.Data();
    } else {
//
//        localLayer.setMap(null);
////        localLayer.forEach(function(feature){
////            localLayer.remove(feature);
////        });        
////        localLayer = new google.maps.Data();
    }



    localLayer.loadGeoJson('DenunciaGetAll');

    //setting icons markers
    localLayer.setStyle(function (feature) {
        return /** @type {google.maps.Data.StyleOptions} */{
            icon: iconMarker[feature.getProperty('tipo')].icon
//            ,
//            visible: true
        };
    });

    //showing icons on map
    localLayer.setMap(map);

    localLayer.addListener('click', function (event) {
        var myHTML = event.feature.getProperty("id");

        var id = event.feature.getProperty("id");
        var tipo = event.feature.getProperty("tipo");
        var tipo_denunciador = event.feature.getProperty("tipo_denunciador");
        var eh_anonima = event.feature.getProperty('eh_anonima');
        var informacao = event.feature.getProperty('informacao');
        var data = event.feature.getProperty('data_denuncia');


        var dataFeature = new Date(Date.parse(data));
        dataFeature.setDate(dataFeature.getDate() + 1);

        var dataFormatada = dateFormat(dataFeature, "dd/mm/yyyy");

        var dados = {"length": 6, "id: ": id, "Tipo de Ocorrência: ": tipo, "Tipo de denunciador: ": tipo_denunciador, "Denúncia Anônima": (true ? 'sim' : 'nao'), "Data: ": data, "Informação: ": informacao};
        var dados2 = {"id: ": id, "Tipo de Ocorrência: ": tipo, "Tipo de denunciador: ": tipo_denunciador, "Denúncia Anônima: ": (true ? 'sim' : 'nao'), "Data: ": dataFormatada, "Informação: ": informacao};
        var dadosArray = $.makeArray(dados);


        var text = "<div style='max-width:300px'>";

        $.map(dados2, function (val, i) {
            text += "<p><strong>" + i + "</strong>" + val + "</p>";
        });

        text += "</div>";

        infowindow2.setContent(text);
        // position the infowindow on the marker
        infowindow2.setPosition(event.feature.getGeometry().get());
        // anchor the infowindow on the marker
        infowindow2.setOptions({pixelOffset: new google.maps.Size(0, -30)});
        infowindow2.open(map);
    });

    map.addListener('click', function (event) {
        infowindow2.close(map);
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
    map.setOptions({ draggableCursor : 'alias' });
        
    google.maps.event.addListenerOnce(map, 'click', function (event) {
        addMarker(event.latLng);
    });
}

function disableAddMarker() {
    addListener.remove();
}

// Adds a marker to the map and push to the array.
function addMarker(location) {
    
    map.setOptions({ draggableCursor : null });
    
    var marker = new google.maps.Marker({
        position: location,
        map: map, 
        animation: google.maps.Animation.DROP,
        draggable: true
    });
    $('#local').val(marker.position.lng() + " " + marker.position.lat());

    var contentString = $('<div><button type="button" id="removerMarcadorButton" class="btn btn-default" aria-label="Left Align">' +
            '<span class="glyphicon glyphicon-align-left" aria-hidden="true"></span> Remover ' +
            '</button></div>');

    var infowindow = new google.maps.InfoWindow({
        content: contentString[0],
        maxWidth: 200
    });

    marker.addListener('click', function () {
        infowindow.open(map, marker);
        infowindow.marker = marker;
        $('#local').val(marker.position.lng() + " " + marker.position.lat());

        var removeBtn = document.getElementById('removerMarcadorButton');
        if (removeBtn !== null) {
            google.maps.event.addDomListener(removeBtn, "click", function (event) {
                marker.setMap(null);
            });
        }

        $('#modal-denuncia').modal('show');

    });

    markers.push(marker);

    timeout = window.setTimeout(function () {$('#modal-denuncia').modal('show');}, 1000);
    
}

function closeMarker() {
    for (var i = 0; i < markers.length; i++) {
        google.maps.event.clearInstanceListeners(markers[i], 'click');
        markers[i].addListener('click', function () {
            //this.setVisible(false);
            this.setMap(null);
            $('#local').val(" ");
        });
    }
}

function removeAllMarkers() {
    
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }
}

function closeThisMarker() {
    infoWindow.marker.setMap(null);
}

var heatmapData = [];

function toogleHeatmap() {
    //on/off all markers
    $('#check_heatmap').trigger('click');

    if ($('#check_heatmap').prop('checked') === true) {
        
        var places;
        heatmapData = [];

        localLayer.forEach(function (feature) {
            var tipo = feature.getProperty('tipo');
            if ($('#check_' + tipo).prop('checked') === true) {
                tmpLatLng = feature.getGeometry().get();
            heatmapData.push(tmpLatLng);
            }
            
        });

        heatmap = new google.maps.visualization.HeatmapLayer({
            data: heatmapData,
            map: map
        });
        heatmap.setMap(map);
    } else {
        if (heatmap !== undefined)
            heatmap.setMap(null);
    }
    
}



$('#btnDenunciar').click(processaDenuncia);

function processaDenuncia() {
    event.preventDefault();

    var dados = $("#formDenuncia").serialize();

    $.post("DenunciaAddController", dados, function (responseJson) {

        var resultado = responseJson.passou;

        if (resultado === "true") {
            
            $('#modal-denuncia').modal('hide');
            removeAllMarkers();
            loadLocations();
            
        } else {
            
            alert('Ocorreu um erro ao cadastrar Denuncia');
        }
    });

}


$('#modal-denuncia').on('hidden.bs.modal', function () {
    $(this).find('form')[0].reset();
});


function reset() {
    
    for (var i = 0; i < markers.length; i++){
        markers[i].setMap(null);
    }
    
    if ($('#check_todos').prop('checked') === false){
        $('#check_todos').trigger('click');
    }
    
    $('#dataInicio').val('');
    $('#dataFim').val('');
    
    if ($('#check_heatmap').prop('checked') === true) {
        $('#check_heatmap').trigger('click');
    }
    
    
    localLayer.setMap(null);
    localLayer.forEach(function (feature) {
        localLayer.remove(feature);
    });
    localLayer.setMap(map);
    
    if (heatmap !== undefined)
        heatmap.setMap(null);
    
    loadLocations();
}

function buscarPorData() {
    
    if ($('#check_heatmap').prop('checked', true)){
        toogleHeatmap();
    }

    $('#check_heatmap').prop('checked', false);

    $('#dataInicio').datepicker({
        pickTime: false,
        format: 'dd/mm/yyyy',
        language: "pt-BR"
    });

    $('#dataFim').datepicker({
        pickTime: false,
        format: 'dd/mm/yyyy',
        language: "pt-BR"
    });

    var dataInicio = $("#dataInicio").datepicker("getDate");
    var dataFim = $("#dataFim").datepicker("getDate");


    localLayer.forEach(function (feature) {

        var data = feature.getProperty('data_denuncia');
        var dataFeature = new Date(Date.parse(data));
        dataFeature.setDate(dataFeature.getDate() + 1);


        if (dataFeature.getDate() >= dataInicio.getDate() && dataFeature.getDate() <= dataFim.getDate()) {
            var tipo = feature.getProperty('tipo');

            if ($('check_' + tipo).prop('checked') === true) {
                localLayer.overrideStyle(feature, {'visible': true});
            }

        } else {

            localLayer.overrideStyle(feature, {'visible': false});
            localLayer.remove(feature);

        }
    });

}