<%-- 
    Document   : EditarEvento
    Created on : 22 may. 2020, 18:26:40
    Author     : gonzale, jorbarr, juangar, lucgonz
--%>

<%@page import="datos.Evento"%>
<%@page import="datos.TipoDeEvento"%>
<%@page import="java.time.LocalDate"%>
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

        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCaK9SxD4STVKbJ6rBwlkRWt_Xk3H8CIpo&libraries=places"></script>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        
        <script src="./js/obtenerLocalizacion.js"></script>
    </head>
    <body>
        <%@include file="/header.jsp" %>
        <%  anfitrion = (Anfitrion) session.getAttribute("anfitrion");
        
            Evento modificacion = (Evento) session.getAttribute("modificacion_detalles");
            String nombre = modificacion.getNombre();
            String loginAnfitrion = modificacion.getLoginAnfitrion();
            LocalDate fechaInicio = modificacion.getFechaInicio();
            LocalDate fechaFin = modificacion.getFechaInicio();
            String tipo = modificacion.getTipo();
            String descripcion = modificacion.getDescripcion();
            String latitud = modificacion.getLatitud().toString();
            String longitud = modificacion.getLongitud().toString();
            int aforo = modificacion.getAforo();
            String direccion = null;
        %>
        
        <div id="event-creator" class="unique-section">
            <div class="section-title">
                <h1>Modifica tu evento</h1>
            </div>
            <form id="createForm" action="EditEventInformationServlet?id=<%=modificacion.getId()%>" method="post" enctype="multipart/form-data">
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="inputEventName">Nombre del evento</label
                        ><input
                            type="text"
                            id="inputEventName"
                            value="<%=nombre%>"
                            class="form-control"
                            name="nombre"
                            />
                    </div>
                    <div class="form-group col-md-6">
                        <label for="inputEventLocalization"
                               >Localización</label
                        ><input
                            type="text"
                            id="inputEventLocalization"
                            class="form-control"
                            name="localizacion"
                            />
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label for="inputEventDateStart"
                               >Fecha de inicio</label
                        ><input
                            type="date"
                            id="inputEventDateStart"
                            value="<%=fechaInicio%>"
                            class="form-control"
                            name="fechaInicio"
                            />
                    </div>
                    <div class="form-group col-md-4">
                        <label for="inputEventDateEnd">Fecha de fin</label
                        ><input
                            type="date"
                            id="inputEventDateEnd"
                            value="<%=fechaFin%>"
                            class="form-control"
                            name="fechaFin"
                            />
                    </div>
                    <div class="form-group col-md-4">
                        <label for="inputEventType">Tipo de evento</label
                        ><select name="tipo" id="inputEventType" class="form-control">
                            <% if (tipo=="Gastronomico") {%>
                                <option selected="selected">Gastronomico</option>
                            <%} else {%>
                                <option>Gastronomico
                            <%} %>
                            <% if (tipo=="Musical") {%>
                                <option selected="selected">Musical</option>
                            <%} else {%>
                                <option>Musical</option>
                            <%} %>
                            <% if (tipo=="Deportivo") {%>
                                <option selected="selected">Deportivo</option>
                            <%} else {%>
                                <option>Deportivo</option>
                            <%} %>
                            <% if (tipo=="Infantil") {%>
                                <option selected="selected">Infantil</option>
                            <%} else {%>
                                <option>Infantil</option>
                            <%} %>
                            <% if (tipo=="Cultural") {%>
                                <option selected="selected">Cultural</option>
                            <%} else {%>
                                <option>Cultural</option>
                            <%} %>
                            <% if (tipo=="Festivo") {%>
                                <option selected="selected">Festivo</option>
                            <%} else {%>
                                <option>Festivo</option>
                            <%} %>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label for="inputEventMaxForum">Aforo máximo</label
                        ><input
                            type="number"
                            id="inputEventMaxForum"
                            value="<%=aforo%>"
                            class="form-control"
                            name="aforo"
                            />
                    </div>
                    <div class="form-group col-md-8">
                        <label for="inputEventImages">Imágenes</label
                        ><input
                            type="file"
                            placeholder="Seleccionar imagen..."
                            id="inputEventImages"
                            lang="es"
                            class="custom-file-input"
                            name="imagen"
                            />
                    </div>

                </div>
                <div class="form-group">
                    <label for="inputEventDescription"
                           >Descripión del evento</label
                    ><textarea
                        name="descripcion"
                        id="inputEventDescription"
                        rows="3"
                        class="form-control"
                        ><%=descripcion%></textarea>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-4">
                        <button type="submit" class="btn btn-primary" name="boton" onclick = "cancelar()" value="cancel">
                            Cancelar
                        </button>
                    </div>
                    <div class="form-group col-md-4"></div>
                    <div class="form-group col-md-4">
                        <button type="submit" class="btn btn-primary" name="boton" onclick = "obtenerCoordenadas()" value="modify">
                            Modificar
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
