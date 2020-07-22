/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import datos.Anfitrion;
import datos.Cliente;
import datos.ClienteDB;
import datos.Evento;
import datos.EventoDB;
import datos.TipoDeEvento;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.String.valueOf;
import java.sql.SQLException;
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
 * Recupera la informacion del formulario de la creacion de nuevo evento y la
 * almacena en la BD
 * 
 * @author gonzale
 * @author jorbarr
 * @author juangar
 * @author lucgonz
 */
@WebServlet(name = "CreateNewEventServlet", urlPatterns = {"/CreateNewEventServlet"})
@MultipartConfig
public class CreateNewEventServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Anfitrion anfitrion = (Anfitrion) session.getAttribute("anfitrion");
        String loginAnfitrion = anfitrion.getLogin();
        
        String boton = request.getParameter("boton");

        if (!boton.equals("crear")) {
            String url = "/index.html";
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
            dispatcher.forward(request, response);
        } else {
            String nombre = request.getParameter("nombre");
            String tipoEv = request.getParameter("tipo");
            String fechaInicioTmp = request.getParameter("fechaInicio");
            String fechaFinTmp = request.getParameter("fechaFin");
            String tmp = request.getParameter("place");
            String aforoTmp = request.getParameter("aforo");
            String descripcion = request.getParameter("descripcion");
            String imagenString = request.getPart("imagen").getContentType();
            Part imagen = request.getPart("imagen");

            // si alguno de los campos no esta bien relleno se vuelve a la misma pagina
            if (nombre.equals("") || fechaInicioTmp.equals("") || fechaFinTmp.equals("") || 
                    tmp == null || aforoTmp.equals("0") || descripcion.equals("") || imagenString.equals("application/octet-stream") ) {

                String url = "/NuevoEvento.jsp";
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
                dispatcher.forward(request, response);

                //pop up para mostrar que no pueden estar estos campos sin rellenar
            } else {

                LocalDate fechaInicio = LocalDate.parse(request.getParameter("fechaInicio"));
                LocalDate fechaFin = LocalDate.parse(request.getParameter("fechaFin"));
                int aforo = Integer.parseInt(request.getParameter("aforo"));

                if (boton.equals("crear")) {
                    TipoDeEvento tipo;
                    if (request.getParameter("tipo").equals("Cualquier tipo")) {
                        tipo = null;
                    } else {
                        tipo = TipoDeEvento.valueOf(request.getParameter("tipo"));
                    }

                    String nuevo = tmp.subSequence(1, tmp.length() - 1).toString();
                    String arrayCoordenadas[] = nuevo.split(",");

                    String latitud = arrayCoordenadas[0];
                    String longitud = arrayCoordenadas[1];
                    double posX = Double.valueOf(latitud);
                    double posY = Double.valueOf(longitud);

                    Evento event = new Evento(nombre, loginAnfitrion, fechaInicio, fechaFin, tipo, descripcion, posX, posY, imagen, aforo);

                    //me queda insertar en la BD
                    int res = EventoDB.insert(event);
                    String url;
                    if (res == 1) {
                        url = "/index.html";
                    } else {
                        url = "/MisEventos-Cliente.html";
                    }
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
