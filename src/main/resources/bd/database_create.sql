CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;

CREATE TABLE Usuario(
    id SERIAL NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    senha VARCHAR(32) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    eh_admin BOOLEAN DEFAULT 'FALSE',
    PRIMARY KEY(id)
);

CREATE TABLE Denuncia (
    id SERIAL,
	local GEOMETRY(Point, 26910),
        data_denuncia DATE,
	tipo VARCHAR(20) NOT NULL,
        tipo_denunciador VARCHAR(20) NOT NULL,
	id_usuario INT NOT NULL,
        eh_anonima BOOLEAN DEFAULT 'TRUE',
	informacao VARCHAR(1000),
        
	FOREIGN KEY (id_usuario) REFERENCES Usuario(id) ON DELETE RESTRICT,
	PRIMARY KEY (id)
);

ALTER TABLE denuncia ADD CONSTRAINT enforce_srid_wkt CHECK (ST_Srid(local) = 26910);

CREATE INDEX Denuncia_gix ON Denuncia USING GIST (local);

INSERT INTO Usuario (email, senha, nome, eh_admin) VALUES ('admin@admin.com', 'admin', 'Admin', 'true');
/*

SELECT *
FROM Denuncia
WHERE
  ST_DWithin(
    Geography(DENUNCIA.LOCAL),
    Geography(ST_GeographyFromText('SRID=26910;POINT(-6.76486628013948 -38.2367610932852)')),
    1000
  );



 SELECT m2.id, m2.tipo, m2.id_usuario, m2.informacao, st_astext(m2.local) as local_text, ST_Distance(m1.local, m2.local) * (40075/360) as distância
FROM denuncia m1, denuncia m2
WHERE ST_Distance(m1.local, m2.local) * (40075/360) <= 1000
AND st_astext(m1.local) = 'POINT(-8.26223094251021 -39.1357422620058)'
AND m2.id <> m1.id;

SELECT row_to_json(fc)
 FROM ( SELECT 'FeatureCollection' As type, array_to_json(array_agg(f)) As features
 FROM (SELECT 'Feature' As type
    , ST_AsGeoJSON(lg.local)::json As geometry
    , row_to_json(lp) As properties
   FROM denuncia As lg
         INNER JOIN (SELECT id, tipo, id_usuario, informacao FROM denuncia) As lp
       ON lg.id = lp.id  ) As f )  As fc;

*/
