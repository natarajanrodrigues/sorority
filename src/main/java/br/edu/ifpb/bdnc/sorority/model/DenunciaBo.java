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
import java.util.List;
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
}
