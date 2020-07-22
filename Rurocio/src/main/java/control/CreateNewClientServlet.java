/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import datos.Cliente;
import datos.ClienteDB;
import datos.UsuarioDB;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Recupera la informacion de un nuevo usuario cliente y lo almacena
 * 
 * @author gonzale
 * @author jorbarr
 * @author juangar
 * @author lucgonz
 */
@WebServlet(name = "CreateNewClientServlet", urlPatterns = {"/CreateNewClientServlet"})
public class CreateNewClientServlet extends HttpServlet {

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

        String login = request.getParameter("login");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String date = request.getParameter("date");
        String nif = request.getParameter("nif");
        String password = request.getParameter("pwd");
        String password2 = request.getParameter("pwd2");

        System.out.println("Hola estos son mis campos :" + login + " " + name + " " + email + " " + date + " " + nif + " " + password + " " + password2);
        // si alguno de los campos no esta bien relleno se vuelve a la misma pagina
        if (login.equals("") || name.equals("") || email.equals("") || date.equals("")
                || nif.equals("") || password.equals("") || password2.equals("")) {
            System.out.println("Campos vacios");

            String url = "/RegistroCliente.jsp";
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
            dispatcher.forward(request, response);
        } else {
            if (!password.equals(password2)) {
                System.out.println("contraseñas diferentes");

                String url = "/RegistroCliente.jsp";
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
                dispatcher.forward(request, response);
            } else {
                if (UsuarioDB.loginExists(login)) {
                    //el login ya existe
                    //
                    HttpSession session = request.getSession();
                    session.setAttribute("loginRepetido",true);
                    String url = "/RegistroCliente.jsp";
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
                    dispatcher.forward(request, response);

                } else {
                    Cliente cNuevo = new Cliente(login, name, nif, email, LocalDate.parse(date));
                    ClienteDB.insert(cNuevo, password);
                    HttpSession session = request.getSession();
                    session.setAttribute("cliente",cNuevo);
                    String url = "/SearchPopularEventsServlet";
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
