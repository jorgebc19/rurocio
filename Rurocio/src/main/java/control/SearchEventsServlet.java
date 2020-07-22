/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import datos.Cliente;
import datos.ClienteDB;
import datos.Evento;
import datos.EventoDB;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.TipoDeEvento;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

/**
 * Servlet de buscar evento
 * 
 * @author gonzale
 * @author jorbarr
 * @author juangar
 * @author lucgonz
 */
@WebServlet(name = "SearchEventsServlet", urlPatterns = {"/SearchEventsServlet"})
public class SearchEventsServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {       
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventName = request.getParameter("eventName");
        String eventType = request.getParameter("eventType");
        String eventRadius = request.getParameter("eventRadius");
        String eventDateStart = request.getParameter("eventDateStart");
        String eventDateEnd = request.getParameter("eventDateEnd");
        
        //Coordenadas de valladolid
        double latitud = 41.651937;
        double longitud = -4.728581;
        
        ArrayList<Evento[]> resultLists = new ArrayList<>();
        
        if(!eventName.equals("")){
            resultLists.add(EventoDB.selectEventoOnlyByName (latitud, longitud, eventName));
        } 
        if(!eventType.equals("Cualquier tipo")){
            resultLists.add(EventoDB.selectEventoOnlyByType (latitud, longitud, TipoDeEvento.valueOf(eventType)));
        }
        if(!eventRadius.equals("")){
            resultLists.add(EventoDB.selectEventoOnlyByDistance (latitud, longitud, Integer.parseInt(eventRadius)));
        }
        if(!eventDateStart.equals("")){
            resultLists.add(EventoDB.selectEventoOnlyByDateStart (latitud, longitud, LocalDate.parse(eventDateStart)));
        } else {
            resultLists.add(EventoDB.selectEventoOnlyByDateStart (latitud, longitud, LocalDate.now()));
        }
        if(!eventDateEnd.equals("")){
            resultLists.add(EventoDB.selectEventoOnlyByDateEnd(latitud, longitud, LocalDate.parse(eventDateEnd)));
        }
        
        if(resultLists.contains(null)){
            request.setAttribute("resultadoBusqueda", null);
            request.setAttribute("recomendacionBusqueda", EventoDB.selectEventoOnlyByDateStart (latitud, longitud, LocalDate.now()));
        }else if(resultLists.size() == 1){
            request.setAttribute("resultadoBusqueda", resultLists.get(0));
        }else{
            ArrayList<Evento> resultados = new ArrayList<>();
            Evento[] l = resultLists.get(0);
            ArrayList<Evento> comprobar = new ArrayList<>();
            ArrayList<Evento> posibles = new ArrayList<>();
            Collections.addAll(posibles, l);
            for(int i=1; i<resultLists.size(); i++){
                Collections.addAll(comprobar, resultLists.get(i));
                for(int j=0; j<posibles.size(); j++){
                    for(int k = 0; k < comprobar.size(); k++){
                        if(comprobar.get(k).getId().equals(posibles.get(j).getId())){
                            resultados.add(posibles.get(j));
                        }
                    }
                }
                comprobar = new ArrayList<>();
                if(i+1<resultLists.size()){
                    posibles = (ArrayList<Evento>) resultados.clone();
                    resultados = new ArrayList<>();
                }
            }

            if(resultados.size()>0){
                request.setAttribute("resultadoBusqueda", resultados.toArray(new Evento[0]));
            } else {
                request.setAttribute("resultadoBusqueda", null);
                Evento[] eventosActuales = EventoDB.selectEventoOnlyByDateStart (latitud, longitud, LocalDate.now());
                Evento[] recomendaciones  = Arrays.copyOfRange(eventosActuales, 0, 3);
                request.setAttribute("recomendacionBusqueda", recomendaciones);
            }
        }   
        
        String url = "/Busqueda.jsp";
        
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
        dispatcher.forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
