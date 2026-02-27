<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
//try{
String  x = request.getParameter("x");
String  y = request.getParameter("y");
String  id = request.getParameter("id");
String  us = request.getParameter("us");
String consulta="";
String cve_ent="";
String cve_mun="";
String bloque="";

      consulta = "select id,cve_ent,cve_mun,bloque from a_rep_mun where st_intersects(the_geom,ST_SetSRID(ST_Point("+x+", "+y+"),32800)) limit 1";
      ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      conexion = DriverManager.getConnection(
           "jdbc:postgresql://10.153.3.25:5434/actcargeo10",
           "actcar",
           "actcar"
          );
    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);

    //out.println(consulta);
    rs = str.executeQuery( consulta );
    rs.next();
    String gid=rs.getObject(1).toString();
    cve_ent=rs.getObject(2).toString();
    cve_mun=rs.getObject(3).toString();
    bloque=rs.getObject(4).toString();
    String con = "";
    String valor = "";
        if (bloque.equals("0")){ //no esta bloqueado
            consulta="update a_rep_mun set us="+us+",bloque=1 where id="+gid;
            out.print("1"+cve_ent+"-"+cve_mun);
            str.executeUpdate( consulta );
        }else if (bloque.equals("1")){ //no esta bloqueado
            consulta="update a_rep_mun set us="+us+",bloque=0 where id="+gid;
            out.print("0"+cve_ent+"-"+cve_mun);
            str.executeUpdate( consulta );
        }else{    //no esta en la planeacion ni tiene actualizacion 
            //consulta="update a_rep_mun set us="+us+",bloque=0 where id="+gid;
            out.print("1"+cve_ent+"-"+cve_mun);
        }
        str.close();
        conexion.close();
    /*}
    catch (SQLException ex){
      out.print("x");
  }
      catch(Exception ex){
        out.print("x");
   }*/
%>