<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
String  gid = request.getParameter("gid");
String  cgo = request.getParameter("cgo");
String  tip = request.getParameter("tip");
String  clave = request.getParameter("clave");
String  proc = request.getParameter("proc");
String consulta="";

HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();

Calendar fecha = Calendar.getInstance();
String m1="",d1="",fec1="";
if (fecha.get(Calendar.MONTH)<9)m1="0";   // supongo que el mes empieza por 0
if (fecha.get(Calendar.DATE)<10)d1="0";
fec1=fecha.get(Calendar.YEAR) + "-" + m1 + (fecha.get(Calendar.MONTH)+1) + "-" + d1 + fecha.get(Calendar.DATE);
try {
 if (cgo.equals("3")){
      if (tip.equals("3")){   //proyectada
			   consulta = "update cat_manz_modcar set cve_def='"+clave+"',proc=3,fresp='"+fec1+"' where cgo='3' and gid="+gid;
      }else{
         consulta = "update cat_manz_modcar set proc="+proc+",fresp='"+fec1+"' where cgo='3' and gid="+gid;
      }
  }else{
      if (tip.equals("3")){   //proyectada
         consulta = "update cat_manz_modcar set cve_def='"+clave+"',proc=3,fresp='"+fec1+"' where cgo!='3' and gid="+gid;
      }else{
         consulta = "update cat_manz_modcar set proc="+proc+",fresp='"+fec1+"' where cgo!='3' and gid="+gid;
      }
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
    out.println("1");
    }
    catch (SQLException ex){
      out.print("x");
  }
      catch(Exception ex){
        out.print("x");
   }
%>