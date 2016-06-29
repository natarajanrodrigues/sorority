/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.ifpb.bdnc.sorority.model;

import br.edu.ifpb.bdnc.sorority.dao.UsuarioDao;
import br.edu.ifpb.bdnc.sorority.entidade.Usuario;

/**
 *
 * @author Natarajan
 */
public class UsuarioBo {
    private static UsuarioDao dao = new UsuarioDao();
    
    public Usuario login(String usuario, String senha) throws Exception{
        return dao.login(senha, senha);
    }
    
}
