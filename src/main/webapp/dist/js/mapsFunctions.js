/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var map, heatmap, localLayer;

var markers = [];

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

    var iconBase = 'https://maps.google.com/mapfiles/kml/shapes/';

//                        map.data.loadGeoJson("DenunciaGetAll");
////                        alert("aqui");
//                        map.data.setStyle(function () {
//                            return {icon: iconBase + 'schools_maps.png'};
//                        });

    iconMarker = {
        ASSEDIO: {
            icon: 'icons/letter_a.png'
        },
        VIOLENCIA: {
            icon: 'icons/letter_v.png'
        },
        ESTUPRO: {
            icon: 'icons/letter_e.png'
        }
    };

    localLayer = new google.maps.Data();
    localLayer.loadGeoJson('DenunciaGetAll');

    localLayer.setStyle(function (feature) {
//                            icon: 'icons/letter_a.png'
        return {icon: iconMarker[feature.getProperty('tipo')].icon};
    });

    localLayer.setMap(map);

    $('#check_assedio').change(function () {
        if ($(this).prop('checked') === false) {
            localLayer.forEach(function (feature) {
                if (feature.getProperty('tipo') === 'ASSEDIO') {
                    localLayer.overrideStyle(feature, {'visible': false});
                }
            });
        } else {
            localLayer.forEach(function (feature) {
                if (feature.getProperty('tipo') === 'ASSEDIO') {
                    localLayer.overrideStyle(feature, {'visible': true});
                }
            });
        }
    });

    $('#check_estupro').change(function () {
        if ($(this).prop('checked') === false) {
            localLayer.forEach(function (feature) {
                if (feature.getProperty('tipo') === 'ESTUPRO') {
                    localLayer.overrideStyle(feature, {'visible': false});
                }
            });
        } else {
            localLayer.forEach(function (feature) {
                if (feature.getProperty('tipo') === 'ESTUPRO') {
                    localLayer.overrideStyle(feature, {'visible': true});
                }
            });
        }
    });

    $('#check_violencia').change(function () {
        if ($(this).prop('checked') === false) {
            localLayer.forEach(function (feature) {
                if (feature.getProperty('tipo') === 'VIOLENCIA') {
                    localLayer.overrideStyle(feature, {'visible': false});
                }
            });
        } else {
            localLayer.forEach(function (feature) {
                if (feature.getProperty('tipo') === 'VIOLENCIA') {
                    localLayer.overrideStyle(feature, {'visible': true});
                }
            });
        }
    });

//    heatmap = new google.maps.visualization.HeatmapLayer({
//        data: localLayer,
//        map: map
//    });





//                        jQuery.ajax({
//                            url: 'DenunciaGetAll',
//                            dataType: 'json',
//                            success: function (response) {
//
//                                places = response.features;
//                                // loop through places and add markers
//                                for (p in places) {
//                                    //create gmap latlng obj
//                                    tmpLatLng = new google.maps.LatLng(places[p].geometry.coordinates[0], places[p].geometry.coordinates[1]);
//                                    // make and place map maker.
////                                    alert(iconMarker[places[p].properties.tipo].icon);
//                                    var marker = new google.maps.Marker({
//                                        map: map,
//                                        position: tmpLatLng,
//                                        title: places[p].name + "<br>" + places[p].geo_name,
//                                        
//                                        icon : iconMarker[places[p].properties.tipo].icon
//                                    });
////                                    bindInfoWindow(marker, map, infowindow, '<b>' + places[p].name + "</b><br>" + places[p].geo_name);
//                                    // not currently used but good to keep track of markers
//                                    markers.push(marker);
//                                }
//
//                            }
//                        });



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

function toggleHeatmap() {
    heatmap.setMap(heatmap.getMap() ? null : map);
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
    addListener.remove();
}

// Adds a marker to the map and push to the array.
function addMarker(location) {
    var marker = new google.maps.Marker({
        position: location,
        map: map
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
        $('#local').val(marker.position.lat());

        var removeBtn = document.getElementById('removerMarcadorButton');
        if (removeBtn !== null) {
            google.maps.event.addDomListener(removeBtn, "click", function (event) {
                marker.setMap(null);
            });
        }

    });

    markers.push(marker);


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

function closeThisMarker() {
    infoWindow.marker.setMap(null);
}

function heat() {
    $('#check_todos').trigger('click');

    if ($('#check_todos').prop('checked') === true) {
        if (heatmap !== undefined) {
            heatmap.setMap(null);
        }
    } else {
        var places;
        var heatmapData = [];

        jQuery.ajax({
            url: 'DenunciaGetAll',
            dataType: 'json',
            success: function (response) {

                places = response.features;
                // loop through places and add markers
                for (p in places) {

                    tmpLatLng = new google.maps.LatLng(places[p].geometry.coordinates[1], places[p].geometry.coordinates[0]);

                    heatmapData.push(tmpLatLng);
                }

            }
        });

        if (heatmap !== undefined) {
            heatmap.setMap(map);
        } else {
            heatmap = new google.maps.visualization.HeatmapLayer({
                data: heatmapData,
                map: map
            });
        }




    }
}
