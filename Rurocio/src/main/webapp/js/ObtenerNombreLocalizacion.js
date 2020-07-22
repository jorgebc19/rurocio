

function recuperarNombre(latitud, longitud, indice) {

    var locAPI = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + latitud + "," + longitud + "&key=AIzaSyCaK9SxD4STVKbJ6rBwlkRWt_Xk3H8CIpo";
    $.get({
        url: locAPI,
        success: function (data) {
            console.log(data.results[0].formatted_address);
            var objetivo = document.getElementsByName("nombreLoc");
            for (var i = 0; i < objetivo.length; i++) {
                if(indice === i){
                    console.log(i + "  " + objetivo[i].textContent);
                    objetivo[i].textContent = objetivo[i].textContent + ". " + data.results[0].formatted_address;
                }

            }
        }

    });
}