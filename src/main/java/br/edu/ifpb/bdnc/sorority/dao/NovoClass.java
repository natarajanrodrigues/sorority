/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.ifpb.bdnc.sorority.dao;

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
public class NovoClass {
    public static void main(String[] args) throws Exception {
        DenunciaDao d = new DenunciaDao();
        try {
            List<Denuncia> l = d.getDenunciasEmRaio("-6.76486628013948 ", "-38.2367610932852", 200);
            for (Denuncia denuncia : l) {
                System.out.println(denuncia.getGeometry().toText());
            }
//            System.out.println(d.allToGeoJson());
        } catch (SQLException ex) {
            Logger.getLogger(NovoClass.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(NovoClass.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(NovoClass.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
