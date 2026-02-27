<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
String geom = request.getParameter("geom");
String  us = request.getParameter("us");
String  img = request.getParameter("img");
String  val = request.getParameter("val");
String  valfte = request.getParameter("valfte");
String  mapext = request.getParameter("mapext");
int tipo = Integer.parseInt(request.getParameter("tipo"));
//out.println(mapext);
String consulta = "";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
try {
     ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");

  str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
 if (tipo==1){  //de los 2, le damos prioridad a lo de inventario de mzan, luego predig
  consulta="do $$" +
            "begin "+
            "   update cat_manz set inv="+val+", inv_us="+us+", inv_img='"+img+"', inv_fte='"+valfte+"' where ambito='R' and (inv_img IS NULL OR inv_img <> '*') and st_intersects(the_geom,(SELECT st_transform(ST_GeomFromText('"+geom+"',3857),32800))) and ban not in ('X','3','1','5','6','Y','E','D','H','G','M','I','N','O','K','R','T','C') and the_geom && st_transform(ST_MakeEnvelope("+mapext+", 3857),32800); "+
            " if not found then "+
            "     update z_digmz set conviv="+val+" where st_intersects(the_geom,(SELECT st_transform(ST_GeomFromText('"+geom+"',3857),32800))) and the_geom && st_transform(ST_MakeEnvelope("+mapext+", 3857),32800);"+
            "     if not found then "+
            "         update z_digpe set conviv="+val+" where st_intersects(the_geom,(SELECT st_transform(ST_GeomFromText('"+geom+"',3857),32800))) and the_geom && st_transform(ST_MakeEnvelope("+mapext+", 3857),32800); "+
            "     end if; "+
            "end if; "+
            "end $$;";

}else if(tipo==2){  //solo predigitalizado, prioridad a las manzanas
  consulta="do $$" +
            "begin "+
            "   update z_digmz set conviv="+val+" where st_intersects(the_geom,(SELECT st_transform(ST_GeomFromText('"+geom+"',3857),32800))) and the_geom && st_transform(ST_MakeEnvelope("+mapext+", 3857),32800);"+
            " if not found then "+
            "     update z_digpe set conviv="+val+" where st_intersects(the_geom,(SELECT st_transform(ST_GeomFromText('"+geom+"',3857),32800))) and the_geom && st_transform(ST_MakeEnvelope("+mapext+", 3857),32800); "+
            "end if; "+
            "end $$;";
}else if (tipo==3){   //solo inventario para maznanas
  consulta="update cat_manz set inv="+val+", inv_us="+us+", inv_img='"+img+"', inv_fte='"+valfte+"' where ambito='R' and (inv_img IS NULL OR inv_img <> '*') and st_intersects(the_geom,(SELECT st_transform(ST_GeomFromText('"+geom+"',3857),32800))) and ban not in ('X','3','1','5','6','Y','E','D','H','G','M','I','N','O','K','R','T','C') and the_geom && st_transform(ST_MakeEnvelope("+mapext+", 3857),32800)";
}

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

