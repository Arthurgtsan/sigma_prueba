<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>

<%@ page import="javax.sql.rowset.*" %> 
<%@ page import="com.sun.rowset.CachedRowSetImpl" %>
<%@ page import="mx.org.inegi.Constructor_de_Consultas2"%>


<%

String  id = request.getParameter("id");
String  val = request.getParameter("val");
String consulta="";

try {

/*
      consulta = "Update te_loc_coord set fact='"+val+"' where gid="+id;
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
    str.executeUpdate( consulta );
    str.close();
    conexion.close();
*/

	Constructor_de_Consultas2.consulta_camfe("act10_ed", val, id);
    out.println("y");
    
  
    }
    catch (SQLException ex){
      out.println("x");
  }
      catch(Exception ex){
        out.println("x");
    }

%>
