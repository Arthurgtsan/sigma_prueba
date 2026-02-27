<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
String  gid = request.getParameter("gid");
String consulta="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
try {
    consulta = "update te_fr set clave_def = '0',fact=null,obs=null  where gid="+gid;
    ResultSet rs = null;
    Statement str = null;
    Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    //rs = str.executeQuery( consulta );
    //rs.next();
    str.executeUpdate( consulta );
    out.print("0");
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

