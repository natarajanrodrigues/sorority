/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.ifpb.bdnc.sorority.entidade;

import com.vividsolutions.jts.geom.Geometry;
import java.time.LocalDate;

/**
 *
 * @author Natarajan
 */
public class Denuncia {
    private int id;
    private Geometry geometry; 
    private TipoDenuncia tipo;
    private TipoDenunciador tipoDenunciador;
    private int idUsuario;
    private boolean denunciaAnonima;
    private String informacao; 
    private LocalDate data;

    public Denuncia() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Geometry getGeometry() {
        return geometry;
    }

    public void setGeometry(Geometry geometry) {
        this.geometry = geometry;
    }

    public TipoDenuncia getTipo() {
        return tipo;
    }

    public void setTipo(TipoDenuncia tipo) {
        this.tipo = tipo;
    }

    public TipoDenunciador getTipoDenunciador() {
        return tipoDenunciador;
    }

    public void setTipoDenunciador(TipoDenunciador tipoDenunciador) {
        this.tipoDenunciador = tipoDenunciador;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public boolean isDenunciaAnonima() {
        return denunciaAnonima;
    }

    public void setDenunciaAnonima(boolean denunciaAnonima) {
        this.denunciaAnonima = denunciaAnonima;
    }

    public String getInformacao() {
        return informacao;
    }

    public void setInformacao(String informacao) {
        this.informacao = informacao;
    }

    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        this.data = data;
    }
    
}
