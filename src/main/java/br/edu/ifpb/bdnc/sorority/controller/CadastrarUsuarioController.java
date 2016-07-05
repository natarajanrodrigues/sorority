/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.ifpb.bdnc.sorority.controller;

import br.edu.ifpb.bdnc.sorority.entidade.Usuario;
import br.edu.ifpb.bdnc.sorority.model.UsuarioBo;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Natarajan
 */
@WebServlet(name = "CadastrarUsuarioController", urlPatterns = {"/cadastrar"})
public class CadastrarUsuarioController extends HttpServlet {

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
        HttpSession sessao = request.getSession();
        
        
        
        Usuario usuario = montarUsuario(request);

        Map<String, String> resultadoVerificacao = UsuarioBo.verificarCadastro(usuario);

        boolean resultadoCadastro = false;

        if (resultadoVerificacao.get("passou").equals("true")) {

            UsuarioBo boCadastro = new UsuarioBo();
            try {
                resultadoCadastro = boCadastro.cadastrar(usuario);
            } catch (Exception ex) {
                Logger.getLogger(CadastrarUsuarioController.class.getName()).log(Level.SEVERE, null, ex);
                System.err.println(ex.getMessage());
            } finally {
                if (resultadoCadastro) {
                    Integer idCriado = boCadastro.buscarPorEmail(usuario.getEmail()).getId();
                    usuario.setId(idCriado);
                    sessao.setAttribute("usuario", usuario);
                }
            }
        }

        String json = new Gson().toJson(resultadoVerificacao);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
    
    
    private Usuario montarUsuario(HttpServletRequest request) {
        Usuario user = new Usuario();

        if (request.getParameter("nome") != null) {
            user.setNome(request.getParameter("nome"));
        }
        
        if (request.getParameter("email") != null) {
            user.setEmail(request.getParameter("email"));
        }

        if (request.getParameter("senha") != null) {
            user.setSenha(request.getParameter("senha"));
        }

        user.setAdmin(false);

        return user;
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
