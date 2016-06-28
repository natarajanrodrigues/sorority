/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.ifpb.bdnc.sorority.conexao;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;


public class Conexao {

    private Connection conn;
    private static Properties prop = null;

    public Conexao() throws SQLException, IOException, ClassNotFoundException {
        try {            
            //carrega as propriedades do arquivo connection.properties da pasta resources
            prop = new Properties();            
            prop.load(new FileInputStream(getClass().getResource("/bd/connection.properties").toURI().getPath()));
            
            String url = prop.getProperty("url");
            String user = prop.getProperty("user");
            String password = prop.getProperty("password");
            
            Class.forName("org.postgresql.Driver");
            this.conn = DriverManager.getConnection(url, user, password);
        } catch (IOException | ClassNotFoundException | SQLException | URISyntaxException e) {
            System.err.println(e.getMessage());
        }
    }


    public Connection getConnection() {
        return this.conn;
    }


    public void closeAll(PreparedStatement stat) throws Exception {
        try {
            stat.close();
            this.conn.close();

        } catch (SQLException e) {
            throw new Exception("Falha ao fechar conexões: " + e.getMessage());
        }

    }

    
    public void closeAll(Statement stat) throws Exception {
        try {
            stat.close();
            this.conn.close();
        } catch (SQLException e) {
            throw new Exception("Falha ao fechar conexões: " + e.getMessage());
        }
    }

}
