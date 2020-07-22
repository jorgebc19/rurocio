<%-- 
    Document   : header
    Created on : 23-abr-2020, 1:31:54
    Author     : gonzale, jorbarr, juangar, lucgonz
--%>

<%@page import="datos.Anfitrion"%>
<%@page import="datos.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
    </head>

    <body>
        <%
            session = request.getSession();
            Cliente cliente = (Cliente) session.getAttribute("cliente");
            Anfitrion anfitrion = (Anfitrion) session.getAttribute("anfitrion");
        %>
        <div id="app">
            <div id="header">
                <header id="myTopnav" class="topnav">
                    <div class="inner">
                        <div class="logo">
                            <h1>
                                <a href="SearchPopularEventsServlet">
                                    Rur<span>ocio</span></a
                                >
                            </h1>
                        </div>
                        <div id="myNavbar" class="navbar">
                            <ul>
                                <%
                                    if(anfitrion != null){
                                %>
                                <li>
                                    <a
                                        href="NuevoEvento.jsp"
                                        class="navbar-element"
                                        >Nuevo evento</a
                                    >
                                </li>
                                <%
                                    }
                                    if(anfitrion != null || cliente != null){
                                %>
                                <li>
                                    <a
                                        href="MyEventsServlet"
                                        class="navbar-element"
                                        >Mis eventos</a
                                    >
                                </li>
                                <%
                                    }
                                %>
                                <li>
                                    <a
                                        href="SobreNosotros.jsp"
                                        class="navbar-element"
                                        >Sobre nosotros</a
                                    >
                                </li>
                                <li>
                                    <%
                                        if(cliente == null && anfitrion == null){
                                    %>
                                    <a
                                        href="Login.jsp"
                                        class="navbar-element"
                                        >
                                        Iniciar sesion
                                        
                                        
                                    </a>
                                    <%
                                        }else {
                                            //if(cliente!=null)
                                                //login = cliente.getLogin();
                                            //else
                                                //login = anfitrion.getLogin();
                                    %>
                                    <a href="MiPerfil.jsp"
                                    class="navbar-element"
                                    >
                                    Mi perfil
                                    </a>
                                    <%
                                        }
                                    %>
                                </li>
                                <li>
                                    <a c-on:click="myResponsive()" class="icon"
                                       ><i class="fa fa-bars"></i
                                        ></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </header>
            </div>
            <!----><!----><!----><!----><!----><!----><!---->
        </div>
    </body>
</html>

