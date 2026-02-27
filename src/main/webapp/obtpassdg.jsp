<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>

<%
String  x = request.getParameter("x");

String consulta="";
try {
    consulta = "select a_convierte_escapehtml(passdg) from usuarios where userdg ='"+x+"'";
    //out.println (consulta);
    ResultSet rs = null;
    Statement str = null;
    Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://10.153.3.25:5434/actcargeo10","arcgis","arcgis");
    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    rs = str.executeQuery( consulta );
    rs.next();
    out.print(rs.getObject(1).toString());
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