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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

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

//import mx.org.inegi_nuevo_sigma_historicos_prueba.dao.alerta;
//import alerta;


public class Constructor_de_Consultas2 {

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
	        
		
		ResultSet _rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		CachedRowSet rs = null;
		
		try {
		
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql);
			ps.setString(1, pass);
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			   rs = RowSetProvider.newFactory().createCachedRowSet();
			   rs.populate(_rs);
			return rs;
	
		} catch (SQLException e) {
			//e.printStackTrace();
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


	
	public static CachedRowSet consulta_consulta_ac_ca22_01(String cnx, String pass) {

		String sql =  "select nivel,edicion,id,regid,nombre from usuarios where md5(password) = ?";
		
		ResultSet _rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		CachedRowSet rs = null;
		
		try {
		
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql);
			ps.setString(1, pass);
			ps.setQueryTimeout(3000);
			_rs = ps.executeQuery();
			   rs = RowSetProvider.newFactory().createCachedRowSet();
			   rs.populate(_rs);
			return rs;
	
		} catch (SQLException e) {
			//e.printStackTrace();
		}
		
		finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
		return rs;
	}

	// -----------------------------------------------------------------------------------

	
	public static CachedRowSet consulta_ac_ca22_02(String cnx, String basecon, String select1, 
                String select2, String filfe1, String filfe2, String filreg) {
		// Validar nombre de tabla
		if (!basecon.matches("^[a-zA-Z0-9_]+$")) {
		throw new IllegalArgumentException("Nombre de tabla inválido: " + basecon);
		}
		
		ResultSet _rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		CachedRowSet rs = null;
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		 java.util.Date parsedDate1;
		 java.util.Date parsedDate2;
		 java.sql.Date sqlDate1 = null;
		 java.sql.Date sqlDate2 = null;
		
		// Construir la consulta base
		StringBuilder sql = new StringBuilder(
		"SELECT cveoper_tcar, cveoper_censor, cvegeo, cve_ent, cve_mun, cve_loc, " +
		"cve_ageb, cve_mza, codigoact, fecha_actualizacion, " +
		"CASE WHEN geom IS NULL THEN '0' ELSE '1' END AS geom, status_tcar, nota " +
		"FROM " + basecon + " " +
		"WHERE codigoact != 0 " +
		"AND estatus_en_paquete != '3' " +
		"AND estatus_en_paquete IS NOT NULL "
		);
		
		
		
		// Lista para parámetros del PreparedStatement
		//List<Object> params = new ArrayList<>();
		
		// Añadir condiciones dinámicamente
		if (select1 != null && !select1.trim().isEmpty()) {
		sql.append("AND ").append(select1).append(" "); 
		}
		
		if (select2 != null && !select2.trim().isEmpty()) {
		sql.append("AND ").append(select2).append(" "); 
		}
		
		
		if (filfe1 != null && filfe2 != null && !filfe1.trim().isEmpty() && !filfe2.trim().isEmpty()) {
			sql.append("AND fecha_actualizacion BETWEEN ? AND ? ");
			//params.add(filfe1);
			//params.add(filfe2);
			 try {   
			 parsedDate1 = sdf.parse(filfe1);
			 parsedDate2 = sdf.parse(filfe2);
			    
			    sqlDate1 = new java.sql.Date(parsedDate1.getTime());
			    sqlDate2 = new java.sql.Date(parsedDate2.getTime());
			   
			 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		if (filreg != null && !filreg.trim().isEmpty()) {
		sql.append(filreg);
		}
		sql.append(" ORDER BY cve_ent, cve_mun, cve_loc, cve_ageb, cve_mza");
		
		
		// Ejecutar la consulta
	try{ 
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql.toString());		
			ps.setQueryTimeout(3000);
			ps.setDate(1, sqlDate1);  // Índice dinámico
			ps.setDate(2, sqlDate2);
			    
			    
			 // Asignar parámetros dinámicos
	        //for (int i = 0; i < params.size(); i++) {
	        //    ps.setString(i + 1, (String) params.get(i));
	       // }

	        //System.out.println(ps.toString()); // Depende del driver
	        
			_rs = ps.executeQuery();
			   rs = RowSetProvider.newFactory().createCachedRowSet();
			   rs.populate(_rs);
			return rs;

	} catch (SQLException e) {
		e.printStackTrace();
	}
	
	finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
	return rs;
}


	// -----------------------------------------------------------------------------------
	
		public static CachedRowSet consulta_ac_ca22_03(String cnx, String basecon, String select1, 
	            String select2, String filfe1, String filfe2, String filent) {
		// Validar nombre de tabla
		if (!basecon.matches("^[a-zA-Z0-9_]+$")) {
		throw new IllegalArgumentException("Nombre de tabla inválido: " + basecon);
		}
		
		ResultSet _rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		CachedRowSet rs = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date parsedDate1;
		java.util.Date parsedDate2;
		java.sql.Date sqlDate1 = null;
		java.sql.Date sqlDate2 = null;
		
		 
		// Construir la consulta base
		StringBuilder sql = new StringBuilder(
		"select cveoper_tcar, cveoper_censor, cvegeo, cve_ent, cve_mun, cve_loc, cve_ageb, cve_mza, codigoact, fecha_actualizacion," +
		"case when geom is null then '0' else '1' end as geom,  status_tcar,nota from " + basecon + " " +
		"WHERE codigoact != 0 " +
		"AND estatus_en_paquete != '3' " +
		"AND estatus_en_paquete IS NOT NULL "
		);
		
		
		
		// Lista para parámetros del PreparedStatement
		//List<Object> params = new ArrayList<>();
		
		// Añadir condiciones dinámicamente
		if (select1 != null && !select1.trim().isEmpty()) {
		sql.append("AND ").append(select1).append(" "); // Ej: "AND campo = ?"
		//params.add(select1); // Si select2 es el valor para select1
		}
		
		if (select2 != null && !select2.trim().isEmpty()) {
		sql.append("AND ").append(select2).append(" "); // Ej: "AND campo = ?"
		//params.add(select2); // Si select2 es el valor para select1
		}
		
		
		if (filfe1 != null && filfe2 != null && !filfe1.trim().isEmpty() && !filfe2.trim().isEmpty()) {
			sql.append("AND fecha_actualizacion BETWEEN ? AND ? ");
			//params.add(filfe1);
			//params.add(filfe2);
			 try {   
			parsedDate1 = sdf.parse(filfe1);
		    parsedDate2 = sdf.parse(filfe2);
	   	    sqlDate1 = new java.sql.Date(parsedDate1.getTime());
		    sqlDate2 = new java.sql.Date(parsedDate2.getTime());
			 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		if (filent != null && !filent.trim().isEmpty()) {
		sql.append(filent);
		}
		sql.append(" ORDER BY cve_ent, cve_mun, cve_loc, cve_ageb, cve_mza");
		
		
		// Ejecutar la consulta
		try{ 
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql.toString());		
			ps.setQueryTimeout(3000);
			ps.setDate(1, sqlDate1);  // Índice dinámico
			ps.setDate(2, sqlDate2);
			    
			    
			 // Asignar parámetros dinámicos
	        //for (int i = 0; i < params.size(); i++) {
	        //    ps.setString(i + 1, (String) params.get(i));
	       // }
	
	        //System.out.println(ps.toString()); // Depende del driver
	        
			_rs = ps.executeQuery();
			   rs = RowSetProvider.newFactory().createCachedRowSet();
			   rs.populate(_rs);
			return rs;
	
			} catch (SQLException e) {
			e.printStackTrace();
			}
		
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
		
	// -----------------------------------------------------------------------------------
	
		public static CachedRowSet consulta_ac_ca22_04(String cnx, String basecon, String select1, 
	            String select2, String filfe1, String filfe2, String filreg) {
		// Validar nombre de tabla
		if (!basecon.matches("^[a-zA-Z0-9_]+$")) {
		throw new IllegalArgumentException("Nombre de tabla inválido: " + basecon);
		}
		
		ResultSet _rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		CachedRowSet rs = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date parsedDate1;
		java.util.Date parsedDate2;
		java.sql.Date sqlDate1 = null;
		java.sql.Date sqlDate2 = null;
		 
		// Construir la consulta base
		StringBuilder sql = new StringBuilder("select cveoper_tcar, cveoper_censor, cvegeo, cve_ent, cve_mun, cve_loc, cve_ageb, cve_mza, codigoact, fecha_actualizacion, " +
											  "case when geom is null then '0' else '1' end as geom,  status_tcar,nota from "+ basecon +
											  " where  codigoact!=0 and estatus_en_paquete !='3' and estatus_en_paquete is not null ");
		
		// Añadir condiciones dinámicamente
		if (select1 != null && !select1.trim().isEmpty()) {
		sql.append("AND ").append(select1).append(" "); 
		}
		
		if (select2 != null && !select2.trim().isEmpty()) {
		sql.append("AND ").append(select2).append(" "); 
		}
		
		
		if (filfe1 != null && filfe2 != null && !filfe1.trim().isEmpty() && !filfe2.trim().isEmpty()) {
			sql.append("AND fecha_actualizacion BETWEEN ? AND ? ");
			 try {   
			parsedDate1 = sdf.parse(filfe1);
		    parsedDate2 = sdf.parse(filfe2);
	   	    sqlDate1 = new java.sql.Date(parsedDate1.getTime());
		    sqlDate2 = new java.sql.Date(parsedDate2.getTime());
			 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		if (filreg != null && !filreg.trim().isEmpty()) {
		sql.append(filreg);
		}
		sql.append(" ORDER BY cve_ent, cve_mun, cve_loc, cve_ageb, cve_mza");
		
		
		// Ejecutar la consulta
		try{ 
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql.toString());		
			ps.setQueryTimeout(3000);
			ps.setDate(1, sqlDate1);  
			ps.setDate(2, sqlDate2);
	        //System.out.println(ps.toString()); // Depende del driver, da la consulta sql
	        
			_rs = ps.executeQuery();
			   rs = RowSetProvider.newFactory().createCachedRowSet();
			   rs.populate(_rs);
			return rs;
	
			} catch (SQLException e) {
			e.printStackTrace();
			}
		
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
	


		// -----------------------------------------------------------------------------------
		
		public static CachedRowSet consulta_ac_ca22_05(String cnx, String basecon, String select1, 
	            String select2, String filfe1, String filfe2, String filent) {
		// Validar nombre de tabla
		if (!basecon.matches("^[a-zA-Z0-9_]+$")) {
		throw new IllegalArgumentException("Nombre de tabla inválido: " + basecon);
		}
		
		ResultSet _rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		CachedRowSet rs = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date parsedDate1;
		java.util.Date parsedDate2;
		java.sql.Date sqlDate1 = null;
		java.sql.Date sqlDate2 = null;
		 
		// Construir la consulta base
		StringBuilder sql = new StringBuilder("select cveoper_tcar, cveoper_censor, cvegeo, cve_ent, cve_mun, cve_loc, cve_ageb, cve_mza, codigoact, fecha_actualizacion, " +
											  "case when geom is null then '0' else '1' end as geom,  status_tcar,nota from "+ basecon +
											  " where  codigoact!=0 and estatus_en_paquete !='3' and estatus_en_paquete is not null ");
		
		// Añadir condiciones dinámicamente
		if (select1 != null && !select1.trim().isEmpty()) {
		sql.append("AND ").append(select1).append(" "); 
		}
		
		if (select2 != null && !select2.trim().isEmpty()) {
		sql.append("AND ").append(select2).append(" "); 
		}
		
		
		if (filfe1 != null && filfe2 != null && !filfe1.trim().isEmpty() && !filfe2.trim().isEmpty()) {
			sql.append("AND fecha_actualizacion BETWEEN ? AND ? ");
			 try {   
			parsedDate1 = sdf.parse(filfe1);
		    parsedDate2 = sdf.parse(filfe2);
	   	    sqlDate1 = new java.sql.Date(parsedDate1.getTime());
		    sqlDate2 = new java.sql.Date(parsedDate2.getTime());
			 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		if (filent != null && !filent.trim().isEmpty()) {
		sql.append(filent);
		}
		sql.append(" ORDER BY cve_ent, cve_mun, cve_loc, cve_ageb, cve_mza");
		
		
		// Ejecutar la consulta
		try{ 
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql.toString());		
			ps.setQueryTimeout(3000);
			ps.setDate(1, sqlDate1);  
			ps.setDate(2, sqlDate2);
	        //System.out.println(ps.toString()); // Depende del driver, da la consulta sql
	        
			_rs = ps.executeQuery();
			   rs = RowSetProvider.newFactory().createCachedRowSet();
			   rs.populate(_rs);
			return rs;
	
			} catch (SQLException e) {
			e.printStackTrace();
			}
		
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
	

		
	// -----------------------------------------------------------------------------------
	
		
		public static CachedRowSet consulta_ac_ca22_06(String cnx, String basecon, String select1, 
	            String select2, String filfe1, String filfe2, String ent) {
		// Validar nombre de tabla
		if (!basecon.matches("^[a-zA-Z0-9_]+$")) {
		throw new IllegalArgumentException("Nombre de tabla inválido: " + basecon);
		}
		
		ResultSet _rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		CachedRowSet rs = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date parsedDate1;
		java.util.Date parsedDate2;
		java.sql.Date sqlDate1 = null;
		java.sql.Date sqlDate2 = null;
		 
		// Construir la consulta base
		StringBuilder sql = new StringBuilder("select cveoper_tcar, cveoper_censor, cvegeo, cve_ent, cve_mun, cve_loc, cve_ageb, cve_mza, codigoact, fecha_actualizacion, " +
											  "case when geom is null then '0' else '1' end as geom,  status_tcar,nota from "+ basecon +
											  " where  codigoact!=0 and estatus_en_paquete !='3' and estatus_en_paquete is not null ");
		
		// Añadir condiciones dinámicamente
		if (select1 != null && !select1.trim().isEmpty()) {
		sql.append("AND ").append(select1).append(" "); 
		}
		
		if (select2 != null && !select2.trim().isEmpty()) {
		sql.append("AND ").append(select2).append(" "); 
		}
		
		
		if (filfe1 != null && filfe2 != null && !filfe1.trim().isEmpty() && !filfe2.trim().isEmpty()) {
			sql.append("AND fecha_actualizacion BETWEEN ? AND ? ");
			 try {   
			parsedDate1 = sdf.parse(filfe1);
		    parsedDate2 = sdf.parse(filfe2);
	   	    sqlDate1 = new java.sql.Date(parsedDate1.getTime());
		    sqlDate2 = new java.sql.Date(parsedDate2.getTime());
			 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		if (ent != null && !ent.trim().isEmpty()) {
		sql.append(ent);
		}
		sql.append(" ORDER BY cve_ent, cve_mun, cve_loc, cve_ageb, cve_mza");
		
		
		// Ejecutar la consulta
		try{ 
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql.toString());		
			ps.setQueryTimeout(3000);
			ps.setDate(1, sqlDate1);  
			ps.setDate(2, sqlDate2);
	        //System.out.println(ps.toString()); // Depende del driver, da la consulta sql
	        
			_rs = ps.executeQuery();
			   rs = RowSetProvider.newFactory().createCachedRowSet();
			   rs.populate(_rs);
			return rs;
	
			} catch (SQLException e) {
			e.printStackTrace();
			}
		
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
	
	
	// -----------------------------------------------------------------------------------
	
		
		public static CachedRowSet consulta_ac_ca22_07(String cnx, String basecon, String loc, String filult) {
		// Validar nombre de tabla
		if (!basecon.matches("^[a-zA-Z0-9_]+$")) {
		throw new IllegalArgumentException("Nombre de tabla inválido: " + basecon);
		}
		
		ResultSet _rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		CachedRowSet rs = null;
		 
		// Construir la consulta base
		StringBuilder sql = new StringBuilder("select cveoper_tcar, cveoper_censor, cvegeo, cve_ent, cve_mun, cve_loc, cve_ageb, cve_mza, codigoact, fecha_actualizacion, " +
											  "case when geom is null then '0' else '1' end as geom,  status_tcar,nota from "+ basecon +
											  " where  codigoact!=0 and estatus_en_paquete !='3' and estatus_en_paquete is not null ");
		
		// Añadir condiciones dinámicamente
		if (loc != null && !loc.trim().isEmpty()) {
		sql.append("AND cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza like '").append(loc).append("' "); 
		}
		
		if (filult != null && !filult.trim().isEmpty()) {
		sql.append(filult).append(" "); 
		}
		
		sql.append(" ORDER BY cve_ent, cve_mun, cve_loc, cve_ageb, cve_mza");
		
		
		// Ejecutar la consulta
		try{ 
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql.toString());		
			ps.setQueryTimeout(3000);
		    //System.out.println(ps.toString()); // Depende del driver, da la consulta sql
	        
			_rs = ps.executeQuery();
			   rs = RowSetProvider.newFactory().createCachedRowSet();
			   rs.populate(_rs);
			return rs;
	
			} catch (SQLException e) {
			e.printStackTrace();
			}
		
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
		}
	
	// -----------------------------------------------------------------------------------
	
		public static CachedRowSet consulta_ac_ca22_08(String cnx, String basecon, String tcar, String filult) {
		// Validar nombre de tabla
		if (!basecon.matches("^[a-zA-Z0-9_]+$")) {
		throw new IllegalArgumentException("Nombre de tabla inválido: " + basecon);
		}
		
		ResultSet _rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		CachedRowSet rs = null;
		 
		// Construir la consulta base
		StringBuilder sql = new StringBuilder("select cveoper_tcar, cveoper_censor, cvegeo, cve_ent, cve_mun, cve_loc, cve_ageb, cve_mza, codigoact, fecha_actualizacion, " +
											  "case when geom is null then '0' else '1' end as geom,  status_tcar,nota from "+ basecon +
											  " where  codigoact!=0 and estatus_en_paquete !='3' and estatus_en_paquete is not null ");
		
		// Añadir condiciones dinámicamente
		if (tcar != null && !tcar.trim().isEmpty()) {
		sql.append(" AND cveoper_tcar like '").append(tcar).append("' "); 
		}
		
		if (filult != null && !filult.trim().isEmpty()) {
		sql.append(filult).append(" "); 
		}
		
		sql.append(" ORDER BY cve_ent, cve_mun, cve_loc, cve_ageb, cve_mza");
		
		
		// Ejecutar la consulta
		try{ 
			con = AdministradorDataSource_Sigma.getConnection(cnx);
			ps = con.prepareStatement(sql.toString());		
			ps.setQueryTimeout(3000);
		    //System.out.println(ps.toString()); // Depende del driver, da la consulta sql
	        
			_rs = ps.executeQuery();
			   rs = RowSetProvider.newFactory().createCachedRowSet();
			   rs.populate(_rs);
			return rs;
	
			} catch (SQLException e) {
			e.printStackTrace();
			}
		
			finally {if (con != null) {	try {con.close();} catch (SQLException e) {	e.printStackTrace();}};if (ps != null) {try {ps.close();} catch (SQLException e) {	e.printStackTrace();}};	if (_rs != null) {try {_rs.close();} catch (SQLException e) {e.printStackTrace();	}};}
			return rs;
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
	
	

	
	
}
