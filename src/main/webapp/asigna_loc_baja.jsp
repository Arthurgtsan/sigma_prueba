<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
String  gid = request.getParameter("gid");
String consulta="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
try {
    consulta = "update cat_manz set vienede=(select substring(figura,1,1)||gid from mcc_poblacion.cat_manz_modcar where gid="+gid+") where cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza =(select cvegeo  from mcc_poblacion.cat_manz_modcar where gid="+gid+") and ban='3'";
    //out.println (consulta);
    ResultSet rs = null;
    Statement str = null;
    Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
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

