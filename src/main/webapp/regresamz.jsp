<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
String  tipo = request.getParameter("tipo");
String  gid = request.getParameter("gid");
String consulta = "";
HttpSession sesion = request.getSession(true);
String remotehost  = session.getAttribute("remotehost").toString();
/*try {*/
if (tipo.equals("3")){
    consulta="select * from a_regresa_coord_cd("+tipo+","+gid+");";
}else{
    consulta="select * from a_regresa_coord_mz("+tipo+","+gid+");";
}
      ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      rs = str.executeQuery( consulta );
  	  rs.next();
      String s1=rs.getObject(1).toString();
      out.print(s1);
      str.close();
      conexion.close();
  /*  }
    catch (SQLException ex){
      out.print("1");
  }
      catch(Exception ex){
        out.print("1");
   }*/
%>