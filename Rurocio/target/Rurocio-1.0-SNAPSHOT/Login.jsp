<%-- 
    Document   : Login
    Created on : 21-abr-2020, 0:52:16
    Author     : gonzale, jorbarr, juangar, lucgonz
--%>

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
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div id="login" class="unique-section">
            <div class="section-title"><h1>Inicio de sesión</h1></div>
            <form id="data" action="UserLoginServlet" method="post">
                <p>
                    <input
                        id="name"
                        type="text"
                        name="name"
                        placeholder="Nombre de usuario"
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
                <button
                    class="login-button"
                    style="vertical-align: middle;"
                    >
                    <span>Entrar </span>
                </button>
            </form>
            <div class="login-questions">
                <a href="http://localhost:8080/#"
                   >¿Has olvidado tu contraseña?</a
                ><a href="SeleccionRegistro.jsp"
                    >¿Aún no tienes cuenta? Registrate aquí</a
                >
            </div>
        </div>
    </body>
</html>
