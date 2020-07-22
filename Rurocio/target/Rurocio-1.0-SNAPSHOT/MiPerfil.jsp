<%-- 
    Document   : Login
    Created on : 21-abr-2020, 0:52:16
    Author     : gonzale, jorbarr, juangar, lucgonz
--%>
<%@page import="datos.Anfitrion"%>
<%@page import="datos.Cliente"%>
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
        <script>
            function callServlet() {
                document.location.href = "UserLogoutServlet";
                return;
            }
        </script>
    </head>
    <body>
        <%@include file="header.jsp" %>                                        
        <div id="login" class="unique-section">
            <div class="section-title"><h1>Mi perfil</h1></div>
            <%                
                session = request.getSession();
                cliente = (Cliente) session.getAttribute("cliente");
                anfitrion = (Anfitrion) session.getAttribute("anfitrion");
                if (cliente != null) {
            %>
            <table class="table table-bordered table-dark" style="max-width: 75%; margin: auto; font-size: 20px;">

                <tbody>
                    <tr>
                        <th scope="row">Login</th>
                        <td><%=cliente.getLogin()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Nombre</th>
                        <td><%=cliente.getNombre()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Email</th>
                        <td><%=cliente.getEmail()%></td>
                    </tr>
                </tbody>
            </table>
            <%
            } else {
            %>
            <table class="table table-bordered table-dark" style="max-width: 75%; margin: auto; font-size: 20px;">

                <tbody>
                    <tr>
                        <th scope="row">Login</th>
                        <td><%=anfitrion.getLogin()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Nombre</th>
                        <td><%=anfitrion.getNombre()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Email</th>
                        <td><%=anfitrion.getEmail()%></td>
                    </tr>
                </tbody>
            </table>
            <%
                }
            %>
            <div class="btn-group" style="margin-right: 12.5%; margin-top: 50px;">
                <button id="cerrar-sesion-btn" class="red-button button-alone" onclick="callServlet()">
                    Cerrar sesion
                </button>
            </div>
        </div>
    </body>
</html>
