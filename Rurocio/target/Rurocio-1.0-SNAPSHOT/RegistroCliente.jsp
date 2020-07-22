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
        <script src="./js/ComprobarCamposCliente.js"></script>
    </head>

    <body>
        <div id="app">
            <%@include file="/header.jsp" %>
            <%            
            session = request.getSession();
            boolean loginRepetido =  (boolean) session.getAttribute("loginRepetido");
            
            
            %>
            <!----><!----><!----><!----><!----><!----><!---->
            <div id="registry" class="unique-section">
                <div class="section-title">
                    <h1>Registro de nuevo Cliente</h1>
                    <%     
                         if(loginRepetido){
                    %>
                     <p style="color:red"  >El login ya exite. Pruebe otro </p>
                    <%     
                        }
                    %>
                </div>
                <form action="CreateNewClientServlet"  method="post">
                    <p>
                        <input
                            
                            type="text"
                            name="login"
                            placeholder="Nombre de usuario"
                            />
                    </p>
                    <p>
                        <input
                            id="name"
                            type="text"
                            name="name"
                            placeholder="Nombre"
                            />
                    </p>
                    <p>
                        <input
                            id="email"
                            name="email"
                            placeholder="Correo electrónico"
                            />
                    </p>
                    <p><input id="nif" name="nif" placeholder="nif" /></p>
                    <p>
                        <input
                            type="date"
                            id="date"
                            name="date"
                            placeholder="fecha"
                            />
                    </p>
                    <p>
                        <input
                            type="password"
                            id="pwd"
                            name="pwd"
                            placeholder="Contraseña"
                            />
                    </p>
                    <p>
                        <input
                            type="password"
                            id="pwd2"
                            name="pwd2"
                            placeholder=" Repita la contraseña"
                            />
                    </p>

                    <button
                        id="register-Button"
                        type="submit"
                        class="login-button"
                        style="vertical-align: middle;"
                        onclick = "comprobarCamposNoVacios()"
                        >
                        <span>Registrarse</span>
                    </button>
                </form>
            </div>
            <!----><!----><!---->
        </div>
        <!-- built files will be auto injected -->
        <script
            type="text/javascript"
            src="./Registr_files/chunk-vendors.js"
        ></script>
        <script type="text/javascript" src="./Registr_files/app.js"></script>
    </body>
</html>
