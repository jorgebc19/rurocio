/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import datos.Anfitrion;
import datos.Evento;
import datos.EventoDB;
import datos.TipoDeEvento;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 * Servlet de editar informacion de un evento
 * @author gonzale
 * @author jorbarr
 * @author juangar
 * @author lucgonz
 */
@WebServlet(name = "EditEventInformationServlet", urlPatterns = {"/EditEventInformationServlet"})
@MultipartConfig
public class EditEventInformationServlet extends HttpServlet {

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
        HttpSession session = request.getSession();
        Anfitrion anfitrion = (Anfitrion) session.getAttribute("anfitrion");
        
        String boton = request.getParameter("boton");
        
        if(!boton.equals("modify")){
            String url = "/MyEventsServlet";
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
            dispatcher.forward(request, response);
        }else{
            String id = request.getParameter("id");
            String nombre = request.getParameter("nombre");
            String tipoEv = request.getParameter("tipo");
            String fechaInicio = request.getParameter("fechaInicio");
            String fechaFin = request.getParameter("fechaFin");
            String localizacion = request.getParameter("place");
            String aforo = request.getParameter("aforo");
            String descripcion = request.getParameter("descripcion");
            String imagenString = request.getPart("imagen").getContentType();
            Part imagen = request.getPart("imagen");
            if (nombre.equals("") || fechaInicio.equals("") || fechaFin.equals("") || 
                    localizacion == null || aforo.equals("0")
                    ||descripcion.equals("") || imagenString.equals("application/octet-stream") ) {
                String url = "/EditarEvento.jsp";
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
                dispatcher.forward(request, response);
            } else {
                LocalDate inicio = LocalDate.parse(request.getParameter("fechaInicio"));
                LocalDate fin = LocalDate.parse(request.getParameter("fechaFin"));
                int nuevoAforo = Integer.parseInt(request.getParameter("aforo"));
                
                if(boton.equals("modify")){
                    TipoDeEvento type = null;
                    if(request.getParameter("tipo").equals("Cualquier tipo")){
                        type = null;
                    }else{
                        type = TipoDeEvento.valueOf(request.getParameter("tipo"));
                    }
                    String nuevo = localizacion.subSequence(1, localizacion.length() - 1).toString();
                    String arrayCoordenadas[] = nuevo.split(",");

                    String latitud = arrayCoordenadas[0];
                    String longitud = arrayCoordenadas[1];
                    double posX = Double.valueOf(latitud);
                    double posY = Double.valueOf(longitud);
            
                    Evento modificacion = new Evento(nombre,anfitrion.getLogin(),inicio,fin,type,descripcion,posX,posY,imagen,nuevoAforo);
            
                    //System.out.println("Los nuevos datos del evento con loginA: "+anfitrion.getLogin()+", son nombre: "+nombre+" y la descripcion es: "+descripcion);
                    
                    EventoDB.editEventByIdAndLoginAnfitrion(modificacion,id);
            
                    String url = "/MyEventsServlet";
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
                    dispatcher.forward(request, response);
                }
            }
        }
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
        processRequest(request, response);
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
