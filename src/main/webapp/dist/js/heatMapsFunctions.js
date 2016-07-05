/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var map, heatmap;

function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: -34.397, lng: 150.644},
        zoom: 6
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

    var dados = [];

    var localLayer = new google.maps.Data();
    localLayer.loadGeoJson('DenunciaGetAll');



    var heatmapData = [];

//    $.each(localLayer.features, function (i, data) {
//        createMarker(data);
//    });
//
//    function createMarker(data) {
//        var marker = new google.maps.Marker({
//            position: new google.maps.LatLng(data.geometry.coordinates[1], data.geometry.coordinates[0]),
//            map: map
//        });
//    }


//    for (var i = 0; i < localLayer.features.length; i++) {
//        var coords = localLayer.features[i].geometry.coordinates;
//        var latLng = new google.maps.LatLng(coords[1], coords[0]);
//        dados.push(latLng);
//    }

    jQuery.ajax({
        url: 'DenunciaGetAll',
        dataType: 'json',
        success: function (response) {

            places = response.features;
            // loop through places and add markers
            for (p in places) {
                //create gmap latlng obj
                tmpLatLng = new google.maps.LatLng(places[p].geometry.coordinates[1], places[p].geometry.coordinates[0]);
                // make and place map maker.
//                                    alert(iconMarker[places[p].properties.tipo].icon);
                
//                                    bindInfoWindow(marker, map, infowindow, '<b>' + places[p].name + "</b><br>" + places[p].geo_name);
                // not currently used but good to keep track of markers
                heatmapData.push(tmpLatLng);
            }

        }
    });


//    localLayer.forEach(function (feature) {
//        alert(feature.getProperty('tipo'));
////        dados.push(feature.latLng);
//    });

    heatmap = new google.maps.visualization.HeatmapLayer({
        data: heatmapData,
        map: map
    });


    //RELATIVO AO BUSCADOR

    // Create the search box and link it to the UI element.
    var input = document.getElementById('pac-input');

//    var searchBox = new google.maps.places.SearchBox(input);
//
//    // Bias the SearchBox results towards current map's viewport.
//    map.addListener('bounds_changed', function () {
//        searchBox.setBounds(map.getBounds());
//    });



    // Listen for the event fired when the user selects a prediction and retrieve
    // more details for that place.
//    searchBox.addListener('places_changed', function () {
//        var places = searchBox.getPlaces();
//
//        if (places.length === 0) {
//            return;
//        }
//
//        // Clear out the old markers.
//        markers.forEach(function (marker) {
//            marker.setMap(null);
//        });
//        markers = [];
//
//        // For each place, get the icon, name and location.
//        var bounds = new google.maps.LatLngBounds();
//        places.forEach(function (place) {
//            var icon = {
//                url: place.icon,
//                size: new google.maps.Size(71, 71),
//                origin: new google.maps.Point(0, 0),
//                anchor: new google.maps.Point(17, 34),
//                scaledSize: new google.maps.Size(25, 25)
//            };
//
//            // Create a marker for each place.
//            markers.push(new google.maps.Marker({
//                map: map,
//                icon: icon,
//                title: place.name,
//                position: place.geometry.location
//            }));
//
//            if (place.geometry.viewport) {
//                // Only geocodes have viewport.
//                bounds.union(place.geometry.viewport);
//            } else {
//                bounds.extend(place.geometry.location);
//            }
//        });
//
//        map.fitBounds(bounds);
//
//
//    });
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
    infoWindow.setPosition(pos);
    infoWindow.setContent(browserHasGeolocation ?
            'Error: The Geolocation service failed.' :
            'Error: Your browser doesn\'t support geolocation.');
}

