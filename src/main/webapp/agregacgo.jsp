<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>

<%@ page import="javax.sql.rowset.*" %> 
<%@ page import="com.sun.rowset.CachedRowSetImpl" %>
<%@ page import="mx.org.inegi.Constructor_de_Consultas"%>

<%
String  id = request.getParameter("id");
String consulta="";
try {
	/*
	      consulta = "select a_agrega_cgo("+id+")";
	      ResultSet rs = null;
	      Statement str = null;
	      Connection conexion = null;
	      Class.forName("org.postgresql.Driver");
	      conexion = DriverManager.getConnection(
	                                             "jdbc:postgresql://10.153.3.25:5434/actcargeo10",
	                                             "actcar",
	                                             "actcar"
	                                            );
	    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
	    rs = str.executeQuery( consulta );
   */
   
   	CachedRowSet rs = null;
   	rs = Constructor_de_Consultas.consulta_agregacgo_01("act10", id); 
    
   	rs.next();
    String s1=rs.getObject(1).toString();
    out.println(s1);
    //str.close();
    //conexion.close();
    rs.close();
    rs = null;
    
    }
    catch (SQLException ex){
      out.println("-");
   }
      catch(Exception ex){
        out.println("-");
    }
%>
