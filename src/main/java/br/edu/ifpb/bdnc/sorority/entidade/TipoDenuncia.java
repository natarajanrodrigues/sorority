/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.ifpb.bdnc.sorority.entidade;

/**
 *
 * @author Natarajan
 */
public enum TipoDenuncia {
    ASSEDIO(1), VIOLENCIA(2), ESTUPRO(3);
    
    public int id;
    
    private TipoDenuncia(int id){
        this.id = id;
    }
    
    
}
