<%-- 
    Document   : home
    Created on : 22-abr-2020, 20:59:46
    Author     : gonzale, jorbarr, juangar, lucgonz
--%>

<%@page import="datos.Evento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width,initial-scale=1.0" />
        <link
            rel="stylesheet"
            href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
            integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
            crossorigin="anonymous"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
            />
        <link rel="icon" href="./img/icon/rsheeticon.png"/>
        <title>Rurocio</title>
        <link rel="stylesheet" type="text/css" href="./css/mystyle.css">
        <style>
            /* Set the size of the div element that contains the map */
            #map {
                height: 600px;  /* The height is 400 pixels */
                width: 100%;  /* The width is the width of the web page */
            }
        </style>
        <script src="./js/ObtenerNombreLocalizacion.js"></script>
        <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCaK9SxD4STVKbJ6rBwlkRWt_Xk3H8CIpo&libraries=geocode"></script>

    </head>
    <body>
        <%@include file="/header.jsp" %>
        <%
            Evento[] eventos = (Evento[]) request.getAttribute("eventosPopulares");
        %>
        <div id="search" class="first-section">
            <div class="section-title">
                <h1>Encuentra tu plan perfecto</h1>
            </div>
            <form action="SearchEventsServlet" method="get">
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label for="inputEventName">Nombre del evento</label
                        ><input
                            type="text"
                            name="eventName"
                            class="form-control"
                            value=""
                            />
                    </div>
                    <div class="form-group col-md-4">
                        <label for="inputEventType">Tipo de evento</label>
                        <select name="eventType" class="form-control">
                            <option selected="selected">Cualquier tipo</option
                            ><option>Gastronomico</option
                            ><option>Musical</option
                            ><option>Deportivo</option
                            ><option>Infantil</option
                            ><option>Cultural</option
                            ><option>Festivo</option></select
                        >
                    </div>
                    <div class="form-group col-md-4">
                        <label for="inputEventRadius"
                               >Distancia máx (Km)</label
                        ><input
                            type="number"
                            name="eventRadius"
                            min="1"
                            class="form-control"
                            />
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label for="inputEventDateStart"
                               >Fecha de inicio</label
                        ><input
                            type="date"
                            name="eventDateStart"
                            class="form-control"
                            />
                    </div>
                    <div class="form-group col-md-4">
                        <label for="inputEventDateEnd">Fecha de fin</label
                        ><input
                            type="date"
                            name="eventDateEnd"
                            class="form-control"
                            />
                    </div>
                    <div class="form-group col-md-2"></div>
                    <div class="form-group col-md-2">
                        <br /><button type="submit" class="btn btn-primary">
                            Buscar
                        </button>
                    </div>
                </div>
            </form>
            <!---->
        </div>
        <div id="nearby-events" class="section">
            <div class="section-title"><h1>Próximos eventos</h1></div>
            <div class="address-map" style="border-style: solid; border-width: medium; width: 70%; margin: auto;">
                <div id="map" ></div>
                <script>
                    // Initialize and add the map
                    function initMap() {
                        // The location of Uluru
                        var pos1 = {lat: <%=eventos[0].getLatitud().toString()%>, lng: <%=eventos[0].getLongitud().toString()%>};
                        var pos2 = {lat: <%=eventos[1].getLatitud().toString()%>, lng: <%=eventos[1].getLongitud().toString()%>};
                        var pos3 = {lat: <%=eventos[2].getLatitud().toString()%>, lng: <%=eventos[2].getLongitud().toString()%>};
                        var lat = (<%=eventos[0].getLatitud()%>+<%=eventos[1].getLatitud()%>+<%=eventos[2].getLatitud()%>)/3;
                        var long = (<%=eventos[0].getLongitud()%>+<%=eventos[1].getLongitud()%>+<%=eventos[2].getLongitud()%>)/3;
                        
                        //Baricentro de las posiciones
                        var posCenter = {lat: lat, lng: long};
                        
                        // The map, centered at posCenter
                        var map = new google.maps.Map(
                                document.getElementById('map'), {zoom: 10, center: posCenter});
                        // The marker, positioned at Uluru
                        var marker1 = new google.maps.Marker({position: pos1, map: map});
                        var marker2 = new google.maps.Marker({position: pos2, map: map});
                        var marker3 = new google.maps.Marker({position: pos3, map: map});                        
                    }
                </script>
                <!--Load the API from the specified URL
                * The async attribute allows the browser to render the page while the API loads
                * The key parameter will contain your own API key (which is not needed for this tutorial)
                * The callback parameter executes the initMap() function
                -->
                <script async defer
                        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCaK9SxD4STVKbJ6rBwlkRWt_Xk3H8CIpo&callback=initMap">
                </script>
            </div>
        </div>
        <div id="popular-events" class="section">
            <div class="section-title"><h1>Eventos del mapa</h1></div>
            <div id="results" class="event-display">

                <%
                    for (int i = 0; i < eventos.length; i++) {
                %>

                <div class="event-box">
                    <div id="event-box">
                        <div class="row">
                            <div class="column-img">
                                <img src="ImagenServlet?id=<%=eventos[i].getId()%>"  alt="Event"/>
                            </div>
                            <div class="column-content">
                                <a href="ConsultEventInformationServlet?Id=<%=eventos[i].getId()%>"
                                   ><h1 id="nombreLoc" name="nombreLoc"><%=eventos[i].getNombre()%></h1>
                                    <%
                                        String latitud = eventos[i].getLatitud().toString();
                                        String longitud = eventos[i].getLongitud().toString();
                                    %>
                                    <script>
                                        recuperarNombre(<%= latitud%>, <%= longitud%>, <%= i%>);
                                    </script>
                                
                                
                                
                                
                                </a>

                                <h2>Tipo: <%=eventos[i].getTipo()%></h2>

                                <%if (eventos[i].getFechaInicio().equals(eventos[i].getFechaFin())) {%>

                                <h2>Fecha: <%=eventos[i].getFechaInicio()%></h2>

                                <%} else {%>

                                <h2>Fecha: <%=eventos[i].getFechaInicio()%> a <%=eventos[i].getFechaFin()%></h2>

                                <%}%>

                                <div id="event-details">
                                    <p>
                                        <%=eventos[i].getDescripcion()%>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>