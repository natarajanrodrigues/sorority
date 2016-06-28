/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.ifpb.bdnc.sorority.entidade;

import java.io.Serializable;
import java.util.Comparator;
import java.util.Objects;

/**
 *
 * @author José
 */
public class Usuario implements Serializable{
    private Integer id;
    private String email;
    private String senha;
    private String nome;
    private boolean admin;

    public Usuario() {
    }

    public Usuario(Integer id, String email, String senha, String nome, boolean eh_admin) {
        this.id = id;
        this.email = email;
        this.senha = senha;
        this.nome = nome;
        this.admin = eh_admin;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public boolean isAdmin() {
        return admin;
    }

    public void setAdmin(boolean admin) {
        this.admin = admin;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 97 * hash + Objects.hashCode(this.id);
        hash = 97 * hash + Objects.hashCode(this.email);
        hash = 97 * hash + Objects.hashCode(this.senha);
        hash = 97 * hash + Objects.hashCode(this.nome);
        hash = 97 * hash + (this.admin ? 1 : 0);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Usuario other = (Usuario) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }
    
    public static class Comparators {
        public static final Comparator<Usuario> ID = (Usuario u1, Usuario u2) -> u1.getId().compareTo(u2.getId());
        public static final Comparator<Usuario> NAME = (Usuario u1, Usuario u2) -> u1.getNome().compareTo(u2.getNome());
    }

}
