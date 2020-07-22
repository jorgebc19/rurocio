<%-- 
    Document   : MisEventos
    Created on : 25-abr-2020, 3:49:34
    Author     : gonzale, jorbarr, juangar, lucgonz
--%>

<%@page import="datos.EventoDB"%>
<%@page import="java.util.ArrayList"%>
<%@page import="datos.Reserva"%>
<%@page import="java.time.LocalDate"%>
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
        <script src="./js/ObtenerNombreLocalizacion.js"></script>
        <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCaK9SxD4STVKbJ6rBwlkRWt_Xk3H8CIpo&libraries=geocode"></script>

    </head>
    <body>
        <%@include file="/header.jsp" %>
        <%            
            session = request.getSession();
            cliente = (Cliente) session.getAttribute("cliente");
            anfitrion = (Anfitrion) session.getAttribute("anfitrion");
            Evento[] misEventos = new Evento[] {};
            Reserva[] misReservas = null;
        %>
        <div id="my-events" class="unique-section">
            <div class="section-title"><h1>Mis eventos</h1></div>
            <%
                if (cliente == null && anfitrion == null) {
            %>
            <h1>Inicia sesion para ver sus eventos</h1>
            <%
            } else {
                if (cliente != null) {
                    misReservas = (Reserva[]) request.getAttribute("misReservas");
                    ArrayList<Evento> reservasToEventos = new ArrayList<>();
                    for(int i=0; i<misReservas.length; i++){
                        reservasToEventos.add(EventoDB.selectEventoById(misReservas[i].getIdEvento()));
                    }
                    misEventos = reservasToEventos.toArray(new Evento[0]);
                } else {
                    misEventos = (Evento[]) request.getAttribute("misEventos");
                }
                if(misEventos.length > 0){
            %>
            <div class="event-display">
                <%
                    for (int i = 0; i < misEventos.length; i++) {
                %>
                <div class="event-box">
                    <div id="event-box">
                        <div class="row">
                            <div class="column-img">
                                

                            <img src="ImagenServlet?id=<%=misEventos[i].getId()%>"  alt="Event"/>



                            </div>
                            <div class="column-content">
                                <a href="ConsultEventInformationServlet?Id=<%=misEventos[i].getId()%>"
                                   ><h1 id="nombreLoc" name="nombreLoc"><%=misEventos[i].getNombre()%></h1>
                                
                                <%
                                        String latitud = misEventos[i].getLatitud().toString();
                                        String longitud = misEventos[i].getLongitud().toString();
                                   
                                    %>
                                    <script>
                                        recuperarNombre(<%= latitud%>, <%= longitud%>, <%= i%>);
                                    </script>
                                
                                
                                </a >

                                <h2>Tipo: <%=misEventos[i].getTipo()%></h2>

                                <%if (misEventos[i].getFechaInicio().equals(misEventos[i].getFechaFin())) {%>

                                <h2>Fecha: <%=misEventos[i].getFechaInicio()%></h2>

                                <%} else {%>

                                <h2>Fecha: <%=misEventos[i].getFechaInicio()%> a <%=misEventos[i].getFechaFin()%></h2>

                                <%
                                    }
                                %>

                                <div id="event-details">
                                    <p>
                                        <%=misEventos[i].getDescripcion()%>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="event-options">
                                <div class="btn-group">
                                    <%
                                        if(!misEventos[i].getFechaInicio().isBefore(LocalDate.now()) && cliente != null){
                                    %>
                                    <form action="CancelEventServlet?id=<%=misEventos[i].getId()%>" method="post">
                                        <button class="red-button button-alone">
                                            Cancelar reserva
                                        </button>
                                    </form>
                                    <%
                                        
                                        
                                        } else {

                                            Reserva checkReserva = null;

                                            if(misReservas!= null) {

                                                for (int j = 0; j < misReservas.length; j++) {

                                                    if (misReservas[j].getIdEvento().equals(misEventos[i].getId()) && misReservas[j].getValoracion() != 0.0) {

                                                        System.out.println("valoracion = " + misReservas[j].getValoracion());
                                                        checkReserva = misReservas[j];

                                                    }

                                                }

                                            }

                                            if(cliente != null && checkReserva!= null){
                                    %>
                                    
                                    <div class="assessment-container">
                                        <h3>Tu valoración</h3>
                                        <div
                                            id="assessment"
                                            class="container"
                                            >
                                            <div class="starrating risingstar d-flex justify-content-center flex-row-reverse">
                                                                                    
                                    <%
                                        for (int j = 0; j < (int) (5 - checkReserva.getValoracion()); j++) {
                                    %>    
                                    
                                                <img src="img/other/Estrella_amarillaborde.png" style="height: 50px; width: 50px">
                                                
                                    <%
                                        }

                                        for (int j = 0; j < (int) checkReserva.getValoracion(); j++) {

                                    %>
                                                                        
                                                <img src="img/other/Estrella_amarilla.png" style="height: 50px; width: 50px">
                                    
                                    <%
                                        }
                                    %>
                                            </div>
                                        </div>
                                    </div>
                                                   
                                    <%
                                        } else if(cliente != null){
                                    %>
                                            
                                    <div class="assessment-container">
                                        <h3>Valora el evento</h3>
                                        <div
                                            id="assessment"
                                            class="container"
                                            >
                                            <div class="starrating risingstar d-flex justify-content-center flex-row-reverse">
                                                <style> 
                                                    input {
                                                        background: none;
                                                        width: 50px; 
                                                        height: 50px; 
                                                        border: 0; 
                                                        cursor: pointer;
                                                        background-image: url('img/other/Estrella_amarillaborde.png'); 
                                                        background-size: cover; 
                                                    } 

                                                    input:hover { 
                                                        background-image: url('img/other/Estrella_amarilla.png'); 
                                                        background-size: cover; 
                                                    } 
                                                </style>
                                                <form id="ratingForm" action="RatingServlet?id=<%=misEventos[i].getId()%>&idCliente=<%=cliente.getLogin()%>" method="post">
                                                    <input type="submit" name="star" value="1">
                                                    <input type="submit" name="star" value="2">
                                                    <input type="submit" name="star" value="3">
                                                    <input type="submit" name="star" value="4">
                                                    <input type="submit" name="star" value="5">
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <%
                                        } else if(LocalDate.now().isBefore(misEventos[i].getFechaInicio())){
                                    %>
                                    <form action="GetEventServlet?id=<%=misEventos[i].getId()%>" method="post" style="display: inline;">
                                        <button class="blue-button two-buttons">
                                            Editar evento</button
                                        >
                                    </form>
                                    <form action="RemoveEventServlet?id=<%=misEventos[i].getId()%>" method="post" style="display: inline;">
                                        <button class="red-button two-buttons">
                                            Cancelar evento
                                        </button>
                                    </form>
                                    <%
                                        } else {
                                    %>
                                    <form action="RemoveEventServlet?id=<%=misEventos[i].getId()%>" method="post" style="display: inline;">
                                        <button class="red-button two-buttons">
                                            Eliminar evento</button
                                        >
                                    </form>
                                    <%
                                        }
                                    }
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
            <%
                } else {
            %>
            <div class="about-section-title" style="margin:auto">
            <h1>
                </br>Aun no tienes eventos en tu lista</br>
            </h1>
            <%
                }
            %>
            <%
                }
            %>
        </div>
    </body>
</html>
