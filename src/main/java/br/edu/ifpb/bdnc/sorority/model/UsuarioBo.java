/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.ifpb.bdnc.sorority.model;

import br.edu.ifpb.bdnc.sorority.dao.UsuarioDao;
import br.edu.ifpb.bdnc.sorority.entidade.Usuario;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

/**
 *
 * @author Natarajan
 */
public class UsuarioBo {
    
    public static final Pattern REGEX_EMAIL_VALIDO = Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$", Pattern.CASE_INSENSITIVE);
    
    private static UsuarioDao dao = new UsuarioDao();
    
    public Usuario login(String usuario, String senha) throws Exception{
        return dao.login(senha, senha);
    }
    
    public boolean cadastrar(Usuario usuario){
        return dao.adicionar(usuario);
    }
    
    public Usuario buscarPorEmail(String email){
        return dao.buscarPorEmail(email);
    }
    
    public static Map<String,String> verificarCadastro(Usuario usuario){
        Map<String, String> resultado = new HashMap<>();

        if (usuario == null) {
            return null;
        }

        if (usuario.getNome() == null || usuario.getNome().trim().isEmpty()) {
            resultado.put("nome", "Informe seu nome.");
        } else if (!usuario.getNome().matches("[A-Za-zÀ-ú0-9 ]+")) {
            resultado.put("nome", "Nome não pode conter caracteres especiais (% - $ _ # @, por exemplo).");
        }


        if (    usuario.getEmail() == null ||
                usuario.getEmail().trim().isEmpty() ||
                !REGEX_EMAIL_VALIDO.matcher(usuario.getEmail()).find())
        {
            resultado.put("emailCadastro", "Informe um email válido.");
        } else {
            Usuario usuarioEmail = dao.buscarPorEmail(usuario.getEmail());
            if (usuarioEmail != null) {
                resultado.put("emailJaExiste", "Já existe um usuário cadastro com este email informado.");
            }
        }

        if (usuario.getSenha() == null || usuario.getSenha().trim().isEmpty()) {
            resultado.put("senhaCadastro", "Informe sua senha.");
        }

        if (resultado.isEmpty()) {
            resultado.put("passou", "true");
        } else {
            resultado.put("passou", "false");
        }

        return resultado;
    }
    
}
