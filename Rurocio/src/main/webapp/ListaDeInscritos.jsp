<%-- 
    Document   : ListaDeInscritos
    Created on : 22-may-2020, 13:40:35
    Author     : gonzale, jorbarr, juangar, lucgonz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="datos.Cliente"%>
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
    <body>
        <%@include file="header.jsp" %> 
        <div id="login" class="unique-section">
            <div class="section-title"><h1>Lista de inscritos</h1></div>
            <%                
                Cliente[] listaDeInscritos = (Cliente[]) request.getAttribute("listaDeInscritos");
            %>
            <table class="table table-dark table-hover" style="max-width: 75%; margin: auto; font-size: 20px;">
                <thead>
                    <tr>
                        <th>Login</th>
                        <th>Nombre</th>
                        <th>NIF</th>
                        <th>Email</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (int i = 0; i < listaDeInscritos.length; i++) {
                    %>
                    <tr>
                        <td><%=listaDeInscritos[i].getLogin()%></td>
                        <td><%=listaDeInscritos[i].getNombre()%></td>
                        <td><%=listaDeInscritos[i].getNif()%></td>
                        <td><%=listaDeInscritos[i].getEmail()%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </body>
</html>
