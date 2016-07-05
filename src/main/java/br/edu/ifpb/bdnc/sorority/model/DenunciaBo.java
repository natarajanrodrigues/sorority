/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.ifpb.bdnc.sorority.model;

import br.edu.ifpb.bdnc.sorority.dao.DenunciaDao;
import br.edu.ifpb.bdnc.sorority.entidade.Denuncia;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Natarajan
 */
public class DenunciaBo {

    private DenunciaDao dao = new DenunciaDao();

    ;

    public boolean addDenuncia(Denuncia d) throws Exception {
        return dao.add(d);
    }

    public List<Denuncia> getAll() throws Exception {
        return dao.getAllDenuncias();
    }

    public String allMarkersGeoJson() {
        String result = null;
        try {
            result = dao.allToGeoJson();
        } catch (SQLException ex) {
            Logger.getLogger(DenunciaBo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(DenunciaBo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DenunciaBo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public Map<String, String> verificarDenuncia(Denuncia d) {
        
        Map<String, String> resultado = new HashMap<>();

        if (d == null) {
            return null;
        }

//        if (usuario.getNome() == null || usuario.getNome().trim().isEmpty()) {
//            resultado.put("nome", "Informe seu nome.");
//        } else if (!usuario.getNome().matches("[A-Za-zÀ-ú0-9 ]+")) {
//            resultado.put("nome", "Nome não pode conter caracteres especiais (% - $ _ # @, por exemplo).");
//        }
//
//
//        if (    usuario.getEmail() == null ||
//                usuario.getEmail().trim().isEmpty() ||
//                !REGEX_EMAIL_VALIDO.matcher(usuario.getEmail()).find())
//        {
//            resultado.put("emailCadastro", "Informe um email válido.");
//        } else {
//            Usuario usuarioEmail = dao.buscarPorEmail(usuario.getEmail());
//            if (usuarioEmail != null) {
//                resultado.put("emailJaExiste", "Já existe um usuário cadastro com este email informado.");
//            }
//        }
//
//        if (usuario.getSenha() == null || usuario.getSenha().trim().isEmpty()) {
//            resultado.put("senhaCadastro", "Informe sua senha.");
//        }

        if (resultado.isEmpty()) {
            resultado.put("passou", "true");
        } else {
            resultado.put("passou", "false");
        }

        return resultado;
    
    }
}
