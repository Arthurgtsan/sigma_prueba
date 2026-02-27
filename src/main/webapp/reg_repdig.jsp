<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
try{
String  x = request.getParameter("x");
String  y = request.getParameter("y");
String  id = request.getParameter("id");
String  us = request.getParameter("us");
String consulta="";
String carta="";
String gid="";
String nivel="";
String voc="";

consulta = "select carta,gid,(select sup from a_rep_cardig where gid=t1.gid),(select voc from a_rep_cardig where gid=t1.gid),(select nivel from usuarios where cons="+us+") from cat_cartas5 t1 where st_intersects(geom,ST_SetSRID(ST_Point("+x+", "+y+"),32800)) limit 1";
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
    carta=rs.getObject(1).toString();
    gid=rs.getObject(2).toString();
    nivel=rs.getObject(5).toString();
    String con = "";
    String valor = "";
    if (rs.getObject(3) != null){ // si esta en la tabla
        voc=rs.getObject(4).toString();
        con=rs.getObject(3).toString();
        if (nivel.equals("1")){
            if (con.equals("0")){ // si no tiene respuesta del supervisor se borra
              consulta = "delete from a_rep_cardig where cve_ent='"+id+"' and sup=0 and voc=0 and gid="+gid;
              str.executeUpdate( consulta );
              out.print("0"+carta);
            }else if (con.equals("1")){ //validada
              out.print("S"+carta);
            }else{ //validada con error
              out.print("N"+carta);
            }
        }else if (nivel.equals("2")){
            if (con.equals("0")){
                valor="1";
                out.print("A"+carta);
            }else if (con.equals("1")){
                valor="2";
                out.print("B"+carta);
            }else if (con.equals("2")){
                valor="0";
                out.print("C"+carta);
            }
            consulta="update a_rep_cardig set sup="+valor+" where gid="+gid;
            str.executeUpdate( consulta );
        }else if (nivel.equals("3")){
            if (voc.equals("0")){
                valor="1";
                out.print("A"+carta);
            }else if (voc.equals("1")){
                valor="2";
                out.print("B"+carta);
            }else if (voc.equals("2")){
                valor="0";
                out.print("C"+carta);
            }
            consulta="update a_rep_cardig set voc="+valor+" where gid="+gid;
            str.executeUpdate( consulta );
        }
    }else{ // no esta en la tabla
        if (nivel.equals("1")){
            Calendar fecha = Calendar.getInstance();
            String fec="",m1="",d1="";
            if (fecha.get(Calendar.MONTH)<9)m1="0";
            if (fecha.get(Calendar.DATE)<10)d1="0";
            fec=fecha.get(Calendar.YEAR) + "-" + m1 + (fecha.get(Calendar.MONTH)+1) + "-" + d1 + fecha.get(Calendar.DATE);
            consulta = "insert into a_rep_cardig (gid,cve_ent,carta,us,fact,geom,rev) select gid,'"+id+"',carta,"+us+",'"+fec+"',st_transform(geom,3857),(select pasada from cat_cartas20 t3 where t3.carta=substring(t2.carta,1,7)) from cat_cartas5 t2 where gid="+gid+" and gid not in (select gid from a_rep_cardig)";
            str.executeUpdate( consulta );
            out.print("1"+carta);
        }else if (nivel.equals("2")){
            out.print("D"+carta);
        }else if (nivel.equals("3")){
            out.print("D"+carta);
        }
    }
    str.close();
    conexion.close();
    }
    catch (SQLException ex){
      out.print("x");
  }
      catch(Exception ex){
        out.print("x");
   }
%>