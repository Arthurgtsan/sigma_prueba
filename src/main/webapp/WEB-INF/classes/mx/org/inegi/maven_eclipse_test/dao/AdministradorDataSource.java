package mx.org.inegi.maven_eclipse_test.dao;

import javax.sql.DataSource;
import org.apache.commons.dbcp2.BasicDataSource;

/**
 *
 * @author Oscar.Duran
 */
public class AdministradorDataSource {
    private static DataSource dsp;
    
    public static DataSource getDataSource() throws Exception {
        if (dsp == null) {
            BasicDataSource bds = new BasicDataSource();
           
            bds.setDriverClassName("org.postgresql.Driver");
            bds.setUrl("jdbc:postgresql://10.153.3.32:5433/bdginegi");
            bds.setUsername("datawarehouse");
            bds.setPassword("datawarehouse17");

            bds.setTestWhileIdle(true);
            bds.setTestOnBorrow(true);
            bds.setTestOnReturn(false);
            bds.setValidationQuery("select 1 as uno");
            bds.setValidationQueryTimeout(3000);
            bds.setTimeBetweenEvictionRunsMillis(5000);
            bds.setRemoveAbandonedTimeout(60);
            bds.setRemoveAbandonedOnBorrow(true);
            bds.setLogAbandoned(true);
            bds.setMinEvictableIdleTimeMillis(30000);
            bds.setMaxTotal(2);
            bds.setMinIdle(1);
            bds.setMaxWaitMillis(500000);
            bds.setInitialSize(1);
            bds.setMaxConnLifetimeMillis(500000);	        
            
            dsp = bds;
        }
        return dsp;        
    }
}