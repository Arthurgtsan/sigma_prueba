<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
String  geom = request.getParameter("geom");
String  val = request.getParameter("val");
String  us = request.getParameter("us");
String  img = request.getParameter("img");
String  tipo = request.getParameter("tipo");
String consulta = "";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
try {
if (tipo.equals("1")){
      consulta="update z_digmz set proc="+val+" where st_intersects(the_geom,(SELECT st_transform(ST_GeomFromText('"+geom+"',3857),32800)))";
  }else{
     //consulta="update cat_manz_modcar set proc="+val+",fresp=CURRENT_TIMESTAMP(0) where tipo='BCUU' and st_intersects(geom,(SELECT st_transform(ST_GeomFromText('"+geom+"',3857),32800)))";
     consulta="update act_cu.bcu_bd_manzana set proc="+val+",fresp=CURRENT_TIMESTAMP(0) where substring(tip_act,1,1) in ('1','2','4','F','3') and proc!=1 and st_intersects(geom,(SELECT st_transform(ST_GeomFromText('"+geom+"',3857),32800)))";
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
      out.print("1");
  }
      catch(Exception ex){
        out.print("1");
   }
%>
