<%-- 
    Document   : Busqueda
    Created on : 21-abr-2020, 10:56:02
    Author     : gonzale, jorbarr, juangar, lucgonz
--%>
<%@page import="java.util.ArrayList"%>
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
        <%
            ArrayList<Boolean> filtros = new ArrayList<>();
            String eventName = request.getParameter("eventName");
            int numFiltros = 0;
            int numFiltrosTotal;

            if (eventName.equals("")) {
                eventName = "";
                filtros.add(false);
            } else {
                filtros.add(true);
                numFiltros++;
            }

            String eventType = request.getParameter("eventType");
            if (!eventType.equals("Cualquier tipo")) {
                filtros.add(true);
                numFiltros++;
            } else {
                filtros.add(false);
            }

            String eventRadius = request.getParameter("eventRadius");
            if (!eventRadius.equals("")) {
                filtros.add(true);
                numFiltros++;
            } else {
                filtros.add(false);
            }

            String eventDateStart = request.getParameter("eventDateStart");
            if (!eventDateStart.equals("")) {
                filtros.add(true);
                numFiltros++;
            } else {
                filtros.add(false);
            }

            String eventDateEnd = request.getParameter("eventDateEnd");
            if (!eventDateEnd.equals("")) {
                filtros.add(true);
                numFiltros++;
            } else {
                filtros.add(false);
            }

            numFiltrosTotal = numFiltros;

            Evento[] resultadoBusqueda = (Evento[]) request.getAttribute("resultadoBusqueda");
        %> 
        <%@include file="/header.jsp" %>
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
                            <% if (!eventName.equals("")) {%>
                            value=<%=eventName%>
                            <% }%>
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
                               >Distancia máx (km)</label
                        ><input
                            type="number"
                            name="eventRadius"
                            min="1"
                            class="form-control"
                            value=<%=eventRadius%>
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
                            value=<%=eventDateStart%>
                            />
                    </div>
                    <div class="form-group col-md-4">
                        <label for="inputEventDateEnd">Fecha de fin</label
                        ><input
                            type="date"
                            name="eventDateEnd"
                            class="form-control"
                            value=<%=eventDateEnd%>
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

        <%
            if (resultadoBusqueda == null) {
        %>
        <div class="about-section-title">
            <h1>
                </br>Lo sentimos, no hemos encontrado eventos a su busqueda:</br>
            </h1>
            <h2>
                <%if (filtros.get(0)) {%>Nombre: <%=eventName%> <%numFiltros--;
                    if (numFiltros != 0) {%>, <%}
                    }%>
                <%if (filtros.get(1) || numFiltrosTotal == 0) {%>Tipo: <%=eventType%> <%numFiltros--;
                    if (numFiltros != 0) {%>, <%}
                    }%>
                <%if (filtros.get(2)) {%>Distancia: <%=eventRadius%> km <%numFiltros--;
                    if (numFiltros != 0) {%>, <%}
                    }%>
                <%if (filtros.get(3)) {%>Inicio: <%=eventDateStart%> <%numFiltros--;
                    if (numFiltros != 0) {%>, <%}
                    }%>
                <%if (filtros.get(4)) {%>Fin: <%=eventDateEnd%> <%numFiltros--;
                    if (numFiltros != 0) {%>, <%}
                    }%>
            </h2>
            <h2></br></br>Quizas le interese...</h2>
        </div>
        <div id="results" class="event-display">
            <%
                Evento[] recomendacionBusqueda = (Evento[]) request.getAttribute("recomendacionBusqueda");
                for (int i = 0; i < recomendacionBusqueda.length; i++) {
            %>
            <div class="event-box">
                <div id="event-box">
                    <div class="row">
                        <div class="column-img">
                            <img src="ImagenServlet?id=<%=recomendacionBusqueda[i].getId()%>"  alt="Event"/>
                        </div>
                        <div class="column-content">
                            <a href="ConsultEventInformationServlet?Id=<%=recomendacionBusqueda[i].getId()%>">
                                <h1 id="nombreLoc" name="nombreLoc"> <%=recomendacionBusqueda[i].getNombre()%> 
                                </h1>
                                    <%
                                        String latitud = recomendacionBusqueda[i].getLatitud().toString();
                                        String longitud = recomendacionBusqueda[i].getLongitud().toString();
                                   
                                    %>
                                    <script>
                                        recuperarNombre(<%= latitud%>, <%= longitud%>, <%= i%>);
                                    </script>


                            </a>
                            <h2>Tipo: <%=recomendacionBusqueda[i].getTipo()%></h2>

                            <%if (recomendacionBusqueda[i].getFechaInicio().equals(recomendacionBusqueda[i].getFechaFin())) {%>

                            <h2>Fecha: <%=recomendacionBusqueda[i].getFechaInicio()%></h2>

                            <%} else {%>

                            <h2>Fecha: <%=recomendacionBusqueda[i].getFechaInicio()%> a <%=recomendacionBusqueda[i].getFechaFin()%></h2>

                            <%}%>

                            <div id="event-details">
                                <p>
                                    <%=recomendacionBusqueda[i].getDescripcion()%>
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

        <%
        } else {
        %>

        <div class="about-section-title">
            <h2></br><b>Resultados de:</b>
                <%if (filtros.get(0)) {%>Nombre: <%=eventName%> <%numFiltros--;
                    if (numFiltros > 0) {%>, <%}
                    }%>
                <%if (filtros.get(1) || numFiltrosTotal == 0) {%>Tipo: <%=eventType%> <%numFiltros--;
                    if (numFiltros > 0) {%>, <%}
                    }%>
                <%if (filtros.get(2)) {%>Distancia: <%=eventRadius%> km <%numFiltros--;
                    if (numFiltros > 0) {%>, <%}
                    }%>
                <%if (filtros.get(3)) {%>Inicio: <%=eventDateStart%> <%numFiltros--;
                    if (numFiltros > 0) {%>, <%}
                    }%>
                <%if (filtros.get(4)) {%>Fin: <%=eventDateEnd%> <%numFiltros--;
                    if (numFiltros > 0) {%>, <%}
                    }%>
            </h2>
        </div>

        <div id="results" class="event-display">

            <%
                for (int i = 0; i < resultadoBusqueda.length; i++) {
            %>

            <div class="event-box">
                <div id="event-box">
                    <div class="row">
                        <div class="column-img">
                            <img src="ImagenServlet?id=<%=resultadoBusqueda[i].getId()%>"  alt="Event"/>
                        </div>
                        <div class="column-content">
                            <a href="ConsultEventInformationServlet?Id=<%=resultadoBusqueda[i].getId()%>"
                               ><h1 id="nombreLoc" name="nombreLoc"><%=resultadoBusqueda[i].getNombre()%> 

                                </h1>
                                    <%
                                        String latitud = resultadoBusqueda[i].getLatitud().toString();
                                        String longitud = resultadoBusqueda[i].getLongitud().toString();
                                    %>
                                    <script>
                                        recuperarNombre(<%= latitud%>, <%= longitud%>, <%= i%>);
                                    </script>
                            </a>
                               
                            <h2>Tipo: <%=resultadoBusqueda[i].getTipo()%></h2>

                            <%if (resultadoBusqueda[i].getFechaInicio().equals(resultadoBusqueda[i].getFechaFin())) {%>

                            <h2>Fecha: <%=resultadoBusqueda[i].getFechaInicio()%></h2>

                            <%} else {%>

                            <h2>Fecha: <%=resultadoBusqueda[i].getFechaInicio()%> a <%=resultadoBusqueda[i].getFechaFin()%></h2>

                            <%}%>

                            <div id="event-details">
                                <p>
                                    <%=resultadoBusqueda[i].getDescripcion()%>
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
        <%
            }
        %>
    </body>
</html>
