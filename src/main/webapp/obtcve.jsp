<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
try {
String  clave = request.getParameter("clave");
String  tipo = request.getParameter("tipo");
String  cvemax = request.getParameter("cvemax");
if (cvemax == null || cvemax==""){
  cvemax="''";
}else{
  cvemax=cvemax.substring(1,cvemax.length());
}
     // out.print(cvemax);
String consulta="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();

if (tipo.equals("mza")){
      //consulta = "select max(cve_mza)::integer+1 from cat_manz where substring(cve_mza,1,1)!='T' and cve_ent||cve_mun||cve_loc||cve_ageb='"+clave+"'";
      consulta= "select LPAD(generate_series ::text, 3, '0')  as cve1 from generate_series(1,999) except (select cve_mza from cat_manz where cve_ent||cve_mun||cve_loc||cve_ageb='"+clave+"' union select right(cve,3) from (select unnest( array["+cvemax+"]) as cve) t1 where left(cve,14)='"+clave+"') order by cve1 limit 1";
}else if (tipo.equals("mzageo")){ //se obtiene la clave consecutiva siguiente por parte de la sobreposicion del centroide
      // se obtiene con el intersect sin revisar los huecos la maxima
      //consulta = "select cve_ent||cve_mun||cve_loc||cve_ageb||max(cve_mza)::integer+1 from cat_manz where substring(cve_mza,1,1)!='T' and cve_ent||cve_mun||cve_loc||cve_ageb=(select clave from (select cve_ent||cve_mun||cve_loc||cve_ageb as clave,1 as c from edit_ploc.edit_agebu where st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800)) union select cve_ent||cve_mun||cve_loc||cve_ageb as clave,2 as c from edit_ploc.edit_locr where st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800))) t1  order by c limit 1) group by cve_ent,cve_mun,cve_loc,cve_ageb";
     // puro intersets se obtiene el hueco  o la maxima 
      //consulta="select (select clave from (select cve_ent||cve_mun||cve_loc||cve_ageb as clave,1 as c from edit_ploc.edit_agebu where st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800)) union select cve_ent||cve_mun||cve_loc||cve_ageb as clave,2 as c from edit_ploc.edit_locr where st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800))) t1  order by c limit 1)||(select LPAD(generate_series ::text, 3, '0') as cve1 from generate_series(1,999) except (select cve_mza from cat_manz where cve_ent||cve_mun||cve_loc||cve_ageb=(select clave from (select cve_ent||cve_mun||cve_loc||cve_ageb as clave,1 as c from edit_ploc.edit_agebu where st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800)) union select cve_ent||cve_mun||cve_loc||cve_ageb as clave,2 as c from edit_ploc.edit_locr where st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800))) t1  order by c limit 1) union select right(cve,3) from (select unnest( array["+cvemax+"]) as cve) t1 where left(cve,14)=(select clave from (select cve_ent||cve_mun||cve_loc||cve_ageb as clave,1 as c from edit_ploc.edit_agebu where st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800)) union select cve_ent||cve_mun||cve_loc||cve_ageb as clave,2 as c from edit_ploc.edit_locr where st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800))) t1  order by c limit 1)) order by cve1 limit 1)";
      // este es el nuevo se obtiene del poligono o localidad mas cercano y busca huecos si no da la ultima
      consulta="select (select clave from (select cve_ent||cve_mun||cve_loc||cve_ageb as clave,1 as c,the_geom from edit_ploc.v_cat_au where st_dwithin(st_transform(ST_GeomFromText('"+clave+"',3857),32800),the_geom,10000) union select cve_ent||cve_mun||cve_loc||cve_ageb as clave,2 as c,the_geom from edit_ploc.v_cat_plr where st_dwithin(st_transform(ST_GeomFromText('"+clave+"',3857),32800),the_geom,10000)) t1 order by ST_Distance(st_transform(ST_GeomFromText('"+clave+"',3857),32800), the_geom) limit 1)||(select LPAD(generate_series ::text, 3, '0') as cve1 from generate_series(1,999) except (select cve_mza from cat_manz where cve_ent||cve_mun||cve_loc||cve_ageb=((select clave from (select cve_ent||cve_mun||cve_loc||cve_ageb as clave,1 as c,the_geom from edit_ploc.v_cat_au where st_dwithin(st_transform(ST_GeomFromText('"+clave+"',3857),32800),the_geom,10000) union select cve_ent||cve_mun||cve_loc||cve_ageb as clave,2 as c,the_geom from edit_ploc.v_cat_plr where st_dwithin(st_transform(ST_GeomFromText('"+clave+"',3857),32800),the_geom,10000)) t1 order by ST_Distance(st_transform(ST_GeomFromText('"+clave+"',3857),32800), the_geom) limit 1)) union select right(cve,3) from (select unnest( array["+cvemax+"]) as cve) t1 where left(cve,14)=  ((select clave from (select cve_ent||cve_mun||cve_loc||cve_ageb as clave,1 as c,the_geom from edit_ploc.v_cat_au where st_dwithin(st_transform(ST_GeomFromText('"+clave+"',3857),32800),the_geom,10000) union select cve_ent||cve_mun||cve_loc||cve_ageb as clave,2 as c,the_geom from edit_ploc.v_cat_plr where st_dwithin(st_transform(ST_GeomFromText('"+clave+"',3857),32800),the_geom,10000)) t1 order by ST_Distance(st_transform(ST_GeomFromText('"+clave+"',3857),32800), the_geom) limit 1)))   order by cve1 limit 1)";
            //out.print(consulta);

    }else if (tipo.equals("au")){
      //consulta = "select lpad((max(substring(cve_ageb,1,3))::integer+1)::text,3,'0') from edit_ploc.edit_agebu where cve_ent||cve_mun='"+clave.substring(0,5)+"'";
      consulta="select LPAD(generate_series ::text, 3, '0')  as cve1 from generate_series(1,999) except (select left(cve_ageb,3) from edit_ploc.edit_agebu where cve_ent||cve_mun='"+clave+"' union select left(cve_ageb,3) from cat_ageb where cve_ent||cve_mun='"+clave+"' union select substring(cve,6,3) from (select unnest( array["+cvemax+"]) as cve) t1 where left(cve,5)='"+clave+"') order by cve1 limit 1";
}else if (tipo.equals("pr")){
      String  geom = request.getParameter("geom");
            consulta = "select clave||cve_ageb from (SELECT cat_loc.clave, cat_loc.cve_ageb,the_geom FROM cat_loc WHERE status=1 and ambito='R' and NOT (cat_loc.clave::text IN ( SELECT bd_loc_pendientes.clave FROM bd_loc_pendientes)) UNION SELECT bd_loc_pendientes.clave, substring(ageb, 1, 3) || '-' || substring(ageb, 4, 1) AS cve_ageb,st_setsrid(st_point(ccl_x,ccl_y), 32800) AS the_geom  FROM bd_loc_pendientes WHERE status = 1 AND ambito = 'R') t1 where st_intersects(the_geom,st_transform(ST_GeomFromText('"+geom+"',3857),32800))";
}else if (tipo.equals("pe")){
      String  geom = request.getParameter("geom");
            consulta = "select clave from (SELECT cat_loc.clave,the_geom FROM cat_loc WHERE status=1 and ambito='R' and NOT (cat_loc.clave::text IN ( SELECT bd_loc_pendientes.clave FROM bd_loc_pendientes)) UNION SELECT bd_loc_pendientes.clave, st_setsrid(st_point(ccl_x,ccl_y),32800) AS the_geom  FROM bd_loc_pendientes WHERE status = 1 AND ambito = 'R') t1 where st_intersects(the_geom,st_transform(ST_GeomFromText('"+geom+"',3857),32800))";
}else if (tipo.equals("pesimplify")){
      String  geom = request.getParameter("geom");
            consulta = "SELECT cve_ent||cve_mun||cve_loc FROM edit_ploc.edit_pe WHERE ban <> ALL (ARRAY[3, 9, 4]) and st_intersects(the_geom,st_transform(ST_GeomFromText('"+geom+"',3857),32800))";
}else if (tipo.equals("codigoj")){
  consulta="select cve_ent||cve_mun||cve_loc||cve_ageb from edit_ploc.edit_agebu where ban=1 and st_intersects(the_geom,st_transform(ST_GeomFromText('"+clave+"',3857),32800)) limit 1";
}else if (tipo.equals("codigocj")){
  consulta="select cve_ent||cve_mun||cve_loc||cve_ageb from edit_ploc.edit_agebu where ban=1 and st_intersects(the_geom,st_buffer(st_transform(ST_GeomFromText('"+clave+"',3857),32800),1000)) order by st_distance(the_geom,(st_transform(ST_GeomFromText('"+clave+"',3857),32800))) limit 1";
}
//out.print(consulta);
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

if (tipo.equals("au")){   //obtengo el digito verificador
        String vale=clave.substring(0,2);
        String valm=clave.substring(2,5);
        String vala=rs.getObject(1).toString();
          int suma=0;
          suma = suma + Integer.parseInt(vale.substring(0,1)) * 7;
          suma = suma + Integer.parseInt(vale.substring(1,2)) * 6;
          suma = suma + Integer.parseInt(valm.substring(0,1)) * 5;
          suma = suma + Integer.parseInt(valm.substring(1,2)) * 4;
          suma = suma + Integer.parseInt(valm.substring(2,3)) * 3;
          suma = suma + Integer.parseInt(vala.substring(0,1)) * 2;
          suma = suma + Integer.parseInt(vala.substring(1,2)) * 7;
          suma = suma + Integer.parseInt(vala.substring(2,3)) * 6;
          int k =  suma%11;
          String dig="";
          if (k == 1){dig = "A";}
          if (k == 0){dig = "0";}
          if (k != 1 && k != 0){dig = Integer.toString(11 - k);}
          out.print(vala+"-"+dig);
}else{
    out.print(rs.getObject(1).toString());
}
    str.close();
    conexion.close();
   }
    catch (SQLException ex){
      out.print("0");
  }
      catch(Exception ex){
        out.print("0");
   }
%>