<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%
String  id = request.getParameter("id");
String consulta="";
try {
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
    rs.next();
    String s1=rs.getObject(1).toString();
    out.println(s1);
    rs.close();
    str.close();
    conexion.close();
    }
    catch (SQLException ex){
      out.println("-");
   }
      catch(Exception ex){
        out.println("-");
    }
%>
