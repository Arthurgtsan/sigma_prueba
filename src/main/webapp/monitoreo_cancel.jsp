<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%

String  host = request.getParameter("host");
String  pid = request.getParameter("pid");
String  bd = request.getParameter("bd");
String usuario = request.getParameter("usuario");



    String consulta1 = "select pg_cancel_backend("+pid+")";

      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String ports="";
      String user="";
      String pass="";
      if (host.equals("localhost")){
        ports="5434";
        user="actcar";
        pass="actcar";
      }else{
          if (usuario.equals("arcgis")){
              ports="5434";
              user="arcgis";
              pass="arcgis";
          }else{
              ports="5434";
              user="actcar";
              pass="actcar";
          }
      }
      conexion = DriverManager.getConnection("jdbc:postgresql://"+host+":"+ports+"/"+bd,user,pass);

      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      rs = str.executeQuery( consulta1 );
      String val="0";
      while(rs.next()){
        val="1";
      }
        out.println(val);
      str.close();
      conexion.close();
%>