<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
String  tipo = request.getParameter("tipo");
String  clave = request.getParameter("clave");
String  pass = request.getParameter("pass");
String consulta = "";
try {
	   consulta="select * from a_regresa_coord('"+clave+"',"+tipo+");";
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
	  rs.next();
    out.print("2");
    str.close();
    conexion.close();
    }
    catch (SQLException ex){
      out.print("1");
  }
      catch(Exception ex){
        out.print("1");
   }
%>