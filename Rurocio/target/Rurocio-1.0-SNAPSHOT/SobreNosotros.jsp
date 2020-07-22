<%-- 
    Document   : SobreNosotros
    Created on : 29-abr-2020, 1:41:11
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
        <%@include file="/header.jsp" %>
        <div id="about-us" class="unique-section">
            <div class="section-title"><h1>Sobre nosotros</h1></div>
            <div class="about-section-subtitle">
                <h2>
                    En esta sección dispone de información propia del sitio,
                    su principal objetivo y de los desarrolladores del
                    mismo.
                </h2>
            </div>
            <div id="basicInformation" class="about-section">
                <div class="about-section-title">
                    <h1>Información Básica</h1>
                </div>
                <div class="about-section-body">
                    <p>
                        Rurocio es una plataforma destinada a la busqueda de
                        actividades lúdicas dentro del ambito rural, siendo
                        estas de diversos tipos como actividades
                        gstrónomicas, culturales, festivas, musicales y de
                        diversa índole.
                    </p>
                    <p>
                        En Rurocio se da la posibilidad de buscar los
                        eventos en función del pueblo donde se realizaria el
                        evento, el tipo de actividad que se realiza o la
                        fecha en la que se produciria el evento, dependiendo
                        de si este tiene un aforo limitado o no tambien
                        permitira apuntarse a través de la web para reservar
                        una plaza para el mismo, pero para esto un usuario
                        deberá haberse creado con antelación una cuenta de
                        cliente.
                    </p>
                    <p>
                        También se dara la posibilidad a los usuarios que se
                        hayan registrado como usuario anfitrión, habiendo
                        validado con atelación la misma como institución o
                        empresa privada, podrá incluir nuevos eventos
                        referentes al pueblo o empresa que representa.
                    </p>
                </div>
            </div>
            <div id="purpose" class="about-section">
                <div class="about-section-title"><h1>Propósito</h1></div>
                <div class="about-section-body">
                    <p>
                        Hemos desarrollado Rurocio con el principal objetivo
                        de publicitar eventos en los pueblos, lo que
                        ayudaría a solventar el problema de la España
                        vaciada aportando dinero a los locales de los
                        municipios y publicitando las distintas actividades,
                        de esta forma el turismo aumentaría y quizas algunas
                        de las persona que realizasen estas actividades
                        decidirian mudarse a los pueblos lo que resolvería
                        el problema de despobación de muchos de ellos.
                    </p>
                </div>
            </div>
            <div id="administrators" class="about-section">
                <div class="about-section-title">
                    <h1>Equipo de desarrollo de Rurocio</h1>
                </div>
                <div class="about-section-body">
                    <p>
                        El equipo de desarrollo y administración de Rurocio
                        esta conformado por un grupo de 4 alumnos de
                        Ingeniería Informática de la Universidad de
                        Valladolid, los 4 miembros ordenados alfabéticamente
                        según sus apellidos son Barrio Conde Jorge, García
                        Diéguez Juan, González Calderón Lucas Matías y
                        González Cosgaya David.
                    </p>
                </div>
            </div>
        </div>
    </body>
</html>
