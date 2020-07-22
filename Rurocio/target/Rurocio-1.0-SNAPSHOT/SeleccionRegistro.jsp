<%-- 
    Document   : SobreNosotros
    Created on : 29-abr-2020, 1:41:11
    Author     : gonzale, jorbarr, juangar, lucgonz
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

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
        <link rel="icon" href="../img/icon/rsheeticon.png"/>
        <title>Rurocio</title>
        <link rel="stylesheet" type="text/css" href="./css/mystyle.css">
    </head>

    <body>
        <%@include file="header.jsp" %>

        <div id="selection-registry-type" class="unique-section">
            <div class="section-title">
                <h1>Registro de nuevo usuario</h1>
            </div>
            <div class="selection-body">
                <h2>Seleccione el tipo de cuenta que desea registrar:</h2>
                <div class="description">
                    <p>
                        Un usuario de tipo cliente es aquel que va a visitar
                        los eventos, sin embargo, un usuario anfitrión es el
                        encargado de crear eventos.
                    </p>
                </div>
                <button
                    id="clientType-button"
                    type="submit"
                    formmethod="post"
                    class="login-button"
                    onclick="location.href = './ClientRegistryServlet'"
                    
                    >
                    <!--<onclick="location.href = './RegistroCliente.jsp'">-->
                    <span>Cliente </span></button
                ><button
                    id="hostType-button"
                    type="submit"
                    formmethod="post"
                    class="login-button"
                    onclick="location.href = './HostRegistryServlet'"
                    >
                    
                    <span>Anfitrion </span>
                </button>
            </div>
        </div>
        <!----><!----><!----><!---->
        <!-- built files will be auto injected -->
        <script
            type="text/javascript"
            src="./SeleccionRegistro_files/chunk-vendors.js"
        ></script>
        <script
            type="text/javascript"
            src="./SeleccionRegistro_files/app.js"
        ></script>
    </body>
</html>
