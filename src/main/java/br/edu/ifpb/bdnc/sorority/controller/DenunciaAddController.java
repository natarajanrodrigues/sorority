/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.ifpb.bdnc.sorority.controller;

import br.edu.ifpb.bdnc.sorority.entidade.Denuncia;
import br.edu.ifpb.bdnc.sorority.entidade.TipoDenuncia;
import br.edu.ifpb.bdnc.sorority.entidade.TipoDenunciador;
import br.edu.ifpb.bdnc.sorority.entidade.Usuario;
import br.edu.ifpb.bdnc.sorority.model.DenunciaBo;
import br.edu.ifpb.bdnc.sorority.model.UsuarioBo;
import com.google.gson.Gson;
import com.vividsolutions.jts.io.ParseException;
import com.vividsolutions.jts.io.WKTReader;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

/**
 *
 * @author Natarajan
 */
@WebServlet(name = "DenunciaAddController", urlPatterns = {"/DenunciaAddController"})
public class DenunciaAddController extends HttpServlet {

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
            throws ServletException, IOException, ParseException, Exception {
        request.setCharacterEncoding("UTF-8");
        Denuncia d = buildDenuncia(request);
        
        DenunciaBo bo = new DenunciaBo();
        
        Map<String, String> verificaDenuncia = bo.verificarDenuncia(d);
        boolean resultadoAddDenuncia = false;

        if (verificaDenuncia.get("passou").equals("true")) {

            
            try {
                resultadoAddDenuncia = bo.addDenuncia(d);
            } catch (Exception ex) {
                Logger.getLogger(CadastrarUsuarioController.class.getName()).log(Level.SEVERE, null, ex);
                System.err.println(ex.getMessage());
            } finally {
//                if (resultadoAddDenuncia) {
//                    Integer idCriado = boCadastro.buscarPorEmail(usuario.getEmail()).getId();
//                    usuario.setId(idCriado);
//                    sessao.setAttribute("usuario", usuario);
//                }
            }
        }

        String json = new Gson().toJson(verificaDenuncia);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
        
    }
    
    private Denuncia buildDenuncia(HttpServletRequest request) throws ParseException{
        Denuncia d = new Denuncia();
        
        WKTReader reader = new WKTReader();
        
        //pegando os dados
        String coordText = (String) request.getParameter("local");
        String tipo = (String) request.getParameter("tipo");
        String denunciador = (String) request.getParameter("denunciador");
        String anonima[];
        anonima = request.getParameterValues("anonima");
        
        
        
        //setando os dados
        d.setInformacao(request.getParameter("informacao"));
        d.setTipo(TipoDenuncia.valueOf(tipo));
        d.setTipoDenunciador(TipoDenunciador.valueOf(denunciador));
        if (anonima != null) {
            d.setDenunciaAnonima(true);
        } else {
            d.setDenunciaAnonima(false);
        }
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        String data = request.getParameter("data");
        if (data != null && data != "") {
            d.setData(LocalDate.parse(data, dtf));
        }
        
        Usuario user = (Usuario)request.getSession().getAttribute("usuario");
        d.setIdUsuario(user.getId());
        
        d.setGeometry(reader.read("POINT("+ coordText +")"));
        
        return d;
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(DenunciaAddController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(DenunciaAddController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
