<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%

String  gid = request.getParameter("gid");
String  cgo = request.getParameter("cgo");
String  val = request.getParameter("val");
String consulta="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();

try {
    if (cgo.substring(0,1).equals("F")){
        consulta = "Update te_mza_coord_fr set motivo="+val+" where oid="+gid;
    }else{
        consulta = "Update te_mza set motivo="+val+" where oid="+gid;
    }
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
    out.println("0");
    }
    catch (SQLException ex){
      out.println("1");
  }
      catch(Exception ex){
        out.println("1");
    }

%>
