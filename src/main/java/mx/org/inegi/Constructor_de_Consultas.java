package mx.org.inegi;


import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

//import org.jooq.*;
//import org.jooq.impl.DSL;
//import static org.jooq.impl.DSL.*;

//import static org.jooq.impl.DSL.*;
//import org.jooq.*;
//import org.jooq.Record;
//import org.jooq.impl.*;

import java.util.regex.Pattern;

//import javax.servlet.http.HttpServletResponse;

import javax.sql.rowset.CachedRowSet;
import javax.sql.rowset.RowSetProvider;
import java.util.Calendar;

//import mx.org.inegi_nuevo_sigma_historicos_prueba.dao.alerta;
//import ;


public class Constructor_de_Consultas {

//	private static CachedRowSet rs;
//	public static CachedRowSet getRowSet() {
//			return rs;
//	}
    
    
    public static String no_injection(String cadn) {
	        
	    	String consultaLimpia = null;
	    	try {
	    	// Definir las palabras maliciosas que deseas eliminar
	        String[] palabrasMaliciosas = {"update", "delete", "insert", ";", "union", "select", "drop", "truncate", "insert", "restore","backup"};
	        String patron = String.join("|", palabrasMaliciosas);
	        Pattern pattern = Pattern.compile(patron, Pattern.CASE_INSENSITIVE);
	        
	        // Realizar el reemplazo de las palabras maliciosas por una cadena vacía
	        //String consultaLimpia = cadn.replaceAll(patron, "");
	        //String consultaLimpia = cadn.replaceAll("(?i)" + patron, "");

	        consultaLimpia = pattern.matcher(cadn).replaceAll("");

	       
	    	
	    } catch (Exception e) {
			//e.printStackTrace();
		}
	    	 return consultaLimpia;
	    }
	
	
	
	
	
	// -----------------------------------------------------------------------------------

	    
	    public static void mostrarAlerta(String mensaje) {
	        try {
	            // Construir la URL del Servlet
	            String servletUrl = "http://localhost:8070/sigma_historicos_prueba/alerta?message=" + URLEncoder.encode(mensaje, "UTF-8");
	            
	            // Abrir una conexión HTTP y enviar la solicitud
	            URL url = new URL(servletUrl);
	            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	            connection.setRequestMethod("GET");
	            connection.getResponseCode();
	        } catch (Exception e) {
	            //e.printStackTrace();
	        }
	    }
	    
	    
	    
	    
	// @Override
	public static CachedRowSet consulta_index_01(String cnx, String pass) {

		//String sql = "select id,regid,nivel,nombre,edicion,cons,edicionmz,edicionpre,edicionagpr,restric,userdg,passdg,correo as correodg from usuarios where md5(password) = ?";
		String sql = "select id,regid,nivel,nombre,edicion,cons,edicionmz,edicionpre,edicionagpr,restric,userdg,passdg,correo as correodg, encdg,anuncio from usuarios where cons not in (672,673) and md5(password) = ?";
		
		//String sql = "select * from usuarios where cons=848";
		//String sql = "select * from pg_tables"; // Prueba una consulta simple
		
		ResultSet _rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		CachedRowSet rs = null;
		
		try {
		
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql);
			//ps = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			
			ps.setString(1, pass);
			ps.setQueryTimeout(3000);
			
			/*
			 * if (con == null) {
			 * 
			 * System.out.println("La conexión a la base de datos ha fallado."); return
			 * null; }
			 * 
			 * _rs = ps.executeQuery(); if (_rs == null) {
			 * System.out.println("No se obtuvieron resultados de la consulta."); return
			 * null; }
			 */
			  
				/*
				 * //id,regid,nivel,nombre,edicion,cons,edicionmz,edicionpre,edicionagpr,restric
				 * ,userdg,passdg,correo as correodg, encdg,anuncio while (_rs.next()) { //
				 * Acceder a los valores de las columnas por índice String id =
				 * _rs.getString("id"); String regid = _rs.getString("regid"); int nivel =
				 * _rs.getInt("nivel"); String nombre = _rs.getString("nombre"); int edicion =
				 * _rs.getInt("edicion"); int cons = _rs.getInt("cons"); int edicionmz =
				 * _rs.getInt("edicionmz"); int edicionpre = _rs.getInt("edicionpre"); int
				 * edicionagpr = _rs.getInt("edicionagpr"); String restric =
				 * _rs.getString("restric"); String userdg = _rs.getString("userdg"); String
				 * passdg = _rs.getString("passdg"); String correo = _rs.getString("correodg");
				 * String encdg = _rs.getString("encdg"); int anuncio = _rs.getInt("anuncio"); }
				 */ 

			  
				/*
				 * ResultSetMetaData metaData = _rs.getMetaData(); int columnCount =
				 * metaData.getColumnCount(); for (int i = 1; i <= columnCount; i++) {
				 * System.out.println("Column " + i + ": " + metaData.getColumnName(i)); }
				 */			  
			_rs = ps.executeQuery();
			rs = RowSetProvider.newFactory().createCachedRowSet();
			
			/*
			 * RowSetFactory factory = RowSetProvider.newFactory(); CachedRowSet crs =
			 * factory.createCachedRowSet(); System.out.println("Factory class: " +
			 * factory.getClass()); System.out.println("Factory source: " +
			 * factory.getClass().getProtectionDomain().getCodeSource().getLocation());
			 * 
			 * System.out.println("CachedRowSet class: " + crs.getClass());
			 * System.out.println("CachedRowSet source: " +
			 * crs.getClass().getProtectionDomain().getCodeSource().getLocation());
			 * 
			 */
						
			//_rs.beforeFirst(); // vuelve al inicio
			
			
			/*
			 * try { Class<?> driverClass = Class.forName("org.postgresql.Driver"); Package
			 * pkg = driverClass.getPackage();
			 * System.out.println("PostgreSQL Driver Version: " +
			 * pkg.getImplementationVersion()); System.out.println("Driver location: " +
			 * driverClass.getProtectionDomain().getCodeSource().getLocation()); } catch
			 * (ClassNotFoundException e) { e.printStackTrace(); }
			 */
			   
			//Solucion: Borra el archivo postgresql-8.3-603.jdbc3.jar que está dentro de la carpeta:
			//	src/main/webapp/WEB-INF/lib/
			//	No debe haber un .jar viejo embebido en el proyecto web que sobrescriba el driver de Maven.
			
			rs.populate(_rs);
			return rs;
	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;

		}

	// -----------------------------------------------------------------------------------

	// Con parámetros nombrados JOOQ
	public static CachedRowSet consulta_index_02(String cnx, String pass) {
		// Parámetros de ejemplo
		String param1 = no_injection(pass);
		// String param2 = pass;
		// Crear el contexto JOOQ utilizando una configuración y una conexión
		ResultSet _rs = null;
		//DSLContext context = null;
		CachedRowSet rs = null;
		//Connection connection = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		String sql = "select id,regid,nivel,nombre,edicion,cons,edicionmz,edicionpre,edicionagpr,restric,userdg,passdg,correo as correodg from usuarios where md5(password) = ? and md5(password) = ?";
		
		try {
			//connection = AdministradorDataSource_Sigma.getConnection(cnx);
			//context = DSL.using(connection, SQLDialect.POSTGRES);
			// Obtener los resultados
			//Result<Record> result = context.fetch(sql, param("0", param1));
			// param("1", param2));
			//_rs = result.intoResultSet();

			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql);
			ps.setString(1, pass);
			ps.setString(2, pass);
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			   rs = RowSetProvider.newFactory().createCachedRowSet();
			   rs.populate(_rs);
			return rs;
			
			
		
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		finally {if (con != null) {	try {con .close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}

	
	// -----------------------------------------------------------------------------------

	
	public static CachedRowSet consulta_index_03(String cnx, int usuario,String ip, String host, Timestamp fecha,boolean correcto, String regional) {

		
		String sql = "insert into usuarios_registro (usuario,ip,host,fecha,correcto,regional) values(?, ?, ?, ?, ?, ?)";
		
		//String sql = "select id,regid,nivel,nombre,edicion,cons,edicionmz,edicionpre,edicionagpr,restric,userdg,passdg,correo as correodg from usuarios where md5(password) = ?";
		ResultSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql);
			ps.setInt(1, usuario);
			ps.setString(2, ip);
			ps.setString(3, host);
			ps.setTimestamp(4, fecha);
			ps.setBoolean(5, correcto);
			ps.setString(6, regional);
			
			
			ps.setQueryTimeout(3000);
			ps.executeUpdate();
			return null;
	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (rs != null) {try {rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		 
		return null;

	}

	// -----------------------------------------------------------------------------------


	
	public static void consulta_reg_descarga_01(String cnx, String usuario, Timestamp fecha, int capa,String filtro, String regional, int forma, String c0, String c1, String c2, String c3) {

						
		String sql = "insert into usuarios_descsigma (origen,usuario,fecha,capa,filtro,regional) values('HISTORICO', ?, ?, ?, ?, ?)";
		//ResultSet rs = null;
		Connection con = null;
		PreparedStatement ps=null;
		
		
		try {
			
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql);
			ps.setString(1, usuario);
			ps.setTimestamp(2, fecha);
			ps.setInt(3, capa);
			ps.setString(5, regional);
			
			
			if (forma==1){
				ps.setString(4, c0 + "," + c1 + "," + c2+ "," +c3);
				
			}else {
				ps.setString(4, filtro);
				
			}
			
			
			ps.setQueryTimeout(3000);
			ps.executeUpdate();
			
			
			
			
			//return null;
	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		

		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	}
		 
		//return null;

	}

	// -----------------------------------------------------------------------------------
	
	
	
	
	/*
	 * // Con parámetros nombrados JOOQ public static CachedRowSet
	 * consulta_buscar_corte_01(String cnx, int capa, String buscar) { // Parámetros
	 * de ejemplo String param0 = no_injection(buscar);
	 * 
	 * // Crear el contexto JOOQ utilizando una configuración y una conexión
	 * ResultSet _rs = null; //ResultSet rs2 = null; //PreparedStatement ps2;
	 * CachedRowSet rs = null; Connection connection = null;
	 * 
	 * 
	 * //try (Connection connection =
	 * AdministradorDataSource_Sigma.getConnection(cnx)) { //esta es la forma try
	 * with resources, que cierra conexiones automaticamente al terminar el bloque
	 * try { connection = AdministradorDataSource_Sigma.getConnection(cnx);
	 * DSLContext context = DSL.using(connection, SQLDialect.POSTGRES); String
	 * consulta = null;
	 * 
	 * switch (capa) { case 3:// municipios consulta =
	 * "(SELECT '1990' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_1990 t1 where  cve_ent||cve_mun = substring({0},0,6) order by corte limit 1) "
	 * + " UNION " +
	 * "(SELECT '1995' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_1995 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
	 * + " UNION " +
	 * "(SELECT '2000' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2000 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
	 * + " UNION " +
	 * "(SELECT '2005' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2005 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
	 * + " UNION " +
	 * "(SELECT '2010' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2010 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
	 * + " UNION " +
	 * "(SELECT '2015' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2015 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
	 * + " UNION " +
	 * "(SELECT '2018' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2018 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
	 * + " UNION " +
	 * "(SELECT '2019' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2019 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
	 * + " UNION " +
	 * "(SELECT '2020' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2020 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
	 * + " UNION " +
	 * "(SELECT '2021' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2021 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
	 * + " UNION " +
	 * "(SELECT '2022' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2022 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
	 * + " UNION " +
	 * "(SELECT '2023' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2022 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
	 * + "ORDER BY corte asc";
	 * 
	 * // out.println(consulta); break; case 4:// agebs
	 * 
	 * consulta =
	 * "(SELECT '1990' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
	 * +
	 * " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_1990  "
	 * +
	 * " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_1990 ) t1 where "
	 * +
	 * " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)"
	 * + " union" +
	 * " (SELECT '1995' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
	 * +
	 * " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_1995  "
	 * +
	 * " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_1995 ) t1 where "
	 * +
	 * " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)"
	 * + " union" +
	 * " (SELECT '2000' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
	 * +
	 * " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2000  "
	 * +
	 * " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_2000 ) t1 where "
	 * +
	 * " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)"
	 * + " union" +
	 * " (SELECT '2005' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
	 * +
	 * " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2005  "
	 * +
	 * " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_2005 ) t1 where "
	 * +
	 * " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)"
	 * + " union" +
	 * " (SELECT '2010' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
	 * +
	 * " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2010  "
	 * +
	 * " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_2010 ) t1 where "
	 * +
	 * " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)"
	 * + " union" +
	 * " (SELECT '2015' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
	 * +
	 * " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2015  "
	 * +
	 * " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_2015 ) t1 where "
	 * +
	 * " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)"
	 * + " union" +
	 * " (SELECT '2018' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
	 * +
	 * " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2018  "
	 * +
	 * " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_2018 ) t1 where "
	 * +
	 * " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)"
	 * + " union" +
	 * " (SELECT '2019' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
	 * +
	 * " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2019  "
	 * +
	 * " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_2019 ) t1 where "
	 * +
	 * " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)"
	 * + " union" +
	 * " (SELECT '2020' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
	 * +
	 * " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2020  "
	 * +
	 * " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_2020 ) t1 where "
	 * +
	 * " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)"
	 * + " union" +
	 * " (SELECT '2021' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
	 * +
	 * " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2021  "
	 * +
	 * " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_2021 ) t1 where "
	 * +
	 * " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1) "
	 * + " union" +
	 * " (SELECT '2022' as corte,clave,substring(cve_ageb,1,3)||'-'||substring(cve_ageb,4,1),ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
	 * +
	 * " FROM (select  cve_ent||cve_mun||substring(cve_ageb,1,3)||'-'||substring(cve_ageb,4,1) as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2022  "
	 * +
	 * " union select cve_ent||cve_mun||substring(cve_ageb,1,3)||'-'||substring(cve_ageb,4,1) as clave,cve_ageb,'U' ,geom from historico.agebu_2022 ) t1 where "
	 * +
	 * " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)"
	 * + " union" +
	 * " (SELECT '2023' as corte,clave,substring(cve_ageb,1,3)||'-'||substring(cve_ageb,4,1),ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
	 * +
	 * " FROM (select  cve_ent||cve_mun||substring(cve_ageb,1,3)||'-'||substring(cve_ageb,4,1) as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2023  "
	 * +
	 * " union select cve_ent||cve_mun||substring(cve_ageb,1,3)||'-'||substring(cve_ageb,4,1) as clave,cve_ageb,'U' ,geom from historico.agebu_2023 ) t1 where "
	 * + " ORDER BY corte asc";
	 * 
	 * //out.println(consulta); break; case 7:// localidades
	 * 
	 * consulta =
	 * "(SELECT '1990' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text "
	 * +
	 * " else 'x'   end    as salida  FROM historico.lpr_1990 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union "
	 * +
	 * " SELECT '1990' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text "
	 * +
	 * " else 'x' end as salida   FROM historico.l_1990 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) ) "
	 * + " union " +
	 * " (SELECT '1995' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text "
	 * +
	 * " else 'x'   end    as salida  FROM historico.lpr_1995 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union "
	 * +
	 * " SELECT '1995' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text "
	 * +
	 * " else 'x' end as salida   FROM historico.l_1995 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )"
	 * + " union " +
	 * " (SELECT '2000' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text "
	 * +
	 * " else 'x'   end    as salida  FROM historico.lpr_2000 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
	 * +
	 * " SELECT '2000' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
	 * +
	 * " else 'x' end as salida   FROM historico.l_2000 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )  "
	 * + " union " +
	 * " (SELECT '2005' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
	 * +
	 * " else 'x'   end    as salida  FROM historico.lpr_2005 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
	 * +
	 * " SELECT '2005' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
	 * +
	 * " else 'x' end as salida   FROM historico.l_2005 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )  "
	 * + " union " +
	 * " (SELECT '2015' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
	 * +
	 * " else 'x'   end    as salida  FROM historico.lpr_2015 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
	 * +
	 * " SELECT '2015' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
	 * +
	 * " else 'x' end as salida   FROM historico.l_2015 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )  "
	 * + " union " +
	 * " (SELECT '2018' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
	 * +
	 * " else 'x'   end    as salida  FROM historico.lpr_2018 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
	 * +
	 * " SELECT '2018' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
	 * +
	 * " else 'x' end as salida   FROM historico.l_2018 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )  "
	 * + " union " +
	 * " (SELECT '2019' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
	 * +
	 * " else 'x'   end    as salida  FROM historico.lpr_2019 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
	 * +
	 * " SELECT '2019' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
	 * +
	 * " else 'x' end as salida   FROM historico.l_2019 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )    "
	 * + " union " +
	 * " (SELECT '2020' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
	 * +
	 * " else 'x'   end    as salida  FROM historico.lpr_2020 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
	 * +
	 * " SELECT '2020' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
	 * +
	 * " else 'x' end as salida   FROM historico.l_2020 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )    "
	 * + " union " +
	 * " (SELECT '2021' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
	 * +
	 * " else 'x'   end    as salida  FROM historico.lpr_2021 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
	 * +
	 * " SELECT '2021' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
	 * +
	 * " else 'x' end as salida   FROM historico.l_2021 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )    "
	 * + " union " +
	 * " (SELECT '2022' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,substring(cve_ageb,1,3)||'-'||substring(cve_ageb,4,1),'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
	 * +
	 * " else 'x'   end    as salida  FROM historico.lpr_2022 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
	 * +
	 * " SELECT '2022' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,substring(ambito,1,1),'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
	 * +
	 * " else 'x' end as salida   FROM historico.l_2022 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )    "
	 * + " union " +
	 * " (SELECT '2023' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,substring(cve_ageb,1,3)||'-'||substring(cve_ageb,4,1),'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
	 * +
	 * " else 'x'   end    as salida  FROM historico.lpr_2023 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
	 * +
	 * " SELECT '2023' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,substring(ambito,1,1),'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
	 * +
	 * " else 'x' end as salida   FROM historico.l_2023 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )    "
	 * + " ORDER BY corte asc,geo";
	 * 
	 * break; case 11:// manzanas int longitudNombre = buscar.length();
	 * 
	 * if (longitudNombre == 16) {
	 * 
	 * if (buscar.substring(13, 16).equals("800")) { consulta =
	 * " (SELECT '2000' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2000 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
	 * + "  UNION  " +
	 * " (SELECT '2005' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2005 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
	 * + " UNION  " +
	 * " (SELECT '2010' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2010 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
	 * + " UNION  " +
	 * " (SELECT '2015' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2015 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
	 * + "  UNION  " +
	 * " (SELECT '2018' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2018 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
	 * + "  UNION  " +
	 * " (SELECT '2019' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2019 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
	 * + "  UNION  " +
	 * " (SELECT '2020' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2020 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
	 * + "  UNION  " +
	 * " (SELECT '2021' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2021 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
	 * + "  UNION " +
	 * " (SELECT '2022' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2022 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
	 * + "  UNION " +
	 * " (SELECT '2023' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2023 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
	 * + " ORDER BY corte asc"; } else { consulta =
	 * "(SELECT '1990' as corte,cve_ent||cve_mun||cve_loc as clave,'000' as cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_1990 t1 where  cvegeo =  substring({0},0,10) order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '1995' as corte,cve_ent||cve_mun||cve_loc as clave,'000' as cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_1995 t1 where  cvegeo =  substring({0},0,10) order by corte limit 1)"
	 * + " UNION " +
	 * " (SELECT '2000' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2000 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '2005' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2005 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '2010' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2010 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + " UNION " +
	 * " (SELECT '2015' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2015 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '2018' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2018 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '2019' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2019 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '2020' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2020 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '2021' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2021 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '2022' as corte,cvegeo as clave,cve_mza,substring(ambito,1,1) as ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2022 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '2023' as corte,cvegeo as clave,cve_mza,substring(ambito,1,1) as ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2023 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + " ORDER BY corte asc";
	 * 
	 * 
	 * } } else { consulta =
	 * "(SELECT '1990' as corte,cve_ent||cve_mun||cve_loc as clave,'000' as cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_1990 t1 where  cvegeo =  substring({0},0,10) order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '1995' as corte,cve_ent||cve_mun||cve_loc as clave,'000' as cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_1995 t1 where  cvegeo =  substring({0},0,10) order by corte limit 1)"
	 * + " UNION " +
	 * " (SELECT '2000' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2000 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '2005' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2005 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '2010' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2010 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + " UNION " +
	 * " (SELECT '2015' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2015 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '2018' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2018 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '2019' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2019 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '2020' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2020 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '2021' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2021 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '2022' as corte,cvegeo as clave,cve_mza,substring(ambito,1,1) as ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2022 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + "  UNION " +
	 * " (SELECT '2023' as corte,cvegeo as clave,cve_mza,substring(ambito,1,1) as ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2023 t1 where  cvegeo =  {0} order by corte limit 1)"
	 * + " ORDER BY corte asc"; } break; }
	 * 
	 * // Obtener los resultados Result<Record> result = context.fetch(consulta,
	 * param("0", param0)); // param("1", param2)); _rs = result.intoResultSet(); //
	 * Cerrar los recursos // resultSet.close(); // statement.close();
	 * 
	 * 
	 * rs = RowSetProvider.newFactory().createCachedRowSet(); rs.populate(_rs);
	 * return rs;
	 * 
	 * 
	 * } catch (SQLException e) { e.printStackTrace(); } finally {if (connection !=
	 * null) { try {connection .close();} catch (SQLException e) {
	 * e.printStackTrace();}}; if (_rs != null) {try {_rs.close();} catch
	 * (SQLException e) {e.printStackTrace(); }};}
	 * 
	 * 
	 * return rs; }
	 * 
	 * //
	 * -----------------------------------------------------------------------------
	 * ------
	 */	
	
	
	// Sin la libreria JOOQ
	public static CachedRowSet consulta_buscar_corte_01(String cnx, int capa, String buscar) {
		// Parámetros de ejemplo
		String param0 = no_injection(buscar);

		ResultSet _rs = null;
		PreparedStatement ps;
		CachedRowSet rs = null;
		Connection connection = null;
		
		
		//try (Connection connection = AdministradorDataSource_Sigma.getConnection(cnx)) { //esta es la forma try with resources, que cierra conexiones automaticamente al terminar el bloque 
		try {	
			connection = AdministradorDataSource_Sigma.getConnection(cnx);
		//DSLContext context = DSL.using(connection, SQLDialect.POSTGRES);
			String consulta = null;

			switch (capa) {
			case 3:// municipios
				consulta = "(SELECT '1990' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_1990 t1 where  cve_ent||cve_mun = substring({0},0,6) order by corte limit 1) "
						+ " UNION "
						+ "(SELECT '1995' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_1995 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
						+ " UNION "
						+ "(SELECT '2000' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2000 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
						+ " UNION "
						+ "(SELECT '2005' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2005 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
						+ " UNION "
						+ "(SELECT '2010' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2010 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
						+ " UNION "
						+ "(SELECT '2015' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2015 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
						+ " UNION "
						+ "(SELECT '2018' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2018 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
						+ " UNION "
						+ "(SELECT '2019' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2019 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
						+ " UNION "
						+ "(SELECT '2020' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2020 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
						+ " UNION "
						+ "(SELECT '2021' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2021 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
						+ " UNION "
						+ "(SELECT '2022' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2022 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
						+ " UNION "
						+ "(SELECT '2023' as corte,cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.municipio_2022 t1 where  cve_ent||cve_mun =  substring({0},0,6) order by corte limit 1)"
						+ "ORDER BY corte asc";

				// out.println(consulta);
				break;
			case 4:// agebs

				consulta = "(SELECT '1990' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
						+ " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_1990  "
						+ " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_1990 ) t1 where "
						+ " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)" + " union"
						+ " (SELECT '1995' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
						+ " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_1995  "
						+ " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_1995 ) t1 where "
						+ " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)" + " union"
						+ " (SELECT '2000' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
						+ " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2000  "
						+ " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_2000 ) t1 where "
						+ " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)" + " union"
						+ " (SELECT '2005' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
						+ " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2005  "
						+ " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_2005 ) t1 where "
						+ " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)" + " union"
						+ " (SELECT '2010' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
						+ " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2010  "
						+ " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_2010 ) t1 where "
						+ " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)" + " union"
						+ " (SELECT '2015' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
						+ " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2015  "
						+ " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_2015 ) t1 where "
						+ " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)" + " union"
						+ " (SELECT '2018' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
						+ " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2018  "
						+ " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_2018 ) t1 where "
						+ " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)" + " union"
						+ " (SELECT '2019' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
						+ " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2019  "
						+ " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_2019 ) t1 where "
						+ " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)" + " union"
						+ " (SELECT '2020' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
						+ " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2020  "
						+ " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_2020 ) t1 where "
						+ " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)" + " union"
						+ " (SELECT '2021' as corte,clave,cve_ageb,ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
						+ " FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2021  "
						+ " union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_2021 ) t1 where "
						+ " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1) " + " union"
						+ " (SELECT '2022' as corte,clave,substring(cve_ageb,1,3)||'-'||substring(cve_ageb,4,1),ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
						+ " FROM (select  cve_ent||cve_mun||substring(cve_ageb,1,3)||'-'||substring(cve_ageb,4,1) as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2022  "
						+ " union select cve_ent||cve_mun||substring(cve_ageb,1,3)||'-'||substring(cve_ageb,4,1) as clave,cve_ageb,'U' ,geom from historico.agebu_2022 ) t1 where "
						+ " replace(clave,'-','') like substring({0},1,9) order by ambito,clave limit 1)" + " union"
						+ " (SELECT '2023' as corte,clave,substring(cve_ageb,1,3)||'-'||substring(cve_ageb,4,1),ambito ,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida"
						+ " FROM (select  cve_ent||cve_mun||substring(cve_ageb,1,3)||'-'||substring(cve_ageb,4,1) as clave,cve_ageb,'R' as ambito,geom from historico.ageb_2023  "
						+ " union select cve_ent||cve_mun||substring(cve_ageb,1,3)||'-'||substring(cve_ageb,4,1) as clave,cve_ageb,'U' ,geom from historico.agebu_2023 ) t1 where "
						+ " ORDER BY corte asc";

//out.println(consulta);
				break;
			case 7:// localidadess

				consulta = "(SELECT '1990' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text "
						+ " else 'x'   end    as salida  FROM historico.lpr_1990 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union "
						+ " SELECT '1990' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text "
						+ " else 'x' end as salida   FROM historico.l_1990 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) ) "
						+ " union "
						+ " (SELECT '1995' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text "
						+ " else 'x'   end    as salida  FROM historico.lpr_1995 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union "
						+ " SELECT '1995' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text "
						+ " else 'x' end as salida   FROM historico.l_1995 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )"
						+ " union "
						+ " (SELECT '2000' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text "
						+ " else 'x'   end    as salida  FROM historico.lpr_2000 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
						+ " SELECT '2000' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
						+ " else 'x' end as salida   FROM historico.l_2000 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )  "
						+ " union "
						+ " (SELECT '2005' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
						+ " else 'x'   end    as salida  FROM historico.lpr_2005 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
						+ " SELECT '2005' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
						+ " else 'x' end as salida   FROM historico.l_2005 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )  "
						+ " union "
						+ " (SELECT '2015' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
						+ " else 'x'   end    as salida  FROM historico.lpr_2015 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
						+ " SELECT '2015' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
						+ " else 'x' end as salida   FROM historico.l_2015 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )  "
						+ " union "
						+ " (SELECT '2018' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
						+ " else 'x'   end    as salida  FROM historico.lpr_2018 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
						+ " SELECT '2018' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
						+ " else 'x' end as salida   FROM historico.l_2018 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )  "
						+ " union "
						+ " (SELECT '2019' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
						+ " else 'x'   end    as salida  FROM historico.lpr_2019 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
						+ " SELECT '2019' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
						+ " else 'x' end as salida   FROM historico.l_2019 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )    "
						+ " union "
						+ " (SELECT '2020' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
						+ " else 'x'   end    as salida  FROM historico.lpr_2020 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
						+ " SELECT '2020' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
						+ " else 'x' end as salida   FROM historico.l_2020 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )    "
						+ " union "
						+ " (SELECT '2021' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,cve_ageb,'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
						+ " else 'x'   end    as salida  FROM historico.lpr_2021 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
						+ " SELECT '2021' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
						+ " else 'x' end as salida   FROM historico.l_2021 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )    "
						+ " union "
						+ " (SELECT '2022' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,substring(cve_ageb,1,3)||'-'||substring(cve_ageb,4,1),'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
						+ " else 'x'   end    as salida  FROM historico.lpr_2022 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
						+ " SELECT '2022' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,substring(ambito,1,1),'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
						+ " else 'x' end as salida   FROM historico.l_2022 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )    "
						+ " union "
						+ " (SELECT '2023' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,ambito,substring(cve_ageb,1,3)||'-'||substring(cve_ageb,4,1),'PUNTO' as geo,   case    when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
						+ " else 'x'   end    as salida  FROM historico.lpr_2023 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) union  "
						+ " SELECT '2023' as corte,cve_ent||cve_mun||cve_loc as clave,nom_loc,substring(ambito,1,1),'0000' as cve_ageb , 'POLIGONO' as geo, case when geom is not null THEN box2d(ST_Transform(geom,900913))::text  "
						+ " else 'x' end as salida   FROM historico.l_2023 t1 where  cve_ent||cve_mun||cve_loc like substring({0},1,9) )    "
						+ " ORDER BY corte asc,geo";

				break;
			case 11:// manzanas
				int longitudNombre = buscar.length();

				if (longitudNombre == 16) {

					if (buscar.substring(13, 16).equals("800")) {
						consulta = " (SELECT '2000' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2000 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
								+ "  UNION  "
								+ " (SELECT '2005' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2005 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
								+ " UNION  "
								+ " (SELECT '2010' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2010 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
								+ " UNION  "
								+ " (SELECT '2015' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2015 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
								+ "  UNION  "
								+ " (SELECT '2018' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2018 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
								+ "  UNION  "
								+ " (SELECT '2019' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2019 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
								+ "  UNION  "
								+ " (SELECT '2020' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2020 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
								+ "  UNION  "
								+ " (SELECT '2021' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2021 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
								+ "  UNION "
								+ " (SELECT '2022' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2022 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
								+ "  UNION "
								+ " (SELECT '2023' as corte,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.caserio_2023 t1 where  cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza =  {0} order by corte limit 1) "
								+ " ORDER BY corte asc";
					} else {
						consulta = "(SELECT '1990' as corte,cve_ent||cve_mun||cve_loc as clave,'000' as cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_1990 t1 where  cvegeo =  substring({0},0,10) order by corte limit 1)"
								+ "  UNION "
								+ " (SELECT '1995' as corte,cve_ent||cve_mun||cve_loc as clave,'000' as cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_1995 t1 where  cvegeo =  substring({0},0,10) order by corte limit 1)"
								+ " UNION "
								+ " (SELECT '2000' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2000 t1 where  cvegeo =  {0} order by corte limit 1)"
								+ "  UNION "
								+ " (SELECT '2005' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2005 t1 where  cvegeo =  {0} order by corte limit 1)"
								+ "  UNION "
								+ " (SELECT '2010' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2010 t1 where  cvegeo =  {0} order by corte limit 1)"
								+ " UNION "
								+ " (SELECT '2015' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2015 t1 where  cvegeo =  {0} order by corte limit 1)"
								+ "  UNION "
								+ " (SELECT '2018' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2018 t1 where  cvegeo =  {0} order by corte limit 1)"
								+ "  UNION "
								+ " (SELECT '2019' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2019 t1 where  cvegeo =  {0} order by corte limit 1)"
								+ "  UNION "
								+ " (SELECT '2020' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2020 t1 where  cvegeo =  {0} order by corte limit 1)"
								+ "  UNION "
								+ " (SELECT '2021' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2021 t1 where  cvegeo =  {0} order by corte limit 1)"
								+ "  UNION "
								+ " (SELECT '2022' as corte,cvegeo as clave,cve_mza,substring(ambito,1,1) as ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2022 t1 where  cvegeo =  {0} order by corte limit 1)"
								+ "  UNION "
								+ " (SELECT '2023' as corte,cvegeo as clave,cve_mza,substring(ambito,1,1) as ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2023 t1 where  cvegeo =  {0} order by corte limit 1)"
								+ " ORDER BY corte asc";
						
						
					}
				} else {
					consulta = "(SELECT '1990' as corte,cve_ent||cve_mun||cve_loc as clave,'000' as cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_1990 t1 where  cvegeo =  substring({0},0,10) order by corte limit 1)"
							+ "  UNION "
							+ " (SELECT '1995' as corte,cve_ent||cve_mun||cve_loc as clave,'000' as cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_1995 t1 where  cvegeo =  substring({0},0,10) order by corte limit 1)"
							+ " UNION "
							+ " (SELECT '2000' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2000 t1 where  cvegeo =  {0} order by corte limit 1)"
							+ "  UNION "
							+ " (SELECT '2005' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2005 t1 where  cvegeo =  {0} order by corte limit 1)"
							+ "  UNION "
							+ " (SELECT '2010' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2010 t1 where  cvegeo =  {0} order by corte limit 1)"
							+ " UNION "
							+ " (SELECT '2015' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2015 t1 where  cvegeo =  {0} order by corte limit 1)"
							+ "  UNION "
							+ " (SELECT '2018' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2018 t1 where  cvegeo =  {0} order by corte limit 1)"
							+ "  UNION "
							+ " (SELECT '2019' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2019 t1 where  cvegeo =  {0} order by corte limit 1)"
							+ "  UNION "
							+ " (SELECT '2020' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2020 t1 where  cvegeo =  {0} order by corte limit 1)"
							+ "  UNION "
							+ " (SELECT '2021' as corte,cvegeo as clave,cve_mza,ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2021 t1 where  cvegeo =  {0} order by corte limit 1)"
							+ "  UNION "
							+ " (SELECT '2022' as corte,cvegeo as clave,cve_mza,substring(ambito,1,1) as ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2022 t1 where  cvegeo =  {0} order by corte limit 1)"
							+ "  UNION "
							+ " (SELECT '2023' as corte,cvegeo as clave,cve_mza,substring(ambito,1,1) as ambito,case when geom is not null THEN box2d(ST_Transform(geom,900913))::text else 'x' end as salida FROM historico.manzana_2023 t1 where  cvegeo =  {0} order by corte limit 1)"
							+ " ORDER BY corte asc";
				}
				break;
			}

			// Obtener los resultados
			consulta = consulta.replace("{0}", "'" + param0 + "'");
			ps = connection.prepareStatement(consulta);
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			   rs = RowSetProvider.newFactory().createCachedRowSet();
			   rs.populate(_rs);
			return rs;
						
		
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (connection != null) {	try {connection .close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		
		
		return rs;
	}

	// -----------------------------------------------------------------------------------

	
	
	
	
	
	/*
	 * 
	 * // Con parámetros nombrados JOOQ public static CachedRowSet
	 * consulta_buscar_01(String cnx, int capa, int tipo, int corte, String where1,
	 * String where2, String buscar, String limit) { // Parámetros de ejemplo String
	 * param0 = no_injection(Integer.toString(corte)); String param1 =
	 * no_injection(where1); String param2 = no_injection("^" + buscar); String
	 * param3 = no_injection(limit); String param4 = no_injection(where2); String
	 * param5 = no_injection(buscar);
	 * 
	 * 
	 * // Crear el contexto JOOQ utilizando una configuración y una conexión
	 * ResultSet _rs = null; //ResultSet rs2 = null; //PreparedStatement ps2;
	 * CachedRowSet rs = null; Connection connection = null;
	 * 
	 * //try (Connection connection =
	 * AdministradorDataSource_Sigma.getConnection(cnx)) { try { connection =
	 * AdministradorDataSource_Sigma.getConnection(cnx); DSLContext context =
	 * DSL.using(connection, SQLDialect.POSTGRES); String consulta = null;
	 * 
	 * switch(capa){ case 3: //municipios if (tipo==0){
	 * consulta="SELECT cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,3857))::text else 'x' end as salida FROM historico.municipio_{0} t1 where {1} cve_ent||cve_mun  ~* '{2}' order by cve_ent||cve_mun {3}"
	 * ;
	 * 
	 * 
	 * }else{
	 * consulta="select cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,3857))::text else 'x' end as salida FROM historico.municipio_{0} t1 where {1} upper(a_sinacentos(nom_mun))  ~* '{5}' order by cve_ent||cve_mun {3}"
	 * ;
	 * 
	 * } break; case 4: //agebs if (tipo==0){
	 * consulta="SELECT clave,cve_ageb,case when geom is not null THEN box2d(ST_Transform(geom,3857))::text else 'x' end as salida,ambito FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_{0} {4} union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_{0} {4}) t1 where replace(clave,'-','')  ~* '{2}' order by ambito,clave {3}"
	 * ;
	 * 
	 * 
	 * }else{
	 * consulta="SELECT clave,cve_ageb,case when geom is not null THEN box2d(ST_Transform(geom,3857))::text else 'x' end as salida,ambito FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_{0} {4} union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_{0} {4}) t1 where upper(a_sinacentos(replace(cve_ageb,'-','')))  ~* '{5}'  order by ambito,clave {3}"
	 * ;
	 * 
	 * 
	 * 
	 * } break; case 7: //rurales --lo modifique para que buscque tanto urbanas como
	 * rurales y poligonos rurales if (tipo==0){
	 * 
	 * consulta = "(SELECT cve_ent||cve_mun||cve_loc as clave,nom_loc," + "case" +
	 * " when geom is not null THEN box2d(ST_Transform(geom,3857))::text " +
	 * " else 'x' " + "end " + "as salida,ambito,cve_ageb,'PUNTO' as geo " +
	 * "FROM historico.lpr_{0} t1 where {1} cve_ent||cve_mun||cve_loc  ~* '{2}' " +
	 * "union " +
	 * "SELECT cve_ent||cve_mun||cve_loc as clave,nom_loc,case when geom is not null THEN box2d(ST_Transform(geom,3857))::text else 'x' end as salida,ambito,'0000' as cve_ageb , 'POLIGONO' as geo "
	 * +
	 * "FROM historico.l_{0} t1 where {1} cve_ent||cve_mun||cve_loc  ~* '{2}' ) order by clave {3}"
	 * ;
	 * 
	 * 
	 * 
	 * 
	 * }else{
	 * 
	 * consulta = "( SELECT cve_ent||cve_mun||cve_loc as clave,nom_loc," + "case" +
	 * " when geom is not null THEN box2d(ST_Transform(geom,3857))::text " +
	 * " else 'x' " + "end " + "as salida,ambito,cve_ageb , 'PUNTO' as geo " +
	 * "FROM historico.lpr_{0} t1 where {1} upper(a_sinacentos(nom_loc))  ~* '{5}' "
	 * + "union " +
	 * "SELECT cve_ent||cve_mun||cve_loc as clave,nom_loc,case when geom is not null THEN box2d(ST_Transform(geom,3857))::text else 'x' end as salida,ambito,'0000' as cve_ageb, 'POLIGONO' as geo "
	 * +
	 * "FROM historico.l_{0} t1 where ambito='U' and {1} upper(a_sinacentos(nom_loc))  ~* '{5}' ) order by clave {3}"
	 * ;
	 * 
	 * 
	 * } break; case 11: //manzanas
	 * consulta="select * from ( SELECT cve_ent||' '||cve_mun||' '||cve_loc||' '||cve_ageb as cvegeo,cve_mza,box2d(ST_Transform(st_union(geom),3857))::text as salida,ambito as ambito from historico.caserio_{0} where {1}  cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza  ~* '{2}' group by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,ambito union  SELECT cve_ent||' '||cve_mun||' '||cve_loc||' '||cve_ageb as cvegeo,cve_mza,case when geom is not null THEN box2d(ST_Transform(geom,3857))::text else 'x' end as salida,ambito from historico.manzana_{0} where  {1}  cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza  ~* '{2}' ) tt   order by cvegeo,cve_mza {3}"
	 * ;
	 * 
	 * 
	 * 
	 * break; }
	 * 
	 * 
	 * String consu= consulta; consu = consu.replace("{0}", param0); consu =
	 * consu.replace("{1}", param1); consu = consu.replace("{2}", param2); consu =
	 * consu.replace("{3}", param3); consu = consu.replace("{4}", param4); consu =
	 * consu.replace("{5}", param5); //System.out.print(consulta);
	 * 
	 * // Obtener los resultados //Result<Record> result = context.fetch(consulta,
	 * param("0", param0),param("1", param1),param("2", param2),param("3",
	 * param3),param("4", param4),param("5", param5)); //ResultQuery<Record> q =
	 * context.resultQuery(consulta, val(param0), val(param1), val(param2),
	 * val(param3), val(param4), val(param5)); //ResultQuery<Record> q =
	 * context.resultQuery(consulta, param("0", param0), param("1", param1),
	 * param("2", param2), param("3", param3), param("4", param4), param("5",
	 * param5)); //Result<Record> result = context.fetch(q);
	 * 
	 * Result<Record> result = context.fetch(consu); _rs = result.intoResultSet();
	 * 
	 * // Cerrar los recursos // resultSet.close(); // statement.close();
	 * 
	 * rs = RowSetProvider.newFactory().createCachedRowSet(); rs.populate(_rs);
	 * return rs;
	 * 
	 * 
	 * } catch (SQLException e) { e.printStackTrace(); }
	 * 
	 * finally {if (connection != null) { try {connection .close();} catch
	 * (SQLException e) { e.printStackTrace();}}; if (_rs != null) {try
	 * {_rs.close();} catch (SQLException e) {e.printStackTrace(); }};} return rs; }
	 * 
	 * 
	 */	
	
	// -----------------------------------------------------------------------------------
	
	

	
	
	public static CachedRowSet consulta_buscar_01(String cnx, int capa, int tipo, int corte, String where1, String where2, String buscar, String limit) {
		// Parámetros de ejemplo
		String param0 = no_injection(Integer.toString(corte));
		String param1 = no_injection(where1);
		String param2 = no_injection("^" + buscar); 
		String param3 = no_injection(limit);
		String param4 = no_injection(where2);
		String param5 = no_injection(buscar); 
		
		
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		PreparedStatement ps;
		CachedRowSet rs = null;
		Connection connection = null;
		
		//try (Connection connection = AdministradorDataSource_Sigma.getConnection(cnx)) {
		try {	
			connection = AdministradorDataSource_Sigma.getConnection(cnx);
			String consulta = null;
			
	
	switch(capa){
	   case 3:		//municipios
		if (tipo==0){
			consulta="SELECT cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,3857))::text else 'x' end as salida FROM historico.municipio_{0} t1 where {1} cve_ent||cve_mun  ~* '{2}' order by cve_ent||cve_mun {3}";

			
		}else{
			consulta="select cve_ent||cve_mun as clave,nom_mun,case when geom is not null THEN box2d(ST_Transform(geom,3857))::text else 'x' end as salida FROM historico.municipio_{0} t1 where {1} upper(a_sinacentos(nom_mun))  ~* '{5}' order by cve_ent||cve_mun {3}";
			
		}
		break;
	case 4:		//agebs
		if (tipo==0){
			consulta="SELECT clave,cve_ageb,case when geom is not null THEN box2d(ST_Transform(geom,3857))::text else 'x' end as salida,ambito FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_{0} {4} union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_{0} {4}) t1 where replace(clave,'-','')  ~* '{2}' order by ambito,clave {3}";
			
		
		}else{
			  consulta="SELECT clave,cve_ageb,case when geom is not null THEN box2d(ST_Transform(geom,3857))::text else 'x' end as salida,ambito FROM (select  cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'R' as ambito,geom from historico.ageb_{0} {4} union select cve_ent||cve_mun||cve_ageb as clave,cve_ageb,'U' ,geom from historico.agebu_{0} {4}) t1 where upper(a_sinacentos(replace(cve_ageb,'-','')))  ~* '{5}'  order by ambito,clave {3}";
			  
			  
			  
		}
		break;
	case 7:		//rurales   --lo modifique para que buscque tanto urbanas como rurales y poligonos rurales
		if (tipo==0){
	            
				consulta = "(SELECT cve_ent||cve_mun||cve_loc as clave,nom_loc,"
	            + "case"
	            + " when geom is not null THEN box2d(ST_Transform(geom,3857))::text "
	            + " else 'x' "
	            + "end "
	            + "as salida,ambito,cve_ageb,'PUNTO' as geo "
	            + "FROM historico.lpr_{0} t1 where {1} cve_ent||cve_mun||cve_loc  ~* '{2}' "
	            + "union "
	            + "SELECT cve_ent||cve_mun||cve_loc as clave,nom_loc,case when geom is not null THEN box2d(ST_Transform(geom,3857))::text else 'x' end as salida,ambito,'0000' as cve_ageb , 'POLIGONO' as geo "
	            + "FROM historico.l_{0} t1 where {1} cve_ent||cve_mun||cve_loc  ~* '{2}' ) order by clave {3}";   


		
	            
		}else{
	            
	            consulta = "( SELECT cve_ent||cve_mun||cve_loc as clave,nom_loc,"
	            + "case"
	            + " when geom is not null THEN box2d(ST_Transform(geom,3857))::text "
	            + " else 'x' "
	            + "end "
	            + "as salida,ambito,cve_ageb , 'PUNTO' as geo "
	            + "FROM historico.lpr_{0} t1 where {1} upper(a_sinacentos(nom_loc))  ~* '{5}' "
	             + "union "
	            + "SELECT cve_ent||cve_mun||cve_loc as clave,nom_loc,case when geom is not null THEN box2d(ST_Transform(geom,3857))::text else 'x' end as salida,ambito,'0000' as cve_ageb, 'POLIGONO' as geo "
	            + "FROM historico.l_{0} t1 where ambito='U' and {1} upper(a_sinacentos(nom_loc))  ~* '{5}' ) order by clave {3}";	
	            
	            
		}
		break;
	case 11:   //manzanas
	    consulta="select * from ( SELECT cve_ent||' '||cve_mun||' '||cve_loc||' '||cve_ageb as cvegeo,cve_mza,box2d(ST_Transform(st_union(geom),3857))::text as salida,ambito as ambito from historico.caserio_{0} where {1}  cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza  ~* '{2}' group by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,ambito union  SELECT cve_ent||' '||cve_mun||' '||cve_loc||' '||cve_ageb as cvegeo,cve_mza,case when geom is not null THEN box2d(ST_Transform(geom,3857))::text else 'x' end as salida,ambito from historico.manzana_{0} where  {1}  cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza  ~* '{2}' ) tt   order by cvegeo,cve_mza {3}";
		  
		

	break;
	  }
	
	
	String consu= consulta;
	consu = consu.replace("{0}", param0);
	consu = consu.replace("{1}", param1);
	consu = consu.replace("{2}", param2);
	consu = consu.replace("{3}", param3);
	consu = consu.replace("{4}", param4);
	consu = consu.replace("{5}", param5);
	//System.out.print(consulta);

		
	ps = connection.prepareStatement(consu);
	ps.setQueryTimeout(3000);
	_rs = ps.executeQuery();
	   rs = RowSetProvider.newFactory().createCachedRowSet();
	   rs.populate(_rs);
	return rs;
	
		
		} catch (SQLException e) {
		e.printStackTrace();
	}
		
		finally {if (connection != null) {	try {connection .close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
	return rs;
}

	

	// -----------------------------------------------------------------------------------
	
	
	public static CachedRowSet consulta_consultar_01(String cnx) {
	    String sql = "select * from historico.historico_totales";
	    ResultSet _rs = null;
	    //PreparedStatement ps2;
	    CachedRowSet rs = null;
	    Connection con = null;
	    PreparedStatement ps = null;
	    //try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
	        try {
	        con = AdministradorDataSource_Sigma.getConnection(cnx);
	    	ps = con.prepareStatement(sql); 
	        ps.setQueryTimeout(3000);
	        _rs = ps.executeQuery();
			/*
			 * // Obtener el PID de la conexión y cerrarlo String pid = null; ps2 =
			 * con.prepareStatement("SELECT pg_backend_pid()"); ps2.setQueryTimeout(3000);
			 * rs2 = ps2.executeQuery(); if (rs2.next()) { pid = rs2.getString(1); } //
			 * Asignar el PID a una variable en la respuesta
			 * //response.setHeader("X-Connection-PID", pid); ps2 =
			 * con.prepareStatement("SELECT pg_terminate_backend(" + pid + ");");
			 * ps2.setQueryTimeout(3000); rs2 = ps2.executeQuery(); if (rs2 != null) { try {
			 * rs2.close(); } catch (SQLException e) { e.printStackTrace(); } }
			 */
	        
	        rs = RowSetProvider.newFactory().createCachedRowSet();
	        rs.populate(_rs);
	        
	        
	        return rs;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	        finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	
	// -----------------------------------------------------------------------------------
	
	public static CachedRowSet consulta_consultar_02(String cnx, String token) {

		String sql ="select * from historico.historico_totales_entidad where cve_ent=?";
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		String txt = null; 
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql);
			txt= no_injection(token);
			ps.setString(1, txt );
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);		
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;

	}
	
	
	// -----------------------------------------------------------------------------------
	
	public static CachedRowSet consulta_consultar_03(String cnx) {

		String sql = "select * from historico.historico_superficie_entidad order by cve_ent";
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;

	}
	
	
	// -----------------------------------------------------------------------------------
	
	public static CachedRowSet consulta_consultar_04(String cnx) {

		String sql = "select * from historico.historico_superficie_lr_entidad order by cve_ent";
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;

	}
	
	// -----------------------------------------------------------------------------------
	
	public static CachedRowSet consulta_consultar_05(String cnx) {

		String sql = "select * from historico.historico_superficie_lu_l_entidad order by cve_ent";
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null; 
				
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
			
			
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;

	}
	
	
	// -----------------------------------------------------------------------------------
	
	public static CachedRowSet consulta_consultar_06(String cnx) {

		String sql = "select * from historico.historico_superficie_pe_entidad order by cve_ent";
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
					
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;

	}
	
	// -----------------------------------------------------------------------------------
	
	public static CachedRowSet consulta_consultar_07(String cnx) {

		String sql = "select * from historico.historico_superficie_ageb_entidad order by cve_ent";
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql);
			
		
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
			
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;

	}
	
	
	// -----------------------------------------------------------------------------------
	
	public static CachedRowSet consulta_consultar_08(String cnx) {

		String sql = "select * from historico.historico_superficie_agebu_entidad order by cve_ent";
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;

	}
	
	
	//agregar las de obtfedg.jsp y obtpassdg.jsp

	public static CachedRowSet consulta_obtfedg_01(String cnx, String filtro, String x , String y) {
		
		
		String sql = "select fecha from a_digitalglobe where " + filtro + "st_intersects(geom,ST_SetSRID(ST_Point("+x+","+y+"),4326)) order by fecha desc limit 1";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		//String valor = null;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql);
		
			//ps.setString(1, pass);
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			//if (rs.next()) {
			//    valor = rs.getObject(1).toString();
			//}
			
			/*
			 * String pid = null; ps2 = con.prepareStatement("SELECT pg_backend_pid()");
			 * ps2.setQueryTimeout(3000); rs2 = ps2.executeQuery(); if (rs2.next()) { pid =
			 * rs2.getObject(1).toString(); }
			 * 
			 * ps2 = con.prepareStatement("SELECT pg_terminate_backend(" + pid + ");");
			 * ps2.setQueryTimeout(3000); rs2 = ps2.executeQuery(); if (rs2 != null) {
			 * rs2.close(); }
			 */
			
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
			
		        return rs;
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	
	
	

	public static CachedRowSet consulta_obtpassdg_01(String cnx, String x ) {
	    String sql = "select a_convierte_escapehtml(passdg) from usuarios where userdg ='"+x+"'";
	    ResultSet _rs = null;
	    //ResultSet rs2 = null;
	    //PreparedStatement ps2;
	    //String valor = null;
	    CachedRowSet rs = null;
	    Connection con = null;
	    PreparedStatement ps = null;

	    //try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
	    try {  
	    	con = AdministradorDataSource_Sigma.getConnection(cnx);
	    	ps = con.prepareStatement(sql);
	        ps.setQueryTimeout(3000);
	        _rs = ps.executeQuery();
	        //if (rs.next()) {
	        //    valor = rs.getObject(1).toString();
	        //}
	        
			/*
			 * String pid = null; ps2 = con.prepareStatement("SELECT pg_backend_pid()");
			 * ps2.setQueryTimeout(3000); rs2 = ps2.executeQuery(); if (rs2.next()) { pid =
			 * rs2.getObject(1).toString(); }
			 * 
			 * ps2 = con.prepareStatement("SELECT pg_terminate_backend(" + pid + ");");
			 * ps2.setQueryTimeout(3000); rs2 = ps2.executeQuery(); if (rs2 != null) {
			 * rs2.close(); }
			 */	        
	        
	        rs = RowSetProvider.newFactory().createCachedRowSet();
		    rs.populate(_rs);	
	        return rs;
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } 
	    finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
	    return rs;
	}
	
	
	// ARCHIVO agregacgo.jsp
	public static CachedRowSet consulta_agregacgo_01(String cnx, String id) {

		String consulta = "select a_agrega_cgo(?)";
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta);
			
			ps.setString(1, id);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	// ARCHIVO anotaciones.jsp
	public static CachedRowSet consulta_anotaciones_01(String cnx, String pass) {

		String consultapas = "select nivel,edicion,id,regid,nombre,cons from usuarios where md5(password) = ?";
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consultapas);
			
			ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_anotaciones_02(String cnx, String filfe1, String filfe2, String fec2, String loc, String filniv) {

		String consulta; 
		
		if (filfe2==null){filfe2=fec2;}
		    
		consulta="select gid,cve_ent,descripcion,fact,ST_AsText(the_geom) from cat_marks where fact between ? and ? "+filniv+" order by gid";

		if(loc != null && !loc.isEmpty()){
		      consulta="select gid,cve_ent,descripcion,fact,ST_AsText(the_geom) from cat_marks where descripcion ilike ?  "+filniv+" order by gid";
		}

		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta);
			
			if(loc != null && !loc.isEmpty()){
				ps.setString(1, loc + "%");
			} else {
				ps.setString(1, filfe1);
				ps.setString(2, filfe2);
			}
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_anotaciones_03(String cnx,  String filfe1, String filfe2, String fec2, String loc, String filniv, int numRecordsPerPage, int startIndex) {

		String consulta; 
		
		if (filfe2==null){filfe2=fec2;}
		    
		consulta="select gid,cve_ent,descripcion,fact,ST_AsText(the_geom) from cat_marks where fact between ? and ? "+filniv+" order by gid limit ? offset ?";

		if(loc != null && !loc.isEmpty()){
		      consulta="select gid,cve_ent,descripcion,fact,ST_AsText(the_geom) from cat_marks where descripcion ilike ?  "+filniv+" order by gid limit ? offset ?";
		}
	    
	    ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta);
			
			if(loc != null && !loc.isEmpty()){
				ps.setString(1, loc + "%");
				ps.setInt(2, numRecordsPerPage);
				ps.setInt(3, startIndex);
			} else {
				ps.setString(1, filfe1);
				ps.setString(2, filfe2);
				ps.setInt(3, numRecordsPerPage);
				ps.setInt(4, startIndex);
			}
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	// ARCHIVO asigna_loc_baja 
	//mia
	public static CachedRowSet consulta_asigna_loc_baja_01(String cnx, String gid) {

		String  consulta = "update cat_manz set vienede=(select substring(figura,1,1)||gid from mcc_poblacion.cat_manz_modcar where gid=?) "
				+ "where cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza =(select cvegeo  from mcc_poblacion.cat_manz_modcar where gid=?) and ban='3'";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta);
			
			ps.setString(1, gid);
			ps.setString(2, gid);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	// claude
	/*public static int consulta_asigna_loc_baja_01(String cnx, String gid) {

		String consulta = "update cat_manz set vienede=(select substring(figura,1,1)||gid from mcc_poblacion.cat_manz_modcar where gid=?) "
				+ "where cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza =(select cvegeo  from mcc_poblacion.cat_manz_modcar where gid=?) and ban='3'";

	    Connection con = null;
	    PreparedStatement ps = null;

	    try {
	        con = AdministradorDataSource_Sigma.getConnection(cnx);
	        ps = con.prepareStatement(consulta);

	        ps.setString(1, gid);   
	        ps.setString(2, gid);  

	        ps.setQueryTimeout(3000);
	        return ps.executeUpdate();  

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        if (ps  != null) try { ps.close();  } catch (SQLException e) { e.printStackTrace(); }
	        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
	    }
	    return 0;
	}*/
	
	// ARCHIVO asigna_loc_cd 
	// deberia de checarse porque es UPDATE
	public static CachedRowSet consulta_asigna_loc_cd_01(String cnx, String gid) {

		String consulta = "update mcc_poblacion.cat_manz_modcar set proc=1,fresp=current_date,cgo_def='L' where gid=? and "
				+ "cve_ent||cve_mun||cve_loc not in (select distinct cve_ent||cve_mun||cve_loc from cat_manz where ban not in "
				+ "('X','3','1','5','6','Y','E','D','H','G','M','I','N','O','K','R','T','C') union (select distinct cve_ent||cve_mun||cve_loc from cat_cd)) "
				+ "RETURNING gid";

		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta);
			
			ps.setString(1, gid);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} 
		catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	// ARCHIVO avance_act_2021
	public static CachedRowSet consulta_avance_act_2021_01(String cnx) {

		String consulta1 = "select cve_ent,0,0,0,0,0,"
				//+"(select count(*) from respaldo_z_digmz t2 where (cve_baja!='BCUU' or cve_baja is null) and t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as pre1, "
				//+"(select count(*) from respaldo_z_digpe t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as pre2, "
				//+"(select count(*) from respaldo_z_digmp t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as pre3, "
				//+"(select count(*) from rep_avance.mz_predig_sin_act t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as faltantes, "  //pendientes de clave
				//+"(select count(*) from rep_avance.mz_predig t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as enact, "  //pendientes de clave
				+"(select count(*) from act_cu.bcu_bd_manzana t2 where t2.cve_ent=t1.cve_ent and proc=1 ) as modcar1, "
				+"(select count(*) from act_cu.bcu_bd_manzana t2 where t2.cve_ent=t1.cve_ent and proc=999 ) as modcar2, "
				+"(select count(*) from act_cu.bcu_bd_manzana t2 where t2.cve_ent=t1.cve_ent and proc in (2,3,4)) as modcar3, "
				+"(select count(*) from act_cu.bcu_bd_manzana t2 where t2.cve_ent=t1.cve_ent and proc=1) as ensigma, "
				+"count(*) as total, 0,"
				//+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and proc=999 and f_registro<='"+filfe2+"' "+filentrega2+") as modcar34, "
				//+"(select count(*) from (select * from respaldo_te_mza union select * from respaldo_te_mza_cd) t2 where (t1.cve_ent=t2.ent_ant or t1.cve_ent=t2.ent_act) and (ent_ant||mun_ant||loc_ant in (select cve from a_cob_ce19_definitivo) or ent_act||mun_act||loc_act in (select cve from a_cob_ce19_definitivo)) and fact<='"+filfe2+"' "+filentrega+") as te_cober,  "
				+"max(vocs) as ValOC,"
				+"max(vregs) as ValREG, "
				+"(select count(*) from respaldo_te_mza_coord where substring(clave,1,2)=t1.cve_ent) as forma,"
				+"max(cod4) as cod4, "
				+"max(cod2) as cod2, "
				+"max(cod1) as cod1, "
				+"max(cod3) as cod3 "
				+"from "
				+"(select cve_ent,count(case when voc='S' then voc END) OVER (PARTITION BY cve_ent) as vocS,"
				//+"count(case when voc='R' then voc END) OVER (PARTITION BY cve_ent) as vocR,"
				//+"count(case when voc='N' then voc END) OVER (PARTITION BY cve_ent) as vocN,"
				+"count(case when vreg='S' then vreg END) OVER (PARTITION BY cve_ent) as vregS,"
				+"count(case when vreg='R' then vreg END) OVER (PARTITION BY cve_ent) as vregR, "
				+"count(case when t2.cgo_act in ('4','B','A') then t2.cgo_act END) OVER (PARTITION BY cve_ent) as cod4, "
				+"count(case when t2.cgo_act='2' then t2.cgo_act END) OVER (PARTITION BY cve_ent) as cod2, "
				+"count(case when t2.cgo_act='1' then t2.cgo_act END) OVER (PARTITION BY cve_ent) as cod1, "
				+"count(case when t2.cgo_act in ('3','C','K','R','T') then t2.cgo_act END) OVER (PARTITION BY cve_ent) as cod3 "
				//+",count(case when vreg='N' then vreg END) OVER (PARTITION BY cve_ent) as vregN "
				+" from cat_ent t1 left join (select * from (select * from respaldo_te_mza union select * from respaldo_te_mza_cd) t5) t2 on t1.cve_ent=t2.ent_ant or t1.cve_ent=t2.ent_Act "
				+" where status=1  order by t1.cve_ent) t1 group by cve_ent";

		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_act_2021_02(String cnx, String remoteAddr) {

		String consulta9 = "insert into usuarios_reporte values (DEFAULT, '"+remoteAddr+"',current_timestamp,'Avance_Actualiza')";

		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta9);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_act_2022_CA_ant_01(String cnx) {

		String consulta1 = "select * from proyectos.avance_act order by cve_ent";

		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_act_2022_CA_ant_02(String cnx, String remote) {

		String consulta9 = "insert into usuarios_reporte values (DEFAULT, '"+remote+"',current_timestamp,'Avance_Act');";

		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta9);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_act_2022_CA_01(String cnx) {

		String consulta1 = "select cve_ent,"; 
		consulta1 += "(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and proc=1 ) as modcar1,";
		consulta1 += "(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and proc=2 ) as modcar2, ";
		consulta1 += "count(*) as total, 0,";
		consulta1 += "max(vocs) as ValOC,";
		consulta1 += "max(vregs) as ValREG, ";
		consulta1 += "(select count(*) from respaldo_te_mza_coord where substring(clave,1,2)=t1.cve_ent) as forma,";
		consulta1 += "max(cod4) as cod4, ";
		consulta1 += "max(cod2) as cod2,";
		consulta1 += "max(cod1) as cod1, ";
		consulta1 += "max(cod3) as cod3 ";
		consulta1 += "from ";
		consulta1 += "(select cve_ent,count(case when voc='S' then voc END) OVER (PARTITION BY cve_ent) as vocS,";
		consulta1 += "count(case when vreg='S' then vreg END) OVER (PARTITION BY cve_ent) as vregS,";
		consulta1 += "count(case when vreg='R' then vreg END) OVER (PARTITION BY cve_ent) as vregR, ";
		consulta1 += "count(case when t2.cgo_act in ('4','B','A') then t2.cgo_act END) OVER (PARTITION BY cve_ent) as cod4, ";
		consulta1 += "count(case when t2.cgo_act='2' then t2.cgo_act END) OVER (PARTITION BY cve_ent) as cod2, ";
		consulta1 += "count(case when t2.cgo_act='1' then t2.cgo_act END) OVER (PARTITION BY cve_ent) as cod1,";
		consulta1 += "count(case when t2.cgo_act in ('3','C','K','R','T') then t2.cgo_act END) OVER (PARTITION BY cve_ent) as cod3 ";
		consulta1 += "from cat_ent t1 left join (select * from (select * from respaldo_te_mza union select * from respaldo_te_mza_cd) t5) t2 on t1.cve_ent=t2.ent_ant or t1.cve_ent=t2.ent_Act ";
		consulta1 += "where status=1  order by t1.cve_ent) t1 group by cve_ent";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	
	public static CachedRowSet consulta_avance_act_2022_CA_02(String cnx, String remote) {

		String consulta9 = "insert into usuarios_reporte values (DEFAULT, '"+remote+"',current_timestamp,'Avance_Act');";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta9);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_act_2022_01(String cnx) {

		String consulta1 = "select * from proyectos.avance_act order by cve_ent";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_act_2022_02(String cnx, String remote) {

		String consulta9 = "insert into usuarios_reporte values (DEFAULT, '"+remote+"',current_timestamp,'Avance_Act');";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta9);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_act_2024_ant_01(String cnx) {

		String consulta1 = "select * from proyectos.avance_act order by cve_ent";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_act_2024_ant_02(String cnx, String remote) {

		String consulta9 = "insert into usuarios_reporte values (DEFAULT, '"+remote+"',current_timestamp,'Avance_Act');";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta9);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_act_2024_01(String cnx) {

		String consulta1 = "select * from proyectos.avance_act order by cve_ent";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_act_2024_02(String cnx, String remote) {

		String consulta9 = "insert into usuarios_reporte values (DEFAULT, '"+remote+"',current_timestamp,'Avance_Act');";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta9);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_act_mg_01(String cnx, String fechapre) {

		String consulta1 = "select cve_ent,"
				+"(select count(*) from respaldo_z_digmz t2 where (cve_baja!='BCUU' or cve_baja is null) and t2.cve_ent=t1.cve_ent "+fechapre+") as pre1, "
				+"(select count(*) from respaldo_z_digpe t2 where t2.cve_ent=t1.cve_ent "+fechapre+") as pre2, "
				+"(select count(*) from respaldo_z_digmp t2 where t2.cve_ent=t1.cve_ent "+fechapre+") as pre3, "
				+"(select count(*)||','||sum(predig::integer)||','||sum(mza_pre::integer)||','||sum(actual::integer)||','||sum(mza_act::integer)||','||sum(mza_dig::integer) from rep_actualizacion t2 where t2.digital='0' and t2.cve_ent=t1.cve_ent) as c1, "
				+"(select loc_bufer||','||loc_total||','||loc_por_30||','||loc_pre||','||loc_act||','||loc_dig from rep_loc_no_mza t2 where t2.cve_ent=t1.cve_ent) as c2, "
				+"count(*) as total, "
				+"max(vregs) as ValREG,"
				+"max(vocs) as ValOC,"
				+"(select count(*) from respaldo_te_mza_coord where substring(clave,1,2)=t1.cve_ent) as forma , "
				+"(select count(*) from cat_loc_val_arcgis t2 where clave in (select distinct cve_ent||cve_mun||cve_loc from cat_manz where ambito='R') and t2.cve_ent=t1.cve_ent) as plan1 "
				+"from "
				+"(select cve_ent,count(case when voc='S' then voc END) OVER (PARTITION BY cve_ent) as vocS,"
				+"count(case when vreg='S' then vreg END) OVER (PARTITION BY cve_ent) as vregS,"
				+"count(case when vreg='R' then vreg END) OVER (PARTITION BY cve_ent) as vregR "
				+"from cat_ent t1 left join (select * from (select * from respaldo_te_mza union select * from respaldo_te_mza_cd) t5) t2 on t1.cve_ent=t2.ent_ant or t1.cve_ent=t2.ent_Act "
				+"where status=1  order by t1.cve_ent) t1 group by cve_ent";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_act_pob_01(String cnx, String filfe2, String filentrega2, String filentrega) {

		String consulta1 = "select cve_ent,0,0,0,0,0,"
				//+"(select count(*) from respaldo_z_digmz t2 where (cve_baja!='BCUU' or cve_baja is null) and t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as pre1, "
				//+"(select count(*) from respaldo_z_digpe t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as pre2, "
				//+"(select count(*) from respaldo_z_digmp t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as pre3, "
				//+"(select count(*) from rep_avance.mz_predig_sin_act t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as faltantes, "  //pendientes de clave
				//+"(select count(*) from rep_avance.mz_predig t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as enact, "  //pendientes de clave
				+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and figura='CENSOR' and (status=1 or status=0 or status=7) and f_registro<='"+filfe2+"' "+filentrega2+") as modcar1, "
				+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and figura='CENSOR' and status=2 and f_registro<='"+filfe2+"' "+filentrega2+") as modcar2, "
				+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and figura='CENSOR' and status in (3,4,5,6,8,9) and f_registro<='"+filfe2+"' "+filentrega2+") as modcar3, "
				+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and (fresp<='"+filfe2+"' "+filentrega2+" and(proc!=0) or status=0 or cgo='46')) as ensigma, "
				+"count(*) as total, "
				+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and figura='TCAR' and f_registro<='"+filfe2+"' "+filentrega2+") as modcar34, "
				//+"(select count(*) from (select * from respaldo_te_mza union select * from respaldo_te_mza_cd) t2 where (t1.cve_ent=t2.ent_ant or t1.cve_ent=t2.ent_act) and (ent_ant||mun_ant||loc_ant in (select cve from a_cob_ce19_definitivo) or ent_act||mun_act||loc_act in (select cve from a_cob_ce19_definitivo)) and fact<='"+filfe2+"' "+filentrega+") as te_cober,  "
				+"max(vocs) as ValOC,"
				+"max(vregs) as ValREG, "
				+"(select count(*) from respaldo_te_mza_coord where substring(clave,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as forma,  "
				+"(select count(*) from rep_avance.mz_descargadas_arcgis t2 where substring(t2.cve_geo,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as desc, 0,"
				//+"(select count(*) from rep_avance.mz_descargadas_arcgis t2 where substring(t2.cve_geo,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as desc_mcc, "
				+"(select count(*) from rep_avance.mz_descargadas_arcgis t2 where substring(t2.cve_geo,1,2)=t1.cve_ent and substring(cve_geo,1,5) in (select distinct cve_geo from rep_avance.mz_arcgis where substring(cve_geo,1,2)=t1.cve_ent) and fact<='"+filfe2+"' "+filentrega+") as mz_val "


				/*

				+"max(vocs) as ValOC,"
				+"max(vocr) as RetOC,"
				//+"max(vocn) as SinOC,"
				+"max(vregs) as ValREG,"
				+"max(vregr) as RetREG,"
				//+"max(vregn) as SinREG,"
				+"(select count(*) from rep_avance.mz_arcgis_av t2 where substring(cve_geo,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as arcgis,  "
				+"(select count(*) from respaldo_te_mza_coord where substring(clave,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as forma,  "
				+"(select count(*) from respaldo_manz_bcu t2 where t2.cve_ent=t1.cve_ent and proc = 1 and fresp<='"+filfe2+"' "+filentrega1+") as bcu1,"
				+"(select count(*) from respaldo_manz_bcu t2 where t2.cve_ent=t1.cve_ent and proc > 1 and fresp<='"+filfe2+"' "+filentrega1+") as bcu2,"
				+"(select count(*) from respaldo_manz_bcu t2 where t2.cve_ent=t1.cve_ent and (proc = 0 or fresp>'"+filfe2+"' ) ) as bcu3, "
				+"(select count(*) from cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and proc=0 and f_registro<='"+filfe2+"' "+filentrega2+") as modcar, "
				+"(select count(*) from rep_avance.mz_predig_faltanencampo t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as falcampo, "
				+"(select count(*) from rep_avance.mz_avance t2 where substring(t2.cve_geo,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as avance, "
				+"(select count(*) from rep_avance.mz_nuevas t2 where substring(t2.cve_geo,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as news " */
				+"from "
				+"(select cve_ent,count(case when voc='S' then voc END) OVER (PARTITION BY cve_ent) as vocS,"
				//+"count(case when voc='R' then voc END) OVER (PARTITION BY cve_ent) as vocR,"
				//+"count(case when voc='N' then voc END) OVER (PARTITION BY cve_ent) as vocN,"
				+"count(case when vreg='S' then vreg END) OVER (PARTITION BY cve_ent) as vregS,"
				+"count(case when vreg='R' then vreg END) OVER (PARTITION BY cve_ent) as vregR "
				//+",count(case when vreg='N' then vreg END) OVER (PARTITION BY cve_ent) as vregN "
				+"from cat_ent t1 left join (select * from (select * from respaldo_te_mza union select * from respaldo_te_mza_cd) t5 where fact<='"+filfe2+"' "+filentrega+") t2 on t1.cve_ent=t2.ent_ant or t1.cve_ent=t2.ent_Act "
				+"where status=1  order by t1.cve_ent) t1 group by cve_ent";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_act_01(String cnx, String filfe2, String filentrega2, String filentrega, String fechapre) {

		String consulta1 = "select cve_ent,"
				+"(select count(*) from respaldo_z_digmz t2 where (cve_baja!='BCUU' or cve_baja is null) and t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as pre1, "
				+"(select count(*) from respaldo_z_digpe t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as pre2, "
				+"(select count(*) from respaldo_z_digmp t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as pre3, "
				+"(select count(*) from rep_avance.mz_predig_sin_act t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as faltantes, "  //pendientes de clave
				+"(select count(*) from rep_avance.mz_predig t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as enact, "  //pendientes de clave
				+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and (status=1 or status=4) and f_registro<='"+filfe2+"' "+filentrega2+") as modcar1, "
				+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and status=2 and figura='CENSOR' and f_registro<='"+filfe2+"' "+filentrega2+") as modcar2, "
				+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and status=3 and f_registro<='"+filfe2+"' "+filentrega2+") as modcar3, "
				+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and proc>0 and fresp<='"+filfe2+"' "+filentrega2+") as modcar3, "
				+"count(*) as total, "
				+"(select count(*) from (select * from respaldo_te_mza union select * from respaldo_te_mza_cd) t2 where (t1.cve_ent=t2.ent_ant or t1.cve_ent=t2.ent_act) and (ent_ant||mun_ant||loc_ant in (select cve from a_cob_ce19_definitivo) or ent_act||mun_act||loc_act in (select cve from a_cob_ce19_definitivo)) and fact<='"+filfe2+"' "+filentrega+") as te_cober,  "
				+"max(vocs) as ValOC,"
				+"max(vregs) as ValREG,"
				+"(select count(*) from respaldo_te_mza_coord where substring(clave,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as forma,  "
				+"(select count(*) from rep_avance.mz_descargadas_arcgis t2 where substring(t2.cve_geo,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as desc, "
				+"(select count(*) from rep_avance.mz_descargadas_arcgis t2, manz_afect_todas t3 where cve_geo=cvegeo_def and substring(t2.cve_geo,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as desc_mcc, "
				+"(select count(*) from rep_avance.mz_descargadas_arcgis t2, manz_afect_todas t3 where cve_geo=cvegeo_def and substring(t2.cve_geo,1,2)=t1.cve_ent and substring(cve_geo,1,5) in (select distinct cve_geo from rep_avance.mz_arcgis where substring(cve_geo,1,2)=t1.cve_ent) and fact<='"+filfe2+"' "+filentrega+") as mz_val "


				/*

				+"max(vocs) as ValOC,"
				+"max(vocr) as RetOC,"
				//+"max(vocn) as SinOC,"
				+"max(vregs) as ValREG,"
				+"max(vregr) as RetREG,"
				//+"max(vregn) as SinREG,"
				+"(select count(*) from rep_avance.mz_arcgis_av t2 where substring(cve_geo,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as arcgis,  "
				+"(select count(*) from respaldo_te_mza_coord where substring(clave,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as forma,  "
				+"(select count(*) from respaldo_manz_bcu t2 where t2.cve_ent=t1.cve_ent and proc = 1 and fresp<='"+filfe2+"' "+filentrega1+") as bcu1,"
				+"(select count(*) from respaldo_manz_bcu t2 where t2.cve_ent=t1.cve_ent and proc > 1 and fresp<='"+filfe2+"' "+filentrega1+") as bcu2,"
				+"(select count(*) from respaldo_manz_bcu t2 where t2.cve_ent=t1.cve_ent and (proc = 0 or fresp>'"+filfe2+"' ) ) as bcu3, "
				+"(select count(*) from cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and proc=0 and f_registro<='"+filfe2+"' "+filentrega2+") as modcar, "
				+"(select count(*) from rep_avance.mz_predig_faltanencampo t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as falcampo, "
				+"(select count(*) from rep_avance.mz_avance t2 where substring(t2.cve_geo,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as avance, "
				+"(select count(*) from rep_avance.mz_nuevas t2 where substring(t2.cve_geo,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as news " */
				+"from "
				+"(select cve_ent,count(case when voc='S' then voc END) OVER (PARTITION BY cve_ent) as vocS,"
				//+"count(case when voc='R' then voc END) OVER (PARTITION BY cve_ent) as vocR,"
				//+"count(case when voc='N' then voc END) OVER (PARTITION BY cve_ent) as vocN,"
				+"count(case when vreg='S' then vreg END) OVER (PARTITION BY cve_ent) as vregS,"
				+"count(case when vreg='R' then vreg END) OVER (PARTITION BY cve_ent) as vregR "
				//+",count(case when vreg='N' then vreg END) OVER (PARTITION BY cve_ent) as vregN "
				+"from cat_ent t1 left join (select * from (select * from respaldo_te_mza union select * from respaldo_te_mza_cd) t5 where fact<='"+filfe2+"' "+filentrega+") t2 on t1.cve_ent=t2.ent_ant or t1.cve_ent=t2.ent_Act "
				+"where status=1  order by t1.cve_ent) t1 group by cve_ent";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	
	public static CachedRowSet consulta_avance_inv_01(String cnx, String pass) {

		String consulta = "select cons from usuarios where nivel=3 and upper(password) = upper('"+pass+"')";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_inv_02(String cnx) {

		String consulta1 = "select inv_us, nombre, count(*) from v_cat_mza_inv t1, usuarios t2 where cons=inv_us and inv_us is not null ";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_inv_03(String cnx) {

		String consulta1 = "select inv_us, nombre, count(*) from v_cat_mza_inv t1, usuarios t2 where cons=inv_us and inv_us is not null  and nivel=3 group by inv_us,nombre order by nombre ";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}

	public static CachedRowSet consulta_avance_inv_04(String cnx, String cons) {

		String consulta1 = "select inv_us, (select nombre from usuarios where cons=inv_us), count(*) from v_cat_mza_inv where inv_us="+cons+" group by inv_us order by inv_us,nombre";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_precarta20_carta(String cnx, String edo) {

		String consulta1 = "select t1.carta ,";
		consulta1+="(select count(*) from z_digmz_respaldo where cve_ent ='"+edo+"' and st_intersects(z_digmz_respaldo.geom,t1.geom)) as cm , ";
		consulta1+="(select count(*) from z_digf_respaldo where cve_ent ='"+edo+"' and st_intersects(z_digf_respaldo.the_geom,t1.geom)) as cf , ";
		consulta1+="(select count(*) from z_digf_respaldo   where nfr_noroe is null and cve_ent ='"+edo+"' and st_intersects(z_digf_respaldo.the_geom,t1.geom)) as nf, ";
		consulta1+="(select count(*) from z_dige_respaldo where cve_ent ='"+edo+"' and st_intersects(z_dige_respaldo.the_geom,t1.geom)) as ce,";
		consulta1+="st_Area(t1.geom) as area1,";
		consulta1+="((sum(CASE WHEN 1=1        THEN st_area(st_transform(t2.geom,32800)) else 0 END))) as area2,";
		consulta1+="((sum(CASE WHEN sup in (1,2) THEN st_area(st_transform(t2.geom,32800)) else 0 END))) as vreg,";
		consulta1+="((sum(CASE WHEN voc in (1,2) THEN st_area(st_transform(t2.geom,32800)) else 0 END))) as voc,  ";
		consulta1+="max(fact) as fact,pasada ";
		consulta1+="from cat_cartas20 t1 left join a_rep_cardig t2 ";
		consulta1+="on t1.carta=substring(t2.carta,1,7) where st_intersects((select the_geom from cat_ent where cve_ent='"+edo+"'),t1.geom)   ";
		consulta1+="group by t1.carta,t1.geom,t1.pasada order by t1.carta";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_precarta20_01(String cnx) {

		String consulta1 ="select cve_ent";
		consulta1+=",case when c20 is null then 0 else c20 end as c20 ";
		consulta1+=",case when cm is null then 0 else cm end as cm ";
		consulta1+=",case when cf is null then 0 else cf end as cf ";
		consulta1+=",case when nf is null then 0 else nf end as nf ";
		consulta1+=",case when ce is null then 0 else ce end as ce ";
		consulta1+=",area ";
		consulta1+=",case when arep is null then 0 else arep end as arep ";
		consulta1+=",case when areg is null then 0 else areg end as areg ";
		consulta1+=",case when aoc is null then 0 else aoc end as aoc ";
		consulta1+="from (select cve_ent ";
		consulta1+=",(select count(*) from cat_cartas20 where st_intersects(geom,t1.the_geom)) as c20 ";
		consulta1+=",(select count(*) from z_digmz_respaldo where cve_ent =t1.cve_ent) as cm ";
		consulta1+=",(select count(*) from z_digf_respaldo where cve_ent =t1.cve_ent) as cf ";
		consulta1+=",(select count(*) from z_digf_respaldo where nfr_noroe is null and cve_ent =t1.cve_ent) as nf ";
		consulta1+=",(select count(*) from z_dige_respaldo where cve_ent =t1.cve_ent) as ce ";
		consulta1+=",st_Area(the_geom) as area ";
		consulta1+=",(select sum(st_area(st_transform(geom,32800))) from a_rep_cardig where cve_ent=t1.cve_ent group by the_geom) as arep ";
		consulta1+=",(select sum(st_area(st_transform(geom,32800))) from a_rep_cardig where sup in (1,2) and cve_ent=t1.cve_ent group by the_geom) as areg ";
		consulta1+=",(select sum(st_area(st_transform(geom,32800))) from a_rep_cardig where voc in (1,2) and cve_ent=t1.cve_ent group by the_geom) as aoc  ";
		consulta1+="from cat_ent t1 where status=1 order by cve_ent ) c1 ";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_predig_01(String cnx) {

		String consulta1 = "select cve_ent,(select count(*) from respaldo_z_digmz where (cve_baja!='BCUU' or cve_baja is null) and cve_ent =t1.cve_ent) as cm, (select count(*) from respaldo_z_digpe where cve_ent =t1.cve_ent) as cf, (select count(*) from respaldo_z_digmp where cve_ent =t1.cve_ent) as ce from cat_ent t1 where status=1 ";

		// (select count(*) from cat_loc where status=1 and ambito='U' and cve_ent=t1.cve_ent) as locu, (select count(distinct(clave)) from cat_loc t3,a_rep_cardig t2 where status=1 and t3.cve_ent=t2.cve_ent and ambito='U' and t3.cve_ent=t1.cve_ent and t2.cve_ent=t1.cve_ent and the_geom_pu && st_transform(geom,32800)) as locu_rep, (select count(*) from cat_loc where status=1 and ambito='R' and the_geom_pr is not null and cve_ent=t1.cve_ent) as locr, (select count(distinct(clave)) from cat_loc t3,a_rep_cardig t2 where status=1 and t3.cve_ent=t2.cve_ent and ambito='R' and the_geom_pr is not null and t3.cve_ent=t1.cve_ent and t2.cve_ent=t1.cve_ent and the_geom_pr && st_transform(geom,32800)) as locr_rep from cat_ent t1 where status=1 ";
		//consulta1+= " and 1=0";

		consulta1+= " order by cve_ent";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_preedo_us_01(String cnx, String edo ) {

		String consulta1 = "select * from (select cons,nombre,correo,case when (select min(fact) from respaldo_z_digmz where us=cons)=null then (select min(fact) from respaldo_z_digmp where us=cons) else (select min(fact) from respaldo_z_digmz where us=cons) end as minf, case when (select max(fact) from respaldo_z_digmz where us=cons)=null then (select max(fact) from respaldo_z_digmp where us=cons) else (select max(fact) from respaldo_z_digmz where us=cons) end as maxf,  (select count(*) from respaldo_z_digmz where us=cons) as nf,  (select count(*) from respaldo_z_digpe where us=cons) as ne,  (select count(*) from respaldo_z_digmp where us=cons) as cartas  from usuarios  where id='"+edo+"' and nivel=1 group by cons,nombre,correo  order by cons ) c1 where nf>0 or ne>0 or cartas>0";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_preedo_01(String cnx, String edo) {

		String consulta1 = "select cve_ent, (select count(*) from respaldo_z_digmz where cve_ent ='"+edo+"') as cm, (select count(*) from z_digpe_respaldo where cve_ent ='"+edo+"') as cf,(select count(*) from z_digpe_respaldo where cve_ent ='"+edo+"') as ce, (select count(*) from cat_loc where status=1 and ambito='U' and cve_ent='"+edo+"') as locu, (select count(distinct(clave)) from cat_loc t3,a_rep_cardig t2 where status=1 and t3.cve_ent='"+edo+"' and t2.cve_ent='"+edo+"' and ambito='U' and t3.cve_ent='"+edo+"' and t1.cve_ent='"+edo+"' and t2.cve_ent='"+edo+"' and t1.cve_ent='"+edo+"' and the_geom_pu && st_transform(geom,32800)) as locu_rep, (select count(*) from cat_loc where status=1 and ambito='R' and the_geom_pr is not null and cve_ent='"+edo+"') as locr, (select count(distinct(clave)) from cat_loc t3,a_rep_cardig t2 where status=1 and t3.cve_ent='"+edo+"' and t2.cve_ent='"+edo+"' and ambito='R' and the_geom_pr is not null and t3.cve_ent='"+edo+"' and t1.cve_ent='"+edo+"' and t2.cve_ent='"+edo+"' and t1.cve_ent='"+edo+"' and the_geom_pr && st_transform(geom,32800)) as locr_rep, ST_XMax(st_transform(the_geom,3857)),ST_YMax(st_transform(the_geom,3857)),ST_XMin(st_transform(the_geom,3857)), ST_YMin(st_transform(the_geom,3857)),st_distance(ST_MakePoint(st_xmin(the_geom),st_ymin(the_geom)),ST_MakePoint(st_xmax(the_geom),st_ymin(the_geom))) as distx,  st_distance(ST_MakePoint(st_xmin(the_geom),st_ymin(the_geom)),ST_MakePoint(st_xmin(the_geom),st_ymax(the_geom))) as disty from (select cve_ent,ST_Envelope((ST_Dump(the_geom)).geom) as the_geom  from cat_ent where cve_ent='"+edo+"' and status=1 order by st_area(ST_Envelope((ST_Dump(the_geom)).geom)) desc limit 1) t1";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_valreg_01(String cnx, String reg) {

		String consulta1 = " select * from (select usre, (select nombre from usuarios where cons=usre),fvre,sum(count),(select regid from usuarios where cons=usre) as regi from (select usre,fvre,count(*) from respaldo_te_mza where usre is not null group by usre,fvre union all select usre,fvre,count(*) from respaldo_te_mza_coord where usre is not null group by usre,fvre union all select usre,fvre,count(*) from respaldo_te_mza_cd where usre is not null group by usre,fvre ) t2  group by usre,fvre order by usre,nombre,fvre ) tt where regi='"+reg+"'";

		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_valreg_02(String cnx, String remote) {

		String consulta9 = "insert into usuarios_reporte values (DEFAULT, '"+remote+"',current_timestamp,'Rep_val_TE');";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta9);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_valreg02_01(String cnx, String reg) {

		String consulta1 = " select * from (select usre, (select nombre from usuarios where cons=usre),fvre,sum(count),(select regid from usuarios where cons=usre) as regi from (select usre,fvre,count(*) from respaldo_te_mza where usre is not null group by usre,fvre union all select usre,fvre,count(*) from respaldo_te_mza_coord where usre is not null group by usre,fvre union all select usre,fvre,count(*) from respaldo_te_mza_cd where usre is not null group by usre,fvre ) t2  group by usre,fvre order by usre,nombre,fvre ) tt where regi='"+reg+"'";

		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta1);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_avance_valreg02_02(String cnx, String remote) {

		String consulta9 ="insert into usuarios_reporte values (DEFAULT, '"+remote+"',current_timestamp,'Rep_val_TE');";
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta9);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_borra_mark_01(String cnx, String gid) {

		String consulta="delete from cat_marks where gid="+gid;
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_buscar_01(String cnx, String buscar, String limit) {

		String consulta="SELECT cve_carta,nombre,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_cartas t1 where a_sinacentos(cve_carta) like '" + buscar + "%' order by cve_carta"+limit;
		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
	public static CachedRowSet consulta_buscar_02(String cnx, String buscar, String limit) {
		
		String consulta="select cve_carta,nombre,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_cartas t1 where upper(a_sinacentos(cve_carta)) like '%" + buscar + "%'  order by cve_carta"+limit;

		
		ResultSet _rs = null;
		//ResultSet rs2 = null;
		//PreparedStatement ps2;
		CachedRowSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		
		//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
		try {	
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(consulta);
			
			//ps.setString(1, pass);
			
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			 rs = RowSetProvider.newFactory().createCachedRowSet();
		     rs.populate(_rs);	
						
			return rs;
			// con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}
	
		public static CachedRowSet consulta_buscar_03(String cnx, String buscar, String limit, String where1) {
			
			String	consulta="SELECT clave,nom_ent,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_ent t1 where "+where1+" clave like '" + buscar + "%' and status=1 order by clave"+limit;
	
			
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_buscar_04(String cnx, String buscar, String limit, String where1) {
			
			String consulta="select clave,nom_ent,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_ent t1 where "+where1+" upper(a_sinacentos(nom_ent)) like '%" + buscar + "%'  and status=1 order by clave"+limit;

			
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_buscar_05(String cnx, String buscar, String limit, String where1) {
			
			String 	consulta="SELECT clave,nom_mun,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_mun t1 where "+where1+" clave like '" + buscar + "%' and status=1 order by clave"+limit;
			
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
public static CachedRowSet consulta_buscar_06(String cnx, String buscar, String limit, String where1) {
			
			String 	consulta="select clave,nom_mun,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_mun t1 where "+where1+" upper(a_sinacentos(nom_mun)) like '%" + buscar + "%'  and status=1 order by clave"+limit;

			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}

		public static CachedRowSet consulta_buscar_07(String cnx, String buscar, String limit, String where1, String where2) {
			
			String consulta="SELECT clave,cve_ageb,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida,ambito FROM (select clave,cve_ageb,ambito,the_geom from cat_ageb where "+where1+" status=1 union select clave,cve_ageb,ambito,the_geom from cat_agebu "+where2+") t1 where replace(clave,'-','') like '" + buscar + "%' order by ambito,clave"+limit;

			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_buscar_08(String cnx, String buscar, String limit, String where1, String where2) {
			
			String consulta="select clave,cve_ageb,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida,ambito FROM (select clave,cve_ageb,ambito,the_geom from cat_ageb where "+where1+" status=1 union select clave,cve_ageb,ambito,the_geom from cat_agebu "+where2+") t1 where upper(a_sinacentos(replace(cve_ageb,'-',''))) like '%" + buscar + "%'  order by ambito,clave"+limit;

			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_buscar_09(String cnx, String buscar, String limit, String where1) {
			
			String consulta="SELECT clave,nom_loc,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_loc t1 where "+where1+" clave like '" + buscar + "%' and status=1 order by clave"+limit;

			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_buscar_10(String cnx, String buscar, String limit, String where1) {
			
			String consulta="select clave,nom_loc,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_loc t1 where "+where1+" upper(a_sinacentos(nom_loc)) like '%" + buscar + "%' and status=1 order by clave"+limit;
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_buscar_11(String cnx, String buscar, String limit, String where1) {
			
			String 	consulta="SELECT clave,nom_loc,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_loc t1 where "+where1+" the_geom_pr NOT NULL and clave like '" + buscar + "%' and status=1 order by clave"+limit;

			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_buscar_12(String cnx, String buscar, String limit, String where1) {
			
			String consulta="select clave,nom_loc,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_loc t1 where "+where1+" the_geom_pr NOT NULL and upper(a_sinacentos(nom_loc)) like '%" + buscar + "%' and status=1 order by clave"+limit;

			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_buscar_13(String cnx, String buscar, String limit, String where1) {
			
			String consulta = "SELECT clave,nom_loc,"
		            + "case "
		            + "	when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text "
		            + " else 'x' "
		            + "end "
		            + "as salida,status,ambito,cve_ageb "
		            + "FROM cat_loc t1 where "+where1+" replace(clave,'-','') like '" + buscar + "%' order by clave"+limit;
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_buscar_14(String cnx, String buscar, String limit, String where1) {
			
			String consulta = "SELECT clave,nom_loc,"
		            + "case "
		            + "	when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text "
		            + " else 'x' "
		            + "end "
		            + "as salida,status,ambito,cve_ageb "
		            + "FROM cat_loc t1 where "+where1+" upper(a_sinacentos(nom_loc)) like '%" + buscar + "%' order by clave"+limit;
			
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_buscar_15(String cnx, String buscar, String limit, String where1) {
			
			String 	consulta="SELECT clave,nom_asen,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_asen t1 where "+where1+" the_geom is NOT NULL and clave like '" + buscar + "%' order by clave"+limit;

		
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_buscar_16(String cnx, String buscar, String limit, String where1) {
			
			String consulta="select clave,nom_asen,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_asen t1 where "+where1+" the_geom is NOT NULL and upper(a_sinacentos(nom_asen)) like '%" + buscar + "%' order by clave"+limit;

		
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_buscar_17(String cnx, String buscar, String limit, String where1) {
			
			String 	consulta="SELECT clave,nom_via,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_vial t1 where "+where1+" the_geom is NOT NULL and clave like '" + buscar + "%' order by clave"+limit;

		
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_buscar_18(String cnx, String buscar, String limit, String where1) {
			
			String consulta="select clave,nom_via,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_vial t1 where "+where1+" the_geom is NOT NULL and upper(a_sinacentos(nom_via)) like '%" + buscar + "%' order by clave"+limit;

		
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_buscar_19(String cnx, String buscar) {
			
			String   consulta="select id||' - '||cgo1||' - '||entidad as clave,nom_loc,box2d(ST_Transform(the_geom,3857))::text FROM a_bd_loc where entidad='"+buscar+"'";
		
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_buscar_20(String cnx, String buscar, String where1, String limit) {
			
			String  consulta="select * from ( SELECT cve_ent||' '||cve_mun||' '||cve_loc||' '||cve_ageb as cvegeo,cve_mza,box2d(ST_Transform(st_union(the_geom),3857))::text as salida,tipo as ambito from cat_cd where "+where1+"  cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza like '" + buscar + "%' group by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,tipo union  SELECT cve_ent||' '||cve_mun||' '||cve_loc||' '||cve_ageb as cvegeo,cve_mza,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida,ambito from cat_manz where ban!='X' and "+where1+"  cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza like '" + buscar + "%' ) tt   order by cvegeo,cve_mza "+limit;

			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_camfe_01(String cnx, String id, String val) {
			
			String consulta = "Update te_loc_coord set fact='"+val+"' where gid="+id;
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_campro_01(String cnx, String cgo, String id) {
			
			String consulta = "Update cat_manz_modcar set proc=0,cve_def=null,fresp=null where proc not in (0,1) and cgo='"+cgo+"' and gid="+id;
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_avance_valoc_01(String cnx, String pass) {

			String consulta = "select cons from usuarios where nivel=3 and upper(password) = upper('"+pass+"')";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_avance_valoc_02(String cnx) {

			String consulta1 = "select usoc, (select nombre from usuarios where cons=usoc),fvoc,sum(count) from (select usoc,fvoc,count(*) from respaldo_te_mza where usoc!=44 and usoc is not null group by usoc,fvoc union select usoc,fvoc,count(*) from respaldo_te_mza_coord where usoc!=44 and usoc is not null group by usoc,fvoc union select usoc,fvoc,count(*) from respaldo_te_mza_cd where usoc!=44 and usoc is not null group by usoc,fvoc ) t2 group by usoc,fvoc order by usoc,nombre,fvoc";

			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta1);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_avance_valoc_03(String cnx, String cons) {

	        String consulta1 = "select usoc, (select nombre from usuarios where cons=usoc),fvoc,sum(count) from (select usoc,fvoc,count(*) from respaldo_te_mza where usoc!=44 and usoc="+cons+" and usoc is not null group by usoc,fvoc union select usoc,fvoc,count(*) from respaldo_te_mza_coord where usoc!=44 and usoc="+cons+" and usoc is not null group by usoc,fvoc union select usoc,fvoc,count(*) from respaldo_te_mza_cd where usoc!=44 and usoc="+cons+" and usoc is not null group by usoc,fvoc ) t2 group by usoc,fvoc order by usoc,nombre,fvoc";

			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta1);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
	
		public static CachedRowSet consulta_cd_simplify_01(String cnx, String cve_ent, String cve_mun, String cve_loc, String tole, String us) {

			String consulta = "select _a_weed_cd('"+cve_ent+cve_mun+cve_loc+"',"+tole+","+us+")";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_chg_motivo_01(String cnx, String val, String gid) {

			String consulta = "Update te_mza_coord_fr set motivo="+val+" where oid="+gid;
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_chg_motivo_02(String cnx, String val, String gid) {

			String consulta = "Update te_mza set motivo="+val+" where oid="+gid;
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_dearcgis_01(String cnx, float c1, float c2, float c3, float c4) {

			String consulta = "select ST_AsText(ST_Transform(ST_GeomFromText('POINT("+c1+" "+c2+")',32800),3857)) as punto1,"
		              + "ST_AsText(ST_Transform(ST_GeomFromText('POINT("+c3+" "+c4+")',32800),3857)) as punto2";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_editman_01(String cnx, String pass) {

			 String  consultapass="select nivel,edicion,cons from usuarios where md5(password) = '"+pass+"'";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consultapass);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_editman_02(String cnx, String clave) {

			 String  consulta="select count(*) from shp_locr_coord where clave='"+clave+"'";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_editman_03(String cnx, String clave, String lon_dec, String lat_dec, int idus) {

			 String  consulta="select a_shploc_editman('"+clave+"','"+lon_dec+"','"+lat_dec+"','"+idus+"')";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_eliminaloc_01(String cnx, String c1, String c2, String c3, String c4, String lon, String lat) {

			String  consulta="SELECT latitud,longitud,clave,nom_loc,status,cgo_act,ambito FROM cat_loc where status=1  and " +
			          "st_intersects(the_geom,st_transform(ST_SetSRID(ST_MakeBox2D(ST_Point("+c1+", "+c2+"),ST_Point("+c3+" ,"+c4+")),4326),32800)) "+
					  "ORDER BY st_distance(the_geom,st_transform(GeomFromText('POINT("+lon+" "+lat+")',4326),32800)) ASC LIMIT 1";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_google2_01(String cnx, float c1, float c2, float c3, float c4) {

			String  consulta = "select ST_Distance(ST_Point("+c1+","+c2+"),ST_Point("+c3+","+c4+")) as dist, "
		               + "ST_AsText(st_centroid(ST_SetSRID(ST_MakeBox2D(ST_Point("+c1+","+c2+"),ST_Point("+c3+","+c4+")),4326))) as punto ";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_inconsistencias_01(String cnx, String ent) {
			String condicion=" where substring(cvegeo::text, 1, 2)='"+ent+"' ";
			String  consulta = "select * from val_mc_vs_manz_afect "+condicion+" order by cvegeo";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_inconsistencias_02(String cnx) {
			String condicion= " where (substring(cvegeo::text, 1, 2)='02' or substring(cvegeo::text, 1, 2)='03' or substring(cvegeo::text, 1, 2)='25' or substring(cvegeo::text, 1, 2)='26') ";
			String consulta = "select * from val_mc_vs_manz_afect "+condicion+" order by cvegeo";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_inconsistencias_03(String cnx) {
			String  condicion= " where (substring(cvegeo::text, 1, 2)='10' or substring(cvegeo::text, 1, 2)='08' or substring(cvegeo::text, 1, 2)='32') ";

			String consulta = "select * from val_mc_vs_manz_afect "+condicion+" order by cvegeo";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_inconsistencias_04(String cnx) {
			String condicion= " where (substring(cvegeo::text, 1, 2)='28' or substring(cvegeo::text, 1, 2)='05' or substring(cvegeo::text, 1, 2)='19') ";

			String consulta = "select * from val_mc_vs_manz_afect "+condicion+" order by cvegeo";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_inconsistencias_05(String cnx) {
			String condicion= " where (substring(cvegeo::text, 1, 2)='18' or substring(cvegeo::text, 1, 2)='16' or substring(cvegeo::text, 1, 2)='14' or substring(cvegeo::text, 1, 2)='06') ";

			String consulta = "select * from val_mc_vs_manz_afect "+condicion+" order by cvegeo";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_inconsistencias_06(String cnx) {
			String condicion= " where (substring(cvegeo::text, 1, 2)='11' or substring(cvegeo::text, 1, 2)='24' or substring(cvegeo::text, 1, 2)='22' or substring(cvegeo::text, 1, 2)='01') ";

			String consulta = "select * from val_mc_vs_manz_afect "+condicion+" order by cvegeo";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_inconsistencias_07(String cnx) {
			String condicion= " where (substring(cvegeo::text, 1, 2)='15' or substring(cvegeo::text, 1, 2)='17' or substring(cvegeo::text, 1, 2)='12') ";

			String consulta = "select * from val_mc_vs_manz_afect "+condicion+" order by cvegeo";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_inconsistencias_08(String cnx) {
			String condicion= " where (substring(cvegeo::text, 1, 2)='30' or substring(cvegeo::text, 1, 2)='29' or substring(cvegeo::text, 1, 2)='21' or substring(cvegeo::text, 1, 2)='13' or substring(cvegeo::text, 1, 2)='09') ";
			
			String consulta = "select * from val_mc_vs_manz_afect "+condicion+" order by cvegeo";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_inconsistencias_09(String cnx) {
			String condicion= " where (substring(cvegeo::text, 1, 2)='27' or substring(cvegeo::text, 1, 2)='20' or substring(cvegeo::text, 1, 2)='07') ";
			
			String consulta = "select * from val_mc_vs_manz_afect "+condicion+" order by cvegeo";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_inconsistencias_10(String cnx) {
			String condicion= " where (substring(cvegeo::text, 1, 2)='23' or substring(cvegeo::text, 1, 2)='31' or substring(cvegeo::text, 1, 2)='04') ";
			
			String consulta = "select * from val_mc_vs_manz_afect "+condicion+" order by cvegeo";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		public static CachedRowSet consulta_inconsistencias_11(String cnx, String edo) {
			String condicion=" where substring(cvegeo::text, 1, 2)='"+edo+"' ";	
			
			String consulta = "select * from val_mc_vs_manz_afect "+condicion+" order by cvegeo";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		//////////////// lista_error.jsp 
		public static CachedRowSet consulta_lista_error(String cnx, String sinlocons, String consulta, String consErr) {
			//consulta= " where cve_ent='"+ent+"' ";
			
			String consulta1 = "select cve_ent,  cve_mun ,  cve_loc ,  cve_ageb,  cve_mza,  resultado, fecha,st_x(ST_Transform(ST_PointOnSurface(st_makevalid(the_geom)),4326)),st_y(ST_Transform(ST_PointOnSurface(st_makevalid(the_geom)),4326)) from temp_mza_rev_errores "+consulta+sinlocons+consErr+" order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta1);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
		//// mod_casos_chgform.jsp
		public static CachedRowSet consulta_mod_casos_chgform(String cnx, String img, String proy, String us, String geom) {
			
			String consulta = "select m_casos_chgform('"+img+"','"+proy+"','"+us+"','"+geom+"')";
			ResultSet _rs = null;
			//ResultSet rs2 = null;
			//PreparedStatement ps2;
			CachedRowSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			
			//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
			try {	
				con = AdministradorDataSource_Sigma.getConnection(cnx);
				ps = con.prepareStatement(consulta);
				
				//ps.setString(1, pass);
				
				ps.setQueryTimeout(3000);
				_rs = ps.executeQuery();
				 rs = RowSetProvider.newFactory().createCachedRowSet();
			     rs.populate(_rs);	
							
				return rs;
				// con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
	//// mod_casos.jsp
			public static CachedRowSet consulta_mod_casos(String cnx, String cgo, String cve_ent, String cve_mun, String cve_loc, String cve_ageb, String img, String proy, String us, String geom) {
				
				String consulta = "select m_casos_especiales('"+cgo+"','"+cve_ent+"','"+cve_mun+"','"+cve_loc+"','"+cve_ageb+"','"+img+"','"+proy+"','"+us+"','"+geom+"')";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
		//// mod_casosCd.jsp
			public static CachedRowSet consulta_mod_casos_cd(String cnx, String cgo, String cve_ent, String cve_mun, String cve_loc, String cve_ageb, String cve_mza, String img, String proy, String us, String geom) {
				
				String consulta = "select m_casos_especialesCd('"+cgo+"','"+cve_ent+"','"+cve_mun+"','"+cve_loc+"','"+cve_ageb+"','"+cve_mza+"','"+img+"','"+proy+"','"+us+"','"+geom+"')";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
		// mod_casosJ
			public static CachedRowSet consulta_mod_casos_j_01(String cnx, String cgo, String cve_ent, String cve_mun, String cve_loc, String cve_ageb, String us) {
				
				String consulta = "select m_casos_especialesJ('"+cgo+"','"+cve_ent+"','"+cve_mun+"','"+cve_loc+"','"+cve_ageb+"','"+us+"')";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_mod_casos_j_02(String cnx, String cgo, String cve_ent, String cve_mun, String cve_loc, String cve_ageb, String us, String geom) {
				
				String consulta = "select m_casos_especialescdJ('"+cgo+"','"+cve_ent+"','"+cve_mun+"','"+cve_loc+"','"+cve_ageb+"','"+us+"','"+geom+"')";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
		/// modaupr.jsp
			public static CachedRowSet consulta_modaupr(String cnx, String pass) {
				
				String consultapas = "select nivel,edicionagpr,id,regid,nombre,cons from usuarios where md5(password) = '"+pass+"';";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consultapas);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modaupr_01(String cnx, String select1, String filfe1, String filfe2, String filreg) {
				
				String consulta=" select gid,cve_ent,cve_mun,cve_loc,cve_ageb,tipo,fact,img,fdg,ban,obs,err,case when the_geom is null then '0' else '1' end as geom,cveold,ext,voc,obsoc,obsed, case when fact>'2020-06-20' then 1 else 0 end as fban from (select *,'' as voc,'' as obsoc,'' as obsed,1 as tipo from edit_ploc.v_agebu_gen where ban!='4' union select gid,cve_ent,cve_mun, cve_loc, cve_ageb, the_geom, us, fact, img, fdg, ban, obs, err, cveold, ext,'' as voc,'' as obsoc,'' as obsed,2 as tipo from edit_ploc.v_locpr_gen   where ban!='4' union select *,3 as tipo from edit_ploc.v_locpe_gen where ban!='4' ) t1 where "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+
			            " order by tipo,cve_ent,cve_mun,cve_loc,cve_ageb,gid";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modaupr_02(String cnx, String select1, String filfe1, String filfe2, String filent) {
				
				String consulta="select gid,cve_ent,cve_mun,cve_loc,cve_ageb,tipo,fact,img,fdg,ban,obs,err,case when the_geom is null then '0' else '1' end as geom,cveold,ext,voc,obsoc,obsed, case when fact>'2020-06-20' then 1 else 0 end as fban from (select *,'' as voc,'' as obsoc,'' as obsed,1 as tipo from edit_ploc.v_agebu_gen where ban!='4' union select gid,cve_ent,cve_mun, cve_loc, cve_ageb, the_geom, us, fact, img, fdg, ban, obs, err, cveold, ext,'' as voc,'' as obsoc,'' as obsed,2 as tipo from edit_ploc.v_locpr_gen   where ban!='4' union select *,3 as tipo from edit_ploc.v_locpe_gen where ban!='4' ) t1 where "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+filent+"'"+
			            " order by tipo,cve_ent,cve_mun,cve_loc,cve_ageb,gid";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
		
			public static CachedRowSet consulta_modaupr_03(String cnx, String select1, String filfe1, String filfe2, String filreg) {
				
				String consulta="select gid,cve_ent,cve_mun,cve_loc,cve_ageb,tipo,fact,img,fdg,ban,obs,err,case when the_geom is null then '0' else '1' end as geom,cveold,ext,voc,obsoc,obsed, case when fact>'2020-06-20' then 1 else 0 end as fban from (select *,'' as voc,'' as obsoc,'' as obsed,1 as tipo from edit_ploc.v_agebu_gen where ban!='4' union select gid,cve_ent,cve_mun, cve_loc, cve_ageb, the_geom, us, fact, img, fdg, ban, obs, err, cveold, ext,'' as voc,'' as obsoc,'' as obsed,2 as tipo from edit_ploc.v_locpr_gen   where ban!='4' union select *,3 as tipo from edit_ploc.v_locpe_gen where ban!='4' ) t1 where "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+
			            " order by tipo,cve_ent,cve_mun,cve_loc,cve_ageb,gid";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modaupr_04(String cnx, String select1, String filfe1, String filfe2, String filent) {
				
				String consulta="select gid,cve_ent,cve_mun,cve_loc,cve_ageb,tipo,fact,img,fdg,ban,obs,err,case when the_geom is null then '0' else '1' end as geom,cveold,ext,voc,obsoc,obsed, case when fact>'2020-06-20' then 1 else 0 end as fban from (select *,'' as voc,'' as obsoc,'' as obsed,1 as tipo from edit_ploc.v_agebu_gen where ban!='4' union select gid,cve_ent,cve_mun, cve_loc, cve_ageb, the_geom, us, fact, img, fdg, ban, obs, err, cveold, ext,'' as voc,'' as obsoc,'' as obsed,2 as tipo from edit_ploc.v_locpr_gen   where ban!='4' union select *,3 as tipo from edit_ploc.v_locpe_gen where ban!='4' ) t1 where "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+filent+"'"+
			            " order by tipo,cve_ent,cve_mun,cve_loc,cve_ageb,gid";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modaupr_05(String cnx, String select1, String filfe1, String filfe2, String ent) {
				
				String consulta="select gid,cve_ent,cve_mun,cve_loc,cve_ageb,tipo,fact,img,fdg,ban,obs,err,case when the_geom is null then '0' else '1' end as geom,cveold,ext,voc,obsoc,obsed, case when fact>'2020-06-20' then 1 else 0 end as fban from (select *,'' as voc,'' as obsoc,'' as obsed,1 as tipo from edit_ploc.v_agebu_gen where ban!='4' union select gid,cve_ent,cve_mun, cve_loc, cve_ageb, the_geom, us, fact, img, fdg, ban, obs, err, cveold, ext,'' as voc,'' as obsoc,'' as obsed,2 as tipo from edit_ploc.v_locpr_gen   where ban!='4' union select *,3 as tipo from edit_ploc.v_locpe_gen where ban!='4' ) t1 where "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+ent+"'"+
					      " order by tipo,cve_ent,cve_mun,cve_loc,cve_ageb,gid";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modaupr_06(String cnx, String filult, String loc) {
				
				String consulta="select gid,cve_ent,cve_mun,cve_loc,cve_ageb,tipo,fact,img,fdg,ban,obs,err,case when the_geom is null then '0' else '1' end as geom,cveold,ext,voc,obsoc,obsed, case when fact>'2020-06-20' then 1 else 0 end as fban from (select *,'' as voc,'' as obsoc,'' as obsed,1 as tipo from edit_ploc.v_agebu_gen where ban!='4' union select gid,cve_ent,cve_mun, cve_loc, cve_ageb, the_geom, us, fact, img, fdg, ban, obs, err, cveold, ext,'' as voc,'' as obsoc,'' as obsed,2 as tipo from edit_ploc.v_locpr_gen   where ban!='4' union select *,3 as tipo from edit_ploc.v_locpe_gen where ban!='4' ) t1 where cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','') like '" + loc.replace("-", "")  + "%' "+filult+" order by tipo,cve_ent,cve_mun,cve_loc,cve_ageb,gid";

				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			/// modcar_acu_pe.jsp
			public static CachedRowSet consulta_modcar_acu_01(String cnx, String pass) {
				
				String consultapas = "select nivel,edicion,id,regid,nombre,cons from usuarios where md5(password) = '"+pass+"';";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consultapas);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modcar_acu_02(String cnx, String consulta) {
				
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			// modcar_ni.jsp 
			public static CachedRowSet consulta_modcarni_01(String cnx, String pass) {
				
				String consultapas = "select nivel,edicion,id,regid,nombre from usuarios where md5(password) = '"+pass+"';";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consultapas);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modcarni_02(String cnx, String consulta) {
								
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			
			public static CachedRowSet consulta_modcarni_03(String cnx, String consulta) {
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			// modcar.jsp 
			public static CachedRowSet consulta_modcar_01(String cnx, String pass) {
				String consultapas = "select nivel,edicion,id,regid,nombre from usuarios where md5(password) = '"+pass+"';";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consultapas);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modcar_02(String cnx, String consulta) {
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modcar_03(String cnx, String consulta) {
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modcarloc_acu_01(String cnx, String pass) {
				
				String consulta = "select nivel,edicion,id,regid,nombre from usuarios where md5(password) = '"+pass+"';";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modcarloc_acu_02(String cnx, String consulta) {
								
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modcarloc_acu_03(String cnx, String consulta) {
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modcarloc_01(String cnx, String pass) {
				
				String consultapas = "select nivel,edicion,id,regid,nombre from usuarios where md5(password) = '"+pass+"';";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consultapas);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modcarloc_02(String cnx, String consulta) {
				
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modcarloc_03(String cnx, String consulta) {
				
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modpre_01(String cnx, String pass) {
				
				String consultapas = "select nivel,edicionagpr,id,regid,nombre,cons from usuarios where md5(password) = '"+pass+"';";
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consultapas);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			
			public static CachedRowSet consulta_modpre_02(String cnx, String consulta) {
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modpre_03(String cnx, String consulta) {
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modtefr_01(String cnx, String pass) {
				
				String consultapas = "select nivel,edicionagpr,id,regid,nombre,cons from usuarios where md5(password) = '"+pass+"';";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consultapas);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modtefr_02(String cnx, String consulta) {
				
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modtefr_03(String cnx, String consulta) {
				
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modval_rep_c5_01(String cnx, String consulta) {
				
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modval_01(String cnx, String consulta) {
				
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modvalmz_01(String cnx, String consulta) {
				
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
			public static CachedRowSet consulta_modvalmzJ_01(String cnx, String consulta) {
				
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
			
            public static CachedRowSet consulta_modvalpe_01(String cnx, String consulta) {
				
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_modvalpre_acu_01(String cnx, String consulta) {
				
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            
            public static CachedRowSet consulta_monitoreo_cancel_01(String host, String bd, String usuario, String pid) {
            	
            	String ports="";
                String user="";
                String pass="";
                
                if (host.equals("localhost")){
                  ports="5434";
                  user="actcar";
                  pass="actcar";
                }else{
                    if (usuario.equals("arcgis")){
                        ports="5434";
                        user="arcgis";
                        pass="arcgis";
                    }else{
                        ports="5434";
                        user="actcar";
                        pass="actcar";
                    }
                }
                
                String cnx = "jdbc:postgresql://" + host + ":" + ports + "/" + bd + 
                        "?user=" + user + "&password=" + pass;

                String consulta1 = "select pg_cancel_backend("+pid+")";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta1);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            
            public static CachedRowSet consulta_monitoreo_01(String cnx) {
            
            	String consulta1 = "select distinct * from (SELECT 'BD' as serv,'TODOS' as tipo,*,'l-appwebmd1' as host FROM dblink('dbname=actcargeo1 host=l-appwebmd1 port=5434  user=actcar password=actcar', 'select datname,usename,query_start,state,application_name,query,pid,client_addr,client_hostname from pg_stat_activity  where state=''active'' and substring(query,1,14)!=''select datname''') ";
            	  consulta1+="t1(datname text,usename text,query_start timestamp,state text, application_name text, query text, pid integer,client_addr text,client_hostname text) ";
            	  consulta1+="union  SELECT 'BD' as serv,'TODOS' as tipo,*,'l-appwebmd1' as host FROM dblink('dbname=actcargeo1 host=l-appwebmd1 port=5434 user=arcgis password=arcgis',  'select datname,usename,query_start,state,application_name,query,pid,client_addr,client_hostname from pg_stat_activity where state=''active'' and substring(query,1,14)!=''select datname''') t1(datname text,usename text,query_start timestamp,state text, application_name text, query text, pid integer,client_addr text,client_hostname text))tt where query not like '%TODOS%' and client_addr is not null order by query_start asc";
            	 
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta1);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_mostrar_te_01(String cnx, String id) {
                
            	String consulta="select oid,cgo_act,fact,tipo_ant,clave1,mov_ant,tipo_act,clave2,mov_act,obs,vreg,voc,motivo,0,0,img,usuario,fdg,correo,tipte,obsoc,obsre,obsed,jpg from v_te_mza where fact=(select max(fact) from v_te_mza where usuario='"+id+"') and usuario='"+id+"'";

				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obt_atlas_01(String cnx, String filtro, String box, String boxtotal) {
                
            	String consulta="select obt_atlas('"+filtro+"','"+box+"','"+boxtotal+"')";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obt_inegipoint_video_01(String cnx, String ruta, int num) {
                
            	String consulta = "select gid||'|'||ruta||'|'||uid::integer||'|'||st_x(st_centroid(geom))||'|'||st_y(st_centroid(geom)) as val from rutas where ruta='"+ruta+"' and uid::integer="+(num+1)+" limit 1";	
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obt_inegipoint(String cnx, int tipo, String x, String y, String ruta, String gid, int num) {
            	
            	String consulta = "";
            	if (tipo==1){  //inicial
            		consulta = "select gid||'|'||ruta||'|'||uid::integer||'|'||st_x(st_centroid(geom))||'|'||st_y(st_centroid(geom)) as val  from rutas where st_intersects(geom,st_buffer(ST_SetSRID( ST_Point("+x+","+y+") ,3857),10)) order by st_distance(geom,ST_SetSRID( ST_Point("+x+","+y+") ,3857)) limit 1";
                }else if (tipo==2){ //adelanta
            		consulta = "select gid||'|'||ruta||'|'||uid::integer||'|'||st_x(st_centroid(geom))||'|'||st_y(st_centroid(geom)) as val  from rutas where ruta='"+ruta+"' and gid!="+gid+" and uid="+(num+1)+" limit 1";
            	}else if (tipo==3){ //atras
            		consulta = "select gid||'|'||ruta||'|'||uid::integer||'|'||st_x(st_centroid(geom))||'|'||st_y(st_centroid(geom)) as val  from rutas where ruta='"+ruta+"' and gid!="+gid+" and uid="+(num-1)+" limit 1";
            	}
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obt_maximos_01(String cnx) {
            	
            	String consulta = "";
            	consulta = "select parametro from valida_parametros where nombre='MAX_apm'";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtcve_fm_01(String cnx, String x, String y) {
            	
            	String consulta = "";
            	consulta = "select parametro from valida_parametros where nombre='MAX_apm'";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtcve_01(String cnx, String tipo, String clave, String cvemax, String geom) {
            	
            	String consulta = "";
            	
            	if (tipo.equals("mza")){
            	      //consulta = "select max(cve_mza)::integer+1 from cat_manz where substring(cve_mza,1,1)!='T' and cve_ent||cve_mun||cve_loc||cve_ageb='"+clave+"'";
            	      consulta= "select LPAD(generate_series ::text, 3, '0')  as cve1 from generate_series(1,999) except (select cve_mza from cat_manz where cve_ent||cve_mun||cve_loc||cve_ageb='"+clave+"' union select right(cve,3) from (select unnest( array["+cvemax+"]) as cve) t1 where left(cve,14)='"+clave+"') order by cve1 limit 1";
            	}else if (tipo.equals("mzageo")){ //se obtiene la clave consecutiva siguiente por parte de la sobreposicion del centroide
            	      // se obtiene con el intersect sin revisar los huecos la maxima
            	      //consulta = "select cve_ent||cve_mun||cve_loc||cve_ageb||max(cve_mza)::integer+1 from cat_manz where substring(cve_mza,1,1)!='T' and cve_ent||cve_mun||cve_loc||cve_ageb=(select clave from (select cve_ent||cve_mun||cve_loc||cve_ageb as clave,1 as c from edit_ploc.edit_agebu where st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800)) union select cve_ent||cve_mun||cve_loc||cve_ageb as clave,2 as c from edit_ploc.edit_locr where st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800))) t1  order by c limit 1) group by cve_ent,cve_mun,cve_loc,cve_ageb";
            	     // puro intersets se obtiene el hueco  o la maxima 
            	      //consulta="select (select clave from (select cve_ent||cve_mun||cve_loc||cve_ageb as clave,1 as c from edit_ploc.edit_agebu where st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800)) union select cve_ent||cve_mun||cve_loc||cve_ageb as clave,2 as c from edit_ploc.edit_locr where st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800))) t1  order by c limit 1)||(select LPAD(generate_series ::text, 3, '0') as cve1 from generate_series(1,999) except (select cve_mza from cat_manz where cve_ent||cve_mun||cve_loc||cve_ageb=(select clave from (select cve_ent||cve_mun||cve_loc||cve_ageb as clave,1 as c from edit_ploc.edit_agebu where st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800)) union select cve_ent||cve_mun||cve_loc||cve_ageb as clave,2 as c from edit_ploc.edit_locr where st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800))) t1  order by c limit 1) union select right(cve,3) from (select unnest( array["+cvemax+"]) as cve) t1 where left(cve,14)=(select clave from (select cve_ent||cve_mun||cve_loc||cve_ageb as clave,1 as c from edit_ploc.edit_agebu where st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800)) union select cve_ent||cve_mun||cve_loc||cve_ageb as clave,2 as c from edit_ploc.edit_locr where st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800))) t1  order by c limit 1)) order by cve1 limit 1)";
            	      // este es el nuevo se obtiene del poligono o localidad mas cercano y busca huecos si no da la ultima
            	      consulta="select (select clave from (select cve_ent||cve_mun||cve_loc||cve_ageb as clave,1 as c,the_geom from edit_ploc.v_cat_au where st_dwithin(st_transform(ST_GeomFromText('"+clave+"',3857),32800),the_geom,10000) union select cve_ent||cve_mun||cve_loc||cve_ageb as clave,2 as c,the_geom from edit_ploc.v_cat_plr where st_dwithin(st_transform(ST_GeomFromText('"+clave+"',3857),32800),the_geom,10000)) t1 order by ST_Distance(st_transform(ST_GeomFromText('"+clave+"',3857),32800), the_geom) limit 1)||(select LPAD(generate_series ::text, 3, '0') as cve1 from generate_series(1,999) except (select cve_mza from cat_manz where cve_ent||cve_mun||cve_loc||cve_ageb=((select clave from (select cve_ent||cve_mun||cve_loc||cve_ageb as clave,1 as c,the_geom from edit_ploc.v_cat_au where st_dwithin(st_transform(ST_GeomFromText('"+clave+"',3857),32800),the_geom,10000) union select cve_ent||cve_mun||cve_loc||cve_ageb as clave,2 as c,the_geom from edit_ploc.v_cat_plr where st_dwithin(st_transform(ST_GeomFromText('"+clave+"',3857),32800),the_geom,10000)) t1 order by ST_Distance(st_transform(ST_GeomFromText('"+clave+"',3857),32800), the_geom) limit 1)) union select right(cve,3) from (select unnest( array["+cvemax+"]) as cve) t1 where left(cve,14)=  ((select clave from (select cve_ent||cve_mun||cve_loc||cve_ageb as clave,1 as c,the_geom from edit_ploc.v_cat_au where st_dwithin(st_transform(ST_GeomFromText('"+clave+"',3857),32800),the_geom,10000) union select cve_ent||cve_mun||cve_loc||cve_ageb as clave,2 as c,the_geom from edit_ploc.v_cat_plr where st_dwithin(st_transform(ST_GeomFromText('"+clave+"',3857),32800),the_geom,10000)) t1 order by ST_Distance(st_transform(ST_GeomFromText('"+clave+"',3857),32800), the_geom) limit 1)))   order by cve1 limit 1)";
            	            //out.print(consulta);

            	    }else if (tipo.equals("au")){
            	      //consulta = "select lpad((max(substring(cve_ageb,1,3))::integer+1)::text,3,'0') from edit_ploc.edit_agebu where cve_ent||cve_mun='"+clave.substring(0,5)+"'";
            	      consulta="select LPAD(generate_series ::text, 3, '0')  as cve1 from generate_series(1,999) except (select left(cve_ageb,3) from edit_ploc.edit_agebu where cve_ent||cve_mun='"+clave+"' union select left(cve_ageb,3) from cat_ageb where cve_ent||cve_mun='"+clave+"' union select substring(cve,6,3) from (select unnest( array["+cvemax+"]) as cve) t1 where left(cve,5)='"+clave+"') order by cve1 limit 1";
            	}else if (tipo.equals("pr")){
            	            consulta = "select clave||cve_ageb from (SELECT cat_loc.clave, cat_loc.cve_ageb,the_geom FROM cat_loc WHERE status=1 and ambito='R' and NOT (cat_loc.clave::text IN ( SELECT bd_loc_pendientes.clave FROM bd_loc_pendientes)) UNION SELECT bd_loc_pendientes.clave, substring(ageb, 1, 3) || '-' || substring(ageb, 4, 1) AS cve_ageb,st_setsrid(st_point(ccl_x,ccl_y), 32800) AS the_geom  FROM bd_loc_pendientes WHERE status = 1 AND ambito = 'R') t1 where st_intersects(the_geom,st_transform(ST_GeomFromText('"+geom+"',3857),32800))";
            	}else if (tipo.equals("pe")){
            	            consulta = "select clave from (SELECT cat_loc.clave,the_geom FROM cat_loc WHERE status=1 and ambito='R' and NOT (cat_loc.clave::text IN ( SELECT bd_loc_pendientes.clave FROM bd_loc_pendientes)) UNION SELECT bd_loc_pendientes.clave, st_setsrid(st_point(ccl_x,ccl_y),32800) AS the_geom  FROM bd_loc_pendientes WHERE status = 1 AND ambito = 'R') t1 where st_intersects(the_geom,st_transform(ST_GeomFromText('"+geom+"',3857),32800))";
            	}else if (tipo.equals("pesimplify")){
            	            consulta = "SELECT cve_ent||cve_mun||cve_loc FROM edit_ploc.edit_pe WHERE ban <> ALL (ARRAY[3, 9, 4]) and st_intersects(the_geom,st_transform(ST_GeomFromText('"+geom+"',3857),32800))";
            	}else if (tipo.equals("codigoj")){
            	  consulta="select cve_ent||cve_mun||cve_loc||cve_ageb from edit_ploc.edit_agebu where ban=1 and st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800)) limit 1";
            	}else if (tipo.equals("codigocj")){
            	  consulta="select cve_ent||cve_mun||cve_loc||cve_ageb from edit_ploc.edit_agebu where ban=1 and st_intersects(the_geom,st_buffer(st_transform(ST_GeomFromText('"+clave+"',3857),32800),1000)) order by st_distance(the_geom,(st_transform(ST_GeomFromText('"+clave+"',3857),32800))) limit 1";
            	}
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtcveCD_01(String cnx, String clave) {
            	
            	String consulta = "";
                consulta = "select cve_ent||cve_mun||cve_loc||cve_ageb from (select 1 as n,cve_ent,cve_mun,cve_loc,(select cve_ageb from cat_loc where clave=t1.cve_ent||t1.cve_mun||t1.cve_loc),the_geom from edit_ploc.v_cat_pe t1   union select 2 as n,cve_ent,cve_mun,cve_loc,cve_ageb,the_geom from cd_polext union select 3 as n,cve_ent,cve_mun,cve_loc,cve_ageb,the_geom from  edit_ploc.v_cat_plr union select 4 as n,cve_ent,cve_mun,cve_loc,cve_ageb,the_geom from edit_ploc.v_cat_au union select 5 as n,cve_ent,cve_mun,cve_loc,cve_ageb,the_geom from cat_loc where status=1) t2 where st_dwithin(st_transform(ST_GeomFromText('"+clave+"',3857),32800), the_geom, 10000)  order by ST_Distance(st_transform(ST_GeomFromText('"+clave+"',3857),32800), the_geom),n limit 1";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtfedg_01(String cnx, String baseimg, String filtro, String x, String y) {
            	
            	String consulta = "";
            	
            	if (baseimg.equals("DG")){
            		  consulta = "select left(fecha::varchar,10) from a_digitalglobe where CE90accura is not null and "+filtro+" st_intersects(geom,ST_SetSRID(ST_Point("+x+","+y+"),4326)) order by fecha desc limit 1";
            	}else if (baseimg.equals("D2")){
            	    consulta = "select left(fecha::varchar,10) from a_digitalca22 where st_intersects(geom,ST_SetSRID(ST_Point("+x+","+y+"),4326)) order by fecha desc limit 1";
            	}
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            
            public static CachedRowSet consulta_obtgeo_ac_ca22_01(String cnx, String id) {
            	
            	String consulta = "";
            	
            	consulta = "select ST_AsText(st_transform(geom,3857)) from vw_carga_tcar_masivo where cveoper_censor||cvegeo='"+id+"'";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtgeo_aupr_01(String cnx, String id, String ban) {
            	
            	String consulta = "";
            	
            	if (ban.equals("1")){  //agebs
          			consulta = "select ST_AsText(st_transform(the_geom,3857)) from edit_ploc.edit_agebu where gid="+id;
	            }else if (ban.equals("2")){  //polrur
	                consulta = "select ST_AsText(st_transform(the_geom,3857)) from edit_ploc.edit_locr where gid="+id;
	            }else if (ban.equals("3")){  //externo
	                consulta = "select ST_AsText(st_transform(the_geom,3857)) from edit_ploc.edit_pe where gid="+id;
	            }else if (ban.equals("4")){  //carta5
	                consulta = "select ST_AsText(st_transform(geom,3857)) from a_rep_cardig where gid="+id;
	            }
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtgeo_fr_01(String cnx, String x, String y) {
            	
            	String consulta = "";
            	
                consulta = "select st_Astext(ST_ExteriorRing(st_transform(geom,3857))) from  (select (ST_Dump(the_geom)).geom from cat_manz where ban not in ('1','3','5','6','Y','E','D','H','G','M','I','N','O','K','R','T','C') and st_intersects(the_geom,ST_SetSRID(ST_Point("+x+","+y+"),32800))) t1 order by st_area(geom) limit 2";
				
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtgeo_loc_baja_01(String cnx, String x, String y) {
            	
            	String consulta = "";
            	
                consulta = "select * from (select '1' as tip,st_Astext(st_transform(the_geom,3857)),cve_ent||cve_mun||cve_loc as cvegeo,st_distance(the_geom,ST_SetSRID(ST_Point("+x+","+y+"),32800)) from cat_loc where st_intersects(the_geom,st_buffer(ST_SetSRID(ST_Point("+x+","+y+"),32800),200)) union select '2' as tip,st_Astext(st_transform(the_geom,3857)),cve_ent||cve_mun||cve_loc as cvegeo,st_distance(the_geom,ST_SetSRID(ST_Point("+x+","+y+"),32800)) from cat_cd_base where st_intersects(the_geom,st_buffer(ST_SetSRID(ST_Point("+x+","+y+"),32800),200)) ) t2 order by st_distance limit 1";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtgeo_modcar_acu_01(String cnx, String id, String tipo) {
            	
            	String consulta = "";
            	
            	if (tipo.equals("1")){
            	    consulta = "select ST_AsText(st_transform(geom,3857)) from act_cu.bcu_bd_manzana where gid='"+id+"'";
            	}else if (tipo.equals("2")){
            	    consulta = "select ST_AsText(st_transform(geom,3857)) from act_cu.bcu_bd_pe where gid="+id+"";
            	}else{
            	    consulta = "select st_x(geom)||','||st_y(geom) from act_cu.bcu_bd_loc_rur  where gid='"+id+"'";
            	}
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtgeo_modcar_ni_01(String cnx, String id) {
            	
            	String consulta = "";
            	
            	consulta = "select ST_AsText(st_transform(geom,3857)) from mcc_poblacion.ca_terrenos where gid||clave_operativa='"+id+"'";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtgeo_modcar_01(String cnx, String id, String tipo) {
            	
            	String consulta = "";
            	
            	if (tipo.equals("1")){
            		consulta = "select ST_AsText(st_transform(geom,3857)) from mcc_poblacion.cat_manz_modcar where gid||figura='"+id+"'";
            	}else{
            		consulta = "select st_x(geom)||','||st_y(geom) from mcc_poblacion.loc_rur where gid||figura='"+id+"'";
            	}
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtgeo_modpre_01(String cnx, String id, String ban) {
            	
            	String consulta = "";
            	
            	if (ban.equals("1")){  //z_digmz
        			consulta = "select ST_AsText(st_transform(the_geom,3857)) from z_digmz where gid="+id;
		        }else if (ban.equals("2")){  //z_digmz
		              consulta = "select ST_AsText(st_transform(the_geom,3857)) from z_digpe where gid="+id;
		        }else if (ban.equals("3")){  //z_digmz
		              consulta = "select ST_AsText(st_transform(st_multi(st_buffer(the_geom,50)),3857)) from z_digmp where gid="+id;
		        }
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtgeo_mz_baja_01(String cnx, String x, String y) {
            	
            	String consulta = "";
            	
                consulta = "select st_Astext(st_transform(geom,3857)),replace(cvegeo,'-','') as cvegeo from cat_manz_base where st_intersects(geom,ST_SetSRID(ST_Point("+x+","+y+"),32800)) order by st_area(geom)";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtgeo_mz_01(String cnx, String x, String y) {
            	
            	String consulta = "";
            	
                consulta = "select st_Astext(st_transform(geom,3857)) from cat_manz_base where st_intersects(geom,ST_SetSRID(ST_Point("+x+","+y+"),32800))";

				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtgeo_pe_pre_01(String cnx, String x, String y) {
            	
            	String consulta = "";
            	
                consulta = "select st_Astext(st_transform(the_geom,3857)) from edit_ploc.v_cat_pe where st_intersects(the_geom,ST_SetSRID(ST_Point("+x+","+y+"),32800))";

				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtgeo_pe_01(String cnx, String x, String y) {
            	
            	String consulta = "";
            	
                consulta = "select tipo,cve_ent,cve_mun,cve_loc,ST_AsText(st_transform(geom,3857)) as geom from (select cve_ent,cve_mun,cve_loc,'1' as tipo,((st_multi(geom))) as geom from act_cu.bcu_bd_pe where f_registro> (select fecha from vista_fecha_corte where tipo='inicia') and proc!=1 union select cve_ent,cve_mun,cve_loc,'2' as tipo, ((st_multi(the_geom))) as geom from z_digpe ) t2 where st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) order by tipo,st_Area(geom) limit 1";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtgeo_pem_01(String cnx, String x, String y) {
            	
            	String consulta = "";
            	
                consulta = "select tipo,cve_ent,cve_mun,cve_loc,ST_AsText(st_transform(geom,3857)) as geom from (select cve_ent,cve_mun,cve_loc,'1' as tipo,((st_multi(geom))) as geom from act_cu.bcu_bd_pe where  f_registro> (select fecha from vista_fecha_corte where tipo='inicia') and proc!=1 union select cve_ent,cve_mun,cve_loc,'2' as tipo, ((st_multi(the_geom))) as geom from z_digpe ) t2 where st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) order by tipo,st_Area(geom) limit 1";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtgeo_tefr_01(String cnx, String gid) {
            	
            	String consulta = "";
            	
            	consulta = "select st_Astext((st_transform(the_geom,3857)))  from te_fr where gid="+gid;
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtgeo_01(String cnx, String cve, String clave, String id, String val, String cgo) {
            	
            	String consulta = "";
            	
            	if (cve.equals("800")){
            		  if (val.equals("0")){  //referencia anterior
            		      consulta = "select ST_AsText(st_transform(the_geom,3857)) from cat_cd_base where cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza=replace('"+clave+"','-','') order by gid  limit 1 ";
            		    }else{  //referencia actual
            		      consulta = "select ST_AsText(st_transform(the_geom,3857)) from cat_cd where cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza='"+clave+"' order by gid desc limit 1 ";
            		    }
            		}else{
            			if (cgo.length()==2){  //geometrico
            				if (val.equals("0")){  //referencia anterior
            					consulta = "select ST_AsText(st_transform(the_geom_ant,3857)) from te_mza_coord_fr where oid="+id;
            				}else{	//referencia actual
            					consulta = "select ST_AsText(st_transform(the_geom_act,3857)) from te_mza_coord_fr where oid="+id;
            				}
            			}else{   //nivel catalogo
            				consulta = "select ST_AsText(st_transform(the_geom,3857)) from cat_manz where cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza='"+clave+"' order by gid desc limit 1 ";	
            			}
            		}
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            
            public static CachedRowSet consulta_obtmza_acu_cd_01(String cnx, String x, String y) {
            	
            	String consulta = "";
            	
        		consulta = "select gid,tip_act,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(ST_PointOnSurface(geomdump),3857)),ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,tipo,'','',cgo_def,status,mal from (select *,(ST_Dump(geom)).geom AS geomdump  from act_cu.bcu_bd_manzana where f_registro> (select fecha from vista_fecha_corte where tipo='inicia')) tt where (cve_mza::integer>900 or cve_mza::integer=800) and st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) order by proc,mal,st_Area(geom),cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza desc limit 1";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtmza_acu_rec_01(String cnx, String consulta) {
            	
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtmza_acu_01(String cnx, String x, String y) {
            	
            	String consulta; 
            	consulta = "select * from (select gid,tip_act,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(geom,3857)) as geom,ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,a_sinacentos(tipo),'','',cgo_def,status,mal,1 as ord from act_cu.bcu_bd_manzana where  (proc !=1 or f_registro>(select fecha from vista_fecha_corte where tipo='inicia')) and st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) ";
            	consulta = consulta + " ) tt order by ord,case proc when 0 then 1 when 1 then 2 else 1 end,status,mal,st_Area(geom),cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza desc limit 1";

            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtmza_cd_01(String cnx, String x, String y) {
            	
            	String consulta; 
            	
            	consulta = "select * from (";

            	consulta +=" select gid,cgo,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(ST_PointOnSurface(geomdump),3857)),ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,tipomza::varchar,tipo,figura,cgo_def,status::varchar,mal,'1MCC' as tipoproy from (select *,(ST_Dump(geom)).geom AS geomdump  from mcc_poblacion.cat_manz_modcar) tt where ((((cve_mza='800' and cgo in ('44','45'))) and ((figura='CENSOR' and status!=2) or (figura='TCAR')) and status in (0,1,2,3,4,5,6,7,8,9)) or status='7') and st_intersects(geomdump,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) and (not (cgo='3' and status>=3)) ";
            	consulta += "union	";
            	consulta += "select gid,tip_act,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(ST_PointOnSurface(geomdump),3857)),ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,tipo,'','',cgo_def,status::varchar,mal,'2ACU' as tipoproy from (select *,(ST_Dump(geom)).geom AS geomdump  from act_cu.bcu_bd_manzana where f_registro> (select fecha from vista_fecha_corte where tipo='inicia')) tt where (cve_mza::integer>900 or cve_mza::integer=800) and st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) ) t2 ";
            	consulta += "order by tipoproy,proc,mal,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza desc limit 1";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtmza_no(String cnx, String clave, String fec1, String gid, String proc, String cgo, String tip) {
            	
            	String consulta; 
            	
            	if (cgo.equals("3")){
            	      if (tip.equals("3")){   //proyectada
            				   consulta = "update cat_manz_modcar set cve_def='"+clave+"',proc=3,fresp='"+fec1+"' where cgo='3' and gid="+gid;
            	      }else{
            	         consulta = "update cat_manz_modcar set proc="+proc+",fresp='"+fec1+"' where cgo='3' and gid="+gid;
            	      }
            	  }else{
            	      if (tip.equals("3")){   //proyectada
            	         consulta = "update cat_manz_modcar set cve_def='"+clave+"',proc=3,fresp='"+fec1+"' where cgo!='3' and gid="+gid;
            	      }else{
            	         consulta = "update cat_manz_modcar set proc="+proc+",fresp='"+fec1+"' where cgo!='3' and gid="+gid;
            	      }
            	  }
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            
            public static CachedRowSet consulta_obtmza_pre(String cnx, String x, String y) {
            	
            	String consulta; 
            	
        		consulta = "select gid,cve_ent,ST_AsText(st_transform(st_multi(the_geom),3857)),ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,conviv,substring(cvegeo,1,5)||'0000'||substring(cvegeo,6,5) from z_digmz where st_intersects(the_geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) order by st_Area(the_geom) limit 1";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtmza(String cnx, String x, String y, Integer capa1, Integer capa2, Integer capa3, Integer capa4) {
            	
            	String consulta; 
            	
            	consulta = "select * from ( ";
            	consulta += " select gid,cgo,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(geom,3857)) as geom, ";
            	consulta += " ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,tipomza::varchar,tipo,figura,cgo_def,status::varchar,mal,cveoper as ord,'1MCC' as tipocm ";
            	consulta += " from mcc_poblacion.cat_manz_modcar where st_mza='1' and ((figura='CENSOR' and status!='2') or figura='TCAR')  ";
            	consulta += " and st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) and 1="+capa1;
            	consulta += " union  ";
            	consulta += " select gid,tip_act,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(geom,3857)) as geom, ";
            	consulta += " ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,a_sinacentos(tipo),'','',cgo_def,status,mal,'1' as ord, '2ACU' as tipocm";
            	consulta += " from act_cu.bcu_bd_manzana where (proc !=1 or f_registro>(select fecha from vista_fecha_corte where tipo='inicia')) and st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) and 1="+capa2;
            	consulta += " union ";
            	consulta += " select gid,'P',cve_ent,substring(cvegeo,3,3),'0000',substring(cvegeo,6,5),'000',fact,fact,'0','0',ST_AsText(st_transform(st_multi(the_geom),3857)),";
            	consulta += " ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,'0','0','0','0','1',0,'2' as ord, '3PRE' as tipocm";
            	consulta += " from z_digmz where st_intersects(the_geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) and 1="+capa3;
            	consulta += " union ";
            	consulta += " select gid,tip_act,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,fecha_mod,fecha_mod,0,'',ST_AsText(st_transform(geom,3857)) as geom, ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto, a_sinacentos(tipo),'','',NULL,status,0,'1' as ord, '4ACU' as tipocm from manzanabcu_res where st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) and 1="+capa4;
            	consulta += " ) tt  order by tipocm,st_Area(geom),proc,status,mal,st_Area(geom),cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza desc limit 1 ";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_obtpassdg(String cnx, String x) {
            	
            	String consulta; 
            	
            	consulta = "select a_convierte_escapehtml(passdg) from usuarios where userdg ='"+x+"'";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_opcion(String cnx, String x, String y) {
            	
            	String consulta; 
            	
            	consulta = "select a_convierte_escapehtml(passdg) from usuarios where userdg ='"+x+"'";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_planojpg2_01(String cnx, Float lon, Float lat) {
            	
            	String consulta; 
            	
            	 consulta = "select cve_ent,nom_ent from cat_ent where st_intersects(the_geom,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_planojpg2_02(String cnx, Float lon, Float lat) {
            	
            	String consulta; 
            	
            	consulta = "select cve_mun,nom_mun from cat_mun where st_intersects(the_geom,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_planojpg2_03(String cnx, Float lon, Float lat) {
            	
            	String consulta; 
            	
                consulta = "select substring(clave,6,9)||' - R',nom_loc from cat_loc where st_intersects(the_geom_pr,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";

				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_planojpg2_04(String cnx, Float lon, Float lat) {
            	
            	String consulta; 
            	
                consulta = "select substring(clave,6,9)||' - U',nom_loc from cat_loc where st_intersects(the_geom_pu,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";

				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_planojpg2_05(String cnx, Float lon, Float lat) {
            	
            	String consulta; 
            	
            	consulta = "select cve_ageb from cat_ageb where st_intersects(the_geom,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_planojpg2_06(String cnx, Float lon, Float lat) {
            	
            	String consulta; 
            	
            	consulta = "select cve_ageb from cat_agebu where st_intersects(the_geom,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_planojpg2_act_01(String cnx, Float lon, Float lat) {
            	
            	String consulta; 
            	
            	consulta = "select cve_ent,nom_ent from cat_ent where st_intersects(the_geom,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            
            public static CachedRowSet consulta_planojpg2_act_02(String cnx, Float lon, Float lat) {
            	
            	String consulta; 
            	
            	consulta = "select cve_mun,nom_mun from cat_mun where st_intersects(the_geom,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";

				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_planojpg2_act_03(String cnx, Float lon, Float lat) {
            	
            	String consulta; 
            	
            	consulta = "select cve_loc||' - R',(select nom_loc from cat_loc t2 where clave=t1.cve_ent||t1.cve_mun||t1.cve_loc) as nom_loc from edit_ploc.respaldo_edit_locr t1 where st_intersects(the_geom,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_planojpg2_act_04(String cnx, Float lon, Float lat) {
            	
            	String consulta; 
            	
            	consulta = "select substring(clave,6,9)||' - U',nom_loc from cat_loc where st_intersects(the_geom_pu,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_planojpg2_act_05(String cnx, Float lon, Float lat) {
            	
            	String consulta; 
            	
                consulta = "select cve_loc||' - R',nom_loc from cat_loc where status=1 and st_intersects(the_geom,st_buffer(st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800),1000)) order by st_distance(the_geom,st_transform(ST_SetSRID(ST_Point("+lon+","+lat+"), 3857),32800)) limit 1";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_planojpg2_act_06(String cnx, Float lon, Float lat) {
            	
            	String consulta; 
            	
                consulta = "select cve_ageb from cat_ageb where st_intersects(the_geom,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_planojpg2_act_07(String cnx, Float lon, Float lat) {
            	
            	String consulta; 
            	
                consulta = "select cve_ageb from edit_ploc.respaldo_edit_agebu where st_intersects(the_geom,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_regtefr(String cnx, String gid, String x, String y, String ent, String c1, String c2, String c3, String c4, String us) {
            	
            	String consulta; 
            	
            	consulta = "select _frente_mas_cercano("+gid+",'"+x+","+y+"','"+ent+"','"+c1+"','"+c2+"','"+c3+"','"+c4+"','"+us+"')";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_regresa_varios(String cnx, String pass) {
            	
            	String consulta; 
            	
            	consulta = "select nivel from usuarios where md5(password) = '"+pass+"';";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_regresa_varios02(String cnx, String consulta) {

				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_regresa(String cnx, String clave, String tipo) {
            	
            	String consulta="select * from a_regresa_coord('"+clave+"',"+tipo+");";

				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_regresaaupr(String cnx, String gid, String tipo) {
            	
            	String consulta="select * from edit_ploc.a_regresa_coord_aupr("+tipo+","+gid+");";

				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_regresamz(String cnx, String gid, String tipo) {
            	
            	String consulta;
            	if (tipo.equals("3")){
            	    consulta="select * from a_regresa_coord_cd("+tipo+","+gid+");";
            	}else{
            	    consulta="select * from a_regresa_coord_mz("+tipo+","+gid+");";
            	}

				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_regresamzJ(String cnx, String gid, String tipo) {
            	
            	String consulta="select * from a_regresa_coord_mzj("+tipo+","+gid+");";  //tipo 1 es de manzana otro es de caserio

				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_rep_listar01(String cnx, String pass) {
            	
            	String consultapas = "select nivel,edicionpre,id,regid,nombre from usuarios where md5(password) = '"+pass+"';";

				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consultapas);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_rep_listar02(String cnx, String consulta) {
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_rep_listar03(String cnx, String consulta) {
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_reporte_jsp(String cnx, String ent2) {
            	
            	String consulta = "select t2.cve_ent,";
            	consulta += "(select count(*) from mcc_poblacion.cat_manz_modcar t1 where t1.cve_ent=t2.cve_ent) as todos, ";
            	consulta += "(select count(*) from mcc_poblacion.cat_manz_modcar t1 where t1.cve_ent=t2.cve_ent and ((figura='CENSOR' and t1.status in ('1','7')) or figura='TCAR' or cgo='46') and proc!=0 ) as ya,";
            	consulta += "(select count(*) from mcc_poblacion.cat_manz_modcar t1 where t1.cve_ent=t2.cve_ent and ((figura='CENSOR' and t1.status in ('1','7') and cgo!='46') or figura='TCAR') and proc=0 ) as faltan,";
            	consulta += "(select count(*) from mcc_poblacion.cat_manz_modcar t1 where t1.cve_ent=t2.cve_ent and cgo='46' and proc=0) as c46,";
            	consulta += "(select count(*) from mcc_poblacion.cat_manz_modcar t1 where t1.cve_ent=t2.cve_ent  and figura='CENSOR' and t1.status not in ('1','7') and cgo!='46') as rechazados, ";
            	consulta += "(select count(*) from mcc_poblacion.loc_rur t1 where t1.cve_ent=t2.cve_ent) as ltodos,";
            	consulta += "(select count(*) from mcc_poblacion.loc_rur t1 where t1.cve_ent=t2.cve_ent and (proc!=0 or codigoact=9)) as lya,";
            	consulta += "(select count(*) from mcc_poblacion.loc_rur t1 where t1.cve_ent=t2.cve_ent and proc=0 and codigoact!=9) as lfaltan ";
            	//consulta += "(select count(*) from mcc_poblacion.loc_rur t1 where t1.cve_ent=t2.cve_ent and codigoact=9) as lcambio ";
            	consulta += "from cat_ent t2 where t2.status=1 "+ent2+"";
            	consulta += "group by t2.cve_ent order by t2.cve_ent";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_tel01(String cnx, String pass) {
            	
            	String consultapas = "select nivel,edicion,id,regid,nombre from usuarios where md5(password) = '"+pass+"';";
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consultapas);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            
            public static CachedRowSet consulta_tel02(String cnx, String consultacount) {
            	            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consultacount);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_tel03(String cnx, String consulta) {
            	
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_tem_cambia01(String cnx, String funcion, String solo, String gid, String cgo_act, String tipo_ant, String ent_ant, String mun_ant, String loc_ant, String ageb_ant, String mza_ant, String mov_ant, String tipo_act, String ent_act, String mun_act, String loc_act, String ageb_act, String mza_act, String mov_act) {
            	
            	String consulta="select "+funcion+"('"+solo+"',"+gid+",'"+cgo_act+"','"+tipo_ant+"','"+ent_ant+"','"+mun_ant+"','"+loc_ant+"','"+ageb_ant+"','"+mza_ant+"','"+mov_ant+"','"+tipo_act+"','"+ent_act+"','"+mun_act+"','"+loc_act+"','"+ageb_act+"','"+mza_act+"','"+mov_act+"')";

				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_tem_cambia02(String cnx, String tabla, String gid) {
            	
            	String consulta = "select cgo_act,tipo_ant,ent_ant,mun_ant,loc_ant,ageb_ant,mza_ant,mov_ant,tipo_act,ent_act,mun_act,loc_act,ageb_act,mza_act,mov_act from "+tabla+" where oid="+gid+"";

				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_tem_cambiaJ01(String cnx, String funcion, String solo, String gid, String cgo_act, String tipo_ant, String ent_ant, String mun_ant, String loc_ant, String ageb_ant, String mza_ant, String mov_ant, String tipo_act, String ent_act, String mun_act, String loc_act, String ageb_act, String mza_act, String mov_act) {
            	
            	String consulta;
                consulta="select "+funcion+"('"+solo+"',"+gid+",'"+cgo_act+"','"+tipo_ant+"','"+ent_ant+"','"+mun_ant+"','"+loc_ant+"','"+ageb_ant+"','"+mza_ant+"','"+mov_ant+"','"+tipo_act+"','"+ent_act+"','"+mun_act+"','"+loc_act+"','"+ageb_act+"','"+mza_act+"','"+mov_act+"')";
				ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            
            public static CachedRowSet consulta_tem_cambiaJ02(String cnx, String tabla, String gid) {
            	String consulta;
          	    consulta = "select cgo_act,tipo_ant,ent_ant,mun_ant,loc_ant,ageb_ant,mza_ant,mov_ant,tipo_act,ent_act,mun_act,loc_act,ageb_act,mza_act,mov_act from "+tabla+" where oid="+gid+"";
				
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_tem01(String cnx, String pass) {
            	String consultapas;
            	consultapas = "select nivel,edicionmz,id,regid,nombre,cons from usuarios where md5(password) = '"+pass+"';";
            	
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consultapas);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_tem02(String cnx, String consultacount) {
            	
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consultacount);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_tem03(String cnx, String consulta) {
            	
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            
            public static CachedRowSet consulta_temf01(String cnx, String pass) {
            	
            	String consultapas = "select nivel,edicionmz,id,regid,nombre,cons from usuarios where md5(password) = '"+pass+"';";
            	
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consultapas);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_temf02(String cnx, String consultacount) {
            
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consultacount);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_temf03(String cnx, String consulta) {
                
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
                  
            public static CachedRowSet consulta_temj01(String cnx, String pass) {
            	
            	String consultapas = "select nivel,edicionmz,id,regid,nombre,cons from usuarios where md5(password) = '"+pass+"';";
                
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consultapas);
					
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            
            public static CachedRowSet consulta_temj02(String cnx, String consultacount) {
            
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consultacount);
				
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}

            public static CachedRowSet consulta_temj03(String cnx, String consulta) {
                
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
				
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_temp_definitiva_cu(String cnx, String filtro, String consulta) {
            	String consulta1 = "select *  from manz_afect_cu "+consulta+ filtro+" order by de desc,cvegeo_prov,cvegeo_def";
                
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta1);
				
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_temp_definitiva(String cnx, String consulta, String cadena, String filtro) {
            	String consulta1 = "select *  from temp_def_pob "+consulta+ cadena+ filtro+" order by de desc,cvegeo_prov,cvegeo_def";
                
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta1);
				
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_val_ab_sigma_ant_01(String cnx, String cons) {
            	String consulta ="select md5(password) from usuarios where cons="+cons;
                
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
				
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_val_ab_sigma_ant_02(String cnx, String consulta) {
                
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
				
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_val_ab_sigma_ant_03(String cnx, String conCent) {
                
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(conCent);
				
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_val_ab_sigma_01(String cnx, String cons) {
            	
                String consulta ="select md5(password) from usuarios where cons="+cons;
                
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
				
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_val_ab_sigma_02(String cnx, String consulta) {
            	                
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
				
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_valida_fm(String cnx, String cve, String baseimg, String iduser, String escala) {
            	
            	String consulta2 = "select a_revisa_fm('"+cve+"','"+baseimg+"','"+iduser+"','"+escala+"')";
                
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta2);
				
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_valida_te(String cnx, String filterid) {
            	
            	String consulta2 = "select a_revisa_ins_mza_te('"+filterid+"')";
                
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta2);
				
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_valida_teCD(String cnx, String filterid) {
            	
            	String consulta2 = "select a_revisa_ins_mza_te_CD('"+filterid+"')";
                
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta2);
				
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_verobsmz(String cnx, String user) {
            	
            	String consulta="select nombre,correo from usuarios where cons="+user;
                
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
				
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_verrespmcc_acu(String cnx, String gid) {
            	
            	String consulta = "select cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,cve_temp,ban,proy,tipomza from cat_manz where vienede='"+gid+"' union select cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,cve_temp,ban,proy,'9' as tipomza from cat_cd where vienede='"+gid+"'";

                
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
				
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_verrespmcc(String cnx, String fig, String gid) {
            	
            	String consulta = "select cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,cve_temp,ban,proy,tipomza from cat_manz where vienede='"+fig+gid+"' union select cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,cve_temp,ban,proy,'9' as tipomza from cat_cd where vienede='"+fig+gid+"'";

                
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
				
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_verrespmccloc(String cnx, String gid) {
            	
            	String  consulta= "select id,cgo1,ent_ant,mun_ant,loc_ant,ageb_ant,ent_Act,mun_act,loc_act,ageb_act,nom_loc,plano from bd_loc where fcap>='2023-08-01' and id_prov="+gid;
                
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
				
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            public static CachedRowSet consulta_versiones(String cnx) {
            	
            	String   consulta = "select nombre,version,fecha from cat_version where cat not in ('cat_front','colindantes','box_shp') order by orden";
            	
                ResultSet _rs = null;
				//ResultSet rs2 = null;
				//PreparedStatement ps2;
				CachedRowSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				
				//try (Connection con = AdministradorDataSource_Sigma.getConnection(cnx);
				try {	
					con = AdministradorDataSource_Sigma.getConnection(cnx);
					ps = con.prepareStatement(consulta);
				
					//ps.setString(1, pass);
					
					ps.setQueryTimeout(3000);
					_rs = ps.executeQuery();
					 rs = RowSetProvider.newFactory().createCachedRowSet();
				     rs.populate(_rs);	
								
					return rs;
					// con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};	if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
				return rs;
			}
            
            
         
}
