package mx.org.inegi;

import java.sql.Connection;
import java.sql.SQLException;


import javax.sql.DataSource;
import org.apache.commons.dbcp2.BasicDataSource;




public class AdministradorDataSource_Sigma {
    private static DataSource dsp;
    
	// inicializa todos los data sources
	private static DataSource dataSource_1;
	private static DataSource dataSource_2;
	private static DataSource dataSource_3;
	private static DataSource dataSource_4;
	private static DataSource dataSource_5;
	private static DataSource dataSource_6;
	private static DataSource dataSource_7;
	private static DataSource dataSource_8;
	private static DataSource dataSource_9;
	private static DataSource dataSource_10;
	private static DataSource dataSource_10_ed;
	//private static DataSource dataSource_neatil;
			
	 public static String error_sql; 
    
	   
  
	     
		public static DataSource getDataSource(String user, String pass, String url, String pto, String base) {
			
			BasicDataSource ds = new BasicDataSource();
		    ds.setDriverClassName("org.postgresql.Driver");
		    ds.setUsername(user);
		    ds.setPassword(pass);
		    ds.setUrl("jdbc:postgresql://" + url + ":" + pto + "/" + base);
		    /*
		    //originals
		    ds.setTestWhileIdle(true);
		    ds.setTestOnBorrow(true);
		    ds.setTestOnReturn(false);
		    ds.setValidationQuery("select 1 as uno");
		    ds.setValidationQueryTimeout(3000);
		    ds.setTimeBetweenEvictionRunsMillis(5000);
		    ds.setRemoveAbandonedTimeout(60);
		    ds.setRemoveAbandonedOnBorrow(true);
		    ds.setLogAbandoned(true);
		    ds.setMinEvictableIdleTimeMillis(30000);
		    ds.setMaxTotal(2);
		    ds.setMinIdle(1);
		    ds.setMaxWaitMillis(500000);
		    ds.setInitialSize(1);
		    ds.setMaxConnLifetimeMillis(500000);
		    */
		    
		    
		    ds.setTestWhileIdle(true); //Se realizará una prueba de validación en cada conexión inactiva en el pool a intervalos regulares.
		    ds.setTestOnBorrow(true);//Se realizará una prueba de validación en cada conexión que se solicite del pool antes de entregarla al cliente
		    ds.setTestOnReturn(false); //Determina si se debe realizar una prueba de validación en una conexión cuando se devuelve al pool.
		    ds.setValidationQuery("select 1 as uno"); //Consulta utilizada para validar la conexión antes de entregarla desde el pool.
		    ds.setValidationQueryTimeout(3000); // Tiempo máximo en segundos que se espera para que se complete una consulta de validación de conexión.
		    ds.setTimeBetweenEvictionRunsMillis(5000); //  Define con qué frecuencia el pool ejecutará el proceso de eviction (desalojo). 
		    ds.setRemoveAbandonedTimeout(60);// (En segundos) Monitorea el tiempo transcurrido desde la última vez que se utilizó una conexión. Si el tiempo transcurrido supera el valor especificado en setRemoveAbandonedTimeout, la conexión se considera abandonada y se elimina del pool.
		    ds.setRemoveAbandonedOnBorrow(true); //Determina si las conexiones abandonadas deben ser eliminadas del pool cuando se solicita una conexión (borrow) desde el pool
		    ds.setLogAbandoned(true);//Se registrarán mensajes en el registro (log) cuando una conexión del pool sea considerada abandonada. Una conexión se considera abandonada cuando se devuelve al pool pero se detecta que fue cerrada por la aplicación en lugar de ser devuelta correctamente.
		    ds.setMinEvictableIdleTimeMillis(30000); //Si una conexión ha estado inactiva durante al menos el tiempo especificado, se considera elegible para ser eliminada del pool cuando el proceso de "eviction" (desalojo) se ejecute. 
		    ds.setMaxTotal(10); //Total de conexiones posibles en el pool
		    ds.setMinIdle(5); // Mínimo número de conexiones inactivas en el pool
		    ds.setMaxIdle(5); // Número máximo de conexiones inactivas en el pool
		    ds.setMaxWaitMillis(500000); // Tiempo máximo que una solicitud de conexión puede esperar (en milisegundos).
		    ds.setInitialSize(1); //Conexiones con que inicia el pool
		    ds.setMaxConnLifetimeMillis(500000); // Se enfoca en la edad total de la conexión, cerrándola una vez que ha alcanzado el tiempo máximo de vida, independientemente de si está activa o inactiva.
		    
		    		    
		    
		    
		    return ds;
			
		}
    

		public static Connection getConnection(String opcion) throws SQLException {
			error_sql = null; 
			try {
			switch (opcion) {
		case "act1":
				if (dataSource_1 == null) {
					dataSource_1 =  getDataSource("arcgis","arcgis","l-appwebmd1.inegi.gob.mx","5434","actcargeo1");
				}
				return dataSource_1.getConnection();
					
		case "act2":
			if (dataSource_2 == null) {
				dataSource_2 =  getDataSource("arcgis","arcgis","l-appwebmd1.inegi.gob.mx","5434","actcargeo2");
			}
			return dataSource_2.getConnection();
		case "act3":
			if (dataSource_3 == null) {
				dataSource_3 =  getDataSource("arcgis","arcgis","l-appwebmd1.inegi.gob.mx","5434","actcargeo3");
			}
			return dataSource_3.getConnection();
		case "act4":
			if (dataSource_4 == null) {
				dataSource_4 =  getDataSource("arcgis","arcgis","l-appwebmd1.inegi.gob.mx","5434","actcargeo4");
			}
			return dataSource_4.getConnection();
		case "act5":
			if (dataSource_5 == null) {
				dataSource_5 =  getDataSource("arcgis","arcgis","l-appwebmd1.inegi.gob.mx","5434","actcargeo5");
			}
			return dataSource_5.getConnection();
		case "act6":
			if (dataSource_6 == null) {
				dataSource_6 =  getDataSource("arcgis","arcgis","l-appwebmd1.inegi.gob.mx","5434","actcargeo6");
			}
			return dataSource_6.getConnection();
		case "act7":
			if (dataSource_7 == null) {
				dataSource_7 =  getDataSource("arcgis","arcgis","l-appwebmd1.inegi.gob.mx","5434","actcargeo7");
			}
			return dataSource_7.getConnection();
		case "act8":
			if (dataSource_8 == null) {
				dataSource_8 =  getDataSource("arcgis","arcgis","l-appwebmd1.inegi.gob.mx","5434","actcargeo8");
			}
			return dataSource_8.getConnection();
		case "act9":
			if (dataSource_9 == null) {
				dataSource_9 =  getDataSource("arcgis","arcgis","l-appwebmd1.inegi.gob.mx","5434","actcargeo9");
			}
			return dataSource_9.getConnection();
		case "act10":
			if (dataSource_10 == null) {
				dataSource_10 =  getDataSource("arcgis","arcgis","l-appwebmd1.inegi.gob.mx","5434","actcargeo10");
			}
			return dataSource_10.getConnection();
			//local para pruebas en mi maquina, luego poner como local la de ntl y eliminar esta 
		//case "local": 
		//	  return getDataSource("postgres","Arthur01","localhost","5434","catalogos").getConnection();  
		//case "local_arcgis":
		//	  return getDataSource("arcgis","arcgis","localhost","5432","catalogos").getConnection();
		case "act10_ed":
			if (dataSource_10_ed == null) {
				dataSource_10_ed =  getDataSource("actcar","actcar","l-appwebmd1.inegi.gob.mx","5434","actcargeo10");
			}
			return dataSource_10_ed.getConnection();
		
		
		  
		  default:
		    return null;
		}
			
	    } catch (SQLException e) {
			        // Manejo de errores SQL
			        //e.printStackTrace();
			        //JOptionPane.showMessageDialog(null, e.toString(), "Info", JOptionPane.INFORMATION_MESSAGE);
	    			error_sql= e.toString();
	    			
			        return null;
			    }
	}

		
			
		
		
		public static String Pool_details_base_10() {
			String bd = "actcargeo10";
			
			return bd;
			}
		
		
		
		public static int Pool_details_active() {
			int conectados = 0;
			BasicDataSource ds2 = new BasicDataSource();
			
				if (dataSource_10 != null) {
					ds2= (BasicDataSource) dataSource_10;
					conectados= ds2.getNumActive();
				//ds.getNumIdle();
				}
				return conectados;
			}
		
		
		public static int Pool_details_inactive() {
			int conectados = 0;
			BasicDataSource ds2 = new BasicDataSource();
			
				if (dataSource_10 != null) {
					ds2= (BasicDataSource) dataSource_10;
					conectados= ds2.getNumIdle();
				//ds.getNumIdle();
				}
				return conectados;
			}
		
		
		public static int Pool_details_max() {
			int conectados = 0;
			BasicDataSource ds2 = new BasicDataSource();
			
				if (dataSource_10 != null) {
					ds2= (BasicDataSource) dataSource_10;
					conectados= ds2.getMaxTotal();
					
				//ds.getNumIdle();
				}
				return conectados;
			}
		
		
		
    
}