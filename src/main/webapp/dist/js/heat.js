/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



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
