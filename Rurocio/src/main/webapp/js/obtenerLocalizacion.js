var data = "";

window.onload = function localizar() {

    var input = document.getElementById('inputEventLocalization');
    var autocomplete = new google.maps.places.Autocomplete(input);

    google.maps.event.addListener(autocomplete, "place_changed", function () {
        var place = autocomplete.getPlace();
        console.log(place.formatted_address);
        console.log(place.url);
        console.log(place.geometry.location);
        data = place.geometry.location;

    });
}


function obtenerCoordenadas() {

    var inputEventName = document.getElementById("inputEventName").value;
    var inputEventType = document.getElementById("inputEventType").value;
    var inputEventDateStart = document.getElementById("inputEventDateStart").value;
    var inputEventDateEnd = document.getElementById("inputEventDateEnd").value;
    var inputEventLocalization = document.getElementById("inputEventLocalization").value;
    var inputEventMaxForum = document.getElementById("inputEventMaxForum").value;
    var inputEventDescription = document.getElementById("inputEventDescription").value;
    var inputEventImages = document.getElementById("inputEventImages").value;


    console.log("inputEventName :  " + inputEventName);
    console.log("inputEventType :  " + inputEventType);
    console.log("inputEventDateStart :  " + inputEventDateStart);
    console.log("inputEventDateEnd :  " + inputEventDateEnd);
    console.log("inputEventLocalization :  " + inputEventLocalization);
    console.log("inputEventMaxForum :  " + inputEventMaxForum);
    console.log("inputEventDescription :  " + inputEventDescription);

    if (inputEventName === "" || inputEventType === "" || inputEventDateStart === "" || inputEventDateEnd === "" ||
            inputEventLocalization === "" || inputEventMaxForum === "0" || inputEventMaxForum === "" || inputEventDescription === "" || inputEventImages === "") {
        alert("Alguno de los campos no se ha rellenado correctamente. Por favor, rellene todos los campos");
    }


    $("#createForm").submit(function (eventObj) {
        $("<input />").attr("type", "hidden")
                .attr("name", "boton")
                .attr("value", "crear")
                .appendTo("#createForm");
        return true;
    });


    $("#createForm").submit(function (eventObj) {
        $("<input />").attr("type", "hidden")
                .attr("name", "place")
                .attr("value", data.toString())
                .appendTo("#createForm");
        return true;
    });


}


function cancelar() {
    $("#createForm").submit(function () {
        $("<input />").attr("type", "hidden")
                .attr("name", "boton")
                .attr("value", "cancelar")
                .appendTo("#createForm");
        return;
    });

}