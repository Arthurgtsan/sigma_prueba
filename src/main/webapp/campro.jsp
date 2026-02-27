<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%

String  id = request.getParameter("id");
String  cgo = request.getParameter("cgo");
String consulta="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();

try {
     consulta = "Update cat_manz_modcar set proc=0,cve_def=null,fresp=null where proc not in (0,1) and cgo='"+cgo+"' and gid="+id;
      ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    str.executeUpdate( consulta );
    str.close();
    conexion.close();
    out.println("y");
    }
    catch (SQLException ex){
      out.println("x");
  }
      catch(Exception ex){
        out.println("x");
    }

%>
