package mx.org.inegi.maven_eclipse_test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;

import mx.org.inegi.maven_eclipse_test.dto.AgeeDTO;
import mx.org.inegi.maven_eclipse_test.dto.AgemDTO;
import mx.org.inegi.maven_eclipse_test.dto.LocsDTO;

public class MgDAO {

    public List<AgeeDTO> obtenerEstados() throws Exception {
        DataSource dataSource = AdministradorDataSource.getDataSource();
        Connection connection = dataSource.getConnection();

        List<AgeeDTO> listaEstados = new ArrayList<>();
        try {
            String sql = "SELECT objectid, cvegeo, nomgeo FROM mgn_2022.areas_geoestadisticas_estatales ORDER BY cvegeo";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                AgeeDTO item = new AgeeDTO();
                item.setObjectid(resultSet.getInt(1));
                item.setCvegeo(resultSet.getString(2));
                item.setNombre(resultSet.getString(3));
                listaEstados.add(item);
            }
        } finally {
            connection.close();
        }
        return listaEstados;
    }

    public List<AgemDTO> obtenerMunicipios(String cve_ent) throws Exception {
        DataSource dataSource = AdministradorDataSource.getDataSource();
        Connection connection = dataSource.getConnection();

        List<AgemDTO> listaMunicipios = new ArrayList<>();
        try {
            String sql = "SELECT objectid, cve_ent, cvegeo, nomgeo FROM mgn_2022.areas_geoestadisticas_municipales WHERE cve_ent=? ORDER BY cvegeo";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, cve_ent);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                AgemDTO item = new AgemDTO();
                item.setObjectid(resultSet.getInt(1));
                item.setCve_ent(resultSet.getString(2));
                item.setCvegeo(resultSet.getString(3));
                item.setNombre(resultSet.getString(4));
                listaMunicipios.add(item);
            }
        } finally {
            connection.close();
        }
        return listaMunicipios;
    }

    public List<LocsDTO> obtenerLocalidades(String cvegeo) throws Exception {
        DataSource dataSource = AdministradorDataSource.getDataSource();
        Connection connection = dataSource.getConnection();

        List<LocsDTO> listaLocs = new ArrayList<>();
        try {
            String sql = "SELECT objectid, cvegeo, nomgeo FROM mgn_2022.poligono_de_localidades_urbanas_y_rurales_amz WHERE (cve_ent||cve_mun)=? ORDER BY cvegeo";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, cvegeo);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                LocsDTO item = new LocsDTO();
                item.setObjectid(resultSet.getInt(1));
                item.setCvegeo(resultSet.getString(2));
                item.setNombre(resultSet.getString(3));
                listaLocs.add(item);
            }
        } finally {
            connection.close();
        }
        return listaLocs;
    }
}
