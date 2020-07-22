<%-- 
    Document   : Busqueda
    Created on : 21-abr-2020, 10:56:02
    Author     : gonzale, jorbarr, juangar, lucgonz
--%>

<%@page import="datos.Evento"%>
<%@page import="datos.TipoDeEvento"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- saved from url=(0026)http://localhost:8080/#app -->
<html lang="en">
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
                height: 300px;  /* The height is 400 pixels */
                width: 100%;  /* The width is the width of the web page */
            }
        </style>
        
    </head>
    <body>
        <%@include file="/header.jsp" %>
        <%            cliente = (Cliente) session.getAttribute("cliente");
            anfitrion = (Anfitrion) session.getAttribute("anfitrion");

            Evento miEvento = (Evento) session.getAttribute("evento_detalles");
            String id = miEvento.getId();
            String nombre = miEvento.getNombre();
            String loginAnfitrion = miEvento.getLoginAnfitrion();
            LocalDate fechaInicio = miEvento.getFechaInicio();
            LocalDate fechaFin = miEvento.getFechaInicio();
            String tipo = miEvento.getTipo();
            String descripcion = miEvento.getDescripcion();
            double latitud = miEvento.getLatitud();
            double longitud = miEvento.getLongitud();
            String imagen = "";
            int aforo = miEvento.getAforo();
        %>
        <div id="event-description" class="unique-section">
            <div class="event">
                <div class="row">
                    <div class="img-col">
                        <img src="ImagenServlet?id=<%=miEvento.getId()%>" alt="Event" width = "100%" height="100%"/>
                    </div>
                    <div class="main-information-col">
                        <div class="content">
                            <h1><%=nombre%></h1>
                            <h2>Tipo: <%=tipo%></h2>
                            <%if (fechaInicio.equals(fechaFin)) {%>

                            <h2>Fecha: <%=fechaInicio%></h2>

                            <%} else {%>

                            <h2>Fecha: <%=fechaInicio%> a <%=fechaFin%></h2>

                            <%}%>

                            <div class="address-map">
                                <div id="map" ></div>
                                <script>
// Initialize and add the map
                                    function initMap() {
                                        // The location of Uluru
                                        var evento = {lat: <%=miEvento.getLatitud().toString()%>, lng: <%=miEvento.getLongitud().toString()%>};
                                        // The map, centered at Uluru
                                        var map = new google.maps.Map(
                                                document.getElementById('map'), {zoom: 15, center: evento});
                                        // The marker, positioned at Uluru
                                        var marker = new google.maps.Marker({position: evento, map: map});
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
                    </div>
                </div>
                <div class="event-details">
                    <div class="details-description">
                        <p>
                            <%=descripcion%>
                        </p>
                        <h5>Plazas disponibles: <%=aforo%></h5>
                    </div>
                </div>
                <div class="my-btn-group">
                    <%
                        if (anfitrion == null) {
                            if (cliente == null) {
                    %>
                    <form action="Login.jsp" method="post">
                        <button class="red-button my-button" type="submit">
                            Volver</button
                        ><button class="blue-button my-button" type="submit">
                            Reservar
                        </button>
                    </form>
                    <%
                    } else {
                    %>
                    <form action="BookEventServlet?id=<%=id%>" method="post">
                        <button class="red-button my-button" type="submit">
                            Volver</button
                        ><button class="blue-button my-button" type="submit">
                            Reservar
                        </button>
                    </form>
                       
                        <%
                            }
                        } else if (anfitrion.getLogin().equals(loginAnfitrion) && LocalDate.now().isBefore(fechaInicio)) {
                        %>
                    <form action="JoinedListServlet?idEvento=<%=id%>" method="post" style="display: inline;">
                        <button class="white-button" on-click="">
                            Lista de inscritos
                        </button>
                    </form>
                    <form action="GetEventServlet?id=<%=id%>" method="post" style="display: inline;">
                        <button class="blue-button two-buttons">
                            Editar evento
                        </button>
                    </form>
                    <form action="RemoveEventServlet?id=<%=id%>" method="post" style="display: inline;">
                        <button class="red-button two-buttons">
                            Cancelar evento
                        </button>
                    </form>
                        <%
                            }
                        %>

                </div>
            </div>
        </div>
    </body>
</html>
