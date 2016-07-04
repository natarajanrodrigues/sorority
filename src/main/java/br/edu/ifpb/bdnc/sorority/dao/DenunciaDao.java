/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.ifpb.bdnc.sorority.dao;

import br.edu.ifpb.bdnc.sorority.conexao.Conexao;
import br.edu.ifpb.bdnc.sorority.entidade.Denuncia;
import br.edu.ifpb.bdnc.sorority.entidade.TipoDenuncia;
import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.io.ParseException;
import com.vividsolutions.jts.io.WKTReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Natarajan
 */
public class DenunciaDao {

    private WKTReader reader = new WKTReader();
    private Conexao conn;

    public boolean add(Denuncia d) throws Exception {
        if (conn == null) {
            conn = new Conexao();
        }
        Connection c = conn.getConnection();
        String sql = "INSERT INTO Denuncia (local, data_denuncia, tipo, tipo_denunciador, id_usuario, eh_anonima, informacao) VALUES (ST_GeomFromText(?, 26910), ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = null;

        try {
            ps = c.prepareStatement(sql);
//            ps.setString(1, "'" + d.getGeometry().toText() + "'");
            ps.setString(1, d.getGeometry().toText());
            ps.setDate(2, Date.valueOf(d.getData()));
            ps.setString(3, d.getTipo().name());
            ps.setString(4, d.getTipoDenunciador().name());
            ps.setInt(5, d.getIdUsuario());
            ps.setBoolean(6, d.isDenunciaAnonima());
            ps.setString(7, d.getInformacao());

            return ps.executeUpdate() != 0;

        } catch (SQLException ex) {
            Logger.getLogger(DenunciaDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.closeAll(ps);
        }
        return false;
    }

    public Denuncia getDenuncia(String lat, String lon) throws Exception {
        if (conn == null) {
            conn = new Conexao();
        }
        Connection c = conn.getConnection();
        String sql = "SELECT (id, tipo, id_usuario, informacao, st_astext(local) as local_text) FROM Denuncia WHERE ST_X(local) = ? AND ST_Y(local) = ?";
        PreparedStatement ps = null;

        try {
            ps = c.prepareStatement(sql);
            ps.setString(1, lat);
            ps.setString(2, lon);
            
            ResultSet rs = ps.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(DenunciaDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.closeAll(ps);
        }
        return null;
    }

    public List<Denuncia> getDenunciasEmRaio(String centerLat, String centerLng, float raioEmMetros) throws Exception {
        if (conn == null) {
            conn = new Conexao();
        }
        List<Denuncia> result = new ArrayList<Denuncia>();
        Connection c = conn.getConnection();
        String sql
                = "SELECT m2.id, m2.tipo, m2.id_usuario, m2.informacao, st_astext(m2.local) as local_text, ST_Distance(m1.local, m2.local) * (40075/360) as distância "
                + "FROM denuncia m1, denuncia m2 "
                + "WHERE ST_Distance(m1.local, m2.local) * (40075/360) <= ? AND st_astext(m1.local) = ? AND m2.id <> m1.id ";
        PreparedStatement ps = null;

        try {
            ps = c.prepareStatement(sql);
            
            System.out.println(sql);
            
            ps.setFloat(1, new Float(raioEmMetros));
//            ps.setString(2, centerLat);
            ps.setString(2, "POINT(" + centerLat.trim() + " " + centerLng.trim() + ")");
            
            System.out.println(ps.toString());
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.add(montaDenuncia(rs));
            }

        } catch (SQLException ex) {
            Logger.getLogger(DenunciaDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.closeAll(ps);
        }
        return result;
    }
    
    public List<Denuncia> getAllDenuncias() throws Exception {
        if (conn == null) {
            conn = new Conexao();
        }
        List<Denuncia> result = new ArrayList<>();
        Connection connection = conn.getConnection();
        String sql
                = "SELECT id, tipo, id_usuario, informacao, st_astext(local) as local_text FROM Denuncia";
        PreparedStatement ps = null;

        try {
            ps = connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                Denuncia d = montaDenuncia(rs);
                System.out.println(i++);
                        
                result.add(d);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DenunciaDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.closeAll(ps);
        }
        return result;
    }
    
    

    public String allToGeoJson() throws SQLException, IOException, ClassNotFoundException {
        if (conn == null) {
            conn = new Conexao();
        }
        String result = null;
        Connection c = conn.getConnection();
        String sql
                = "SELECT row_to_json(fc)"
                + " FROM ( SELECT 'FeatureCollection' As type, array_to_json(array_agg(f)) As features"
                + " FROM (SELECT 'Feature' As type"
                + "    , ST_AsGeoJSON(lg.local)::json As geometry"
                + "    , row_to_json(lp) As properties"
                + "   FROM denuncia As lg "
                + "         INNER JOIN (SELECT id, tipo, eh_anonima, tipo, tipo_denunciador, data_denuncia, informacao FROM denuncia) As lp "
                + "       ON lg.id = lp.id  ) As f )  As fc;";
        PreparedStatement ps = null;

        try {
            ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                result = rs.getString("row_to_json");
            }

        } catch (SQLException ex) {
            Logger.getLogger(DenunciaDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                conn.closeAll(ps);
            } catch (Exception ex) {
                Logger.getLogger(DenunciaDao.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return result;
    }

    private Denuncia montaDenuncia(ResultSet rs) throws SQLException, ParseException {
        Denuncia d = new Denuncia();
        d.setId(rs.getInt("id"));
        d.setIdUsuario(rs.getInt("id_usuario"));
        d.setTipo(TipoDenuncia.valueOf(rs.getString("tipo")));
        d.setInformacao(rs.getString("informacao"));
        
        System.out.println(rs.getString("local_text") + " " + rs.getInt("id"));
        
        Geometry local = reader.read(rs.getString("local_text"));
        d.setGeometry(local);
        return d;
    }

    public boolean remove(int id) throws Exception {
        if (conn == null) {
            conn = new Conexao();
        }
        Connection c = conn.getConnection();
        String sql = "DELETE FROM Denuncia WHERE id = ?";
        PreparedStatement ps = null;
        try {
            ps = c.prepareStatement(sql);
            ps.setInt(1, id);

            if (ps.executeUpdate() > 0) {
                return true;
            }

        } catch (SQLException ex) {
            Logger.getLogger(DenunciaDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conn.closeAll(ps);
        }
        return false;
    }

}
