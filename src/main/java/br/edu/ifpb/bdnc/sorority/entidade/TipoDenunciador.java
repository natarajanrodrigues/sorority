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
public enum TipoDenunciador {
    TESTEMUNHA(1), VÍTIMA(2);
    
    public int id;
    
    private TipoDenunciador(int id){
        this.id = id;
    }
    
    
}
