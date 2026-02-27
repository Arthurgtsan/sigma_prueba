<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
    <title>
SIGMA
</title>
<style type="text/css">
table {
  border-collapse: collapse;
}
.t{font-family: Arial; font-size: 14pt; font-weight: bold; color: #000000;text-align : center;}
.c{font-family: Arial; font-size: 10pt; line-height: 1.3; font-weight: normal;text-align : center;}
.n{font-family: Arial; font-size: 10pt; line-height: 1.3; font-weight: bold;text-align : center;}


</style>
<script language="javascrpt" type="text/javascript">
window.resizeTo(900,700);
</script>
<link rel="stylesheet" href="menu_reporte.css" type="text/css">
<body style="background:url('images/fondo1.jpg'); background-repeat: no-repeat; background-size: cover;">
<%
String  edo = request.getParameter("filedo");
String consulta1 = "select cve_ent, (select count(*) from respaldo_z_digmz where cve_ent ='"+edo+"') as cm, (select count(*) from z_digpe_respaldo where cve_ent ='"+edo+"') as cf,(select count(*) from z_digpe_respaldo where cve_ent ='"+edo+"') as ce, (select count(*) from cat_loc where status=1 and ambito='U' and cve_ent='"+edo+"') as locu, (select count(distinct(clave)) from cat_loc t3,a_rep_cardig t2 where status=1 and t3.cve_ent='"+edo+"' and t2.cve_ent='"+edo+"' and ambito='U' and t3.cve_ent='"+edo+"' and t1.cve_ent='"+edo+"' and t2.cve_ent='"+edo+"' and t1.cve_ent='"+edo+"' and the_geom_pu && st_transform(geom,32800)) as locu_rep, (select count(*) from cat_loc where status=1 and ambito='R' and the_geom_pr is not null and cve_ent='"+edo+"') as locr, (select count(distinct(clave)) from cat_loc t3,a_rep_cardig t2 where status=1 and t3.cve_ent='"+edo+"' and t2.cve_ent='"+edo+"' and ambito='R' and the_geom_pr is not null and t3.cve_ent='"+edo+"' and t1.cve_ent='"+edo+"' and t2.cve_ent='"+edo+"' and t1.cve_ent='"+edo+"' and the_geom_pr && st_transform(geom,32800)) as locr_rep, ST_XMax(st_transform(the_geom,3857)),ST_YMax(st_transform(the_geom,3857)),ST_XMin(st_transform(the_geom,3857)), ST_YMin(st_transform(the_geom,3857)),st_distance(ST_MakePoint(st_xmin(the_geom),st_ymin(the_geom)),ST_MakePoint(st_xmax(the_geom),st_ymin(the_geom))) as distx,  st_distance(ST_MakePoint(st_xmin(the_geom),st_ymin(the_geom)),ST_MakePoint(st_xmin(the_geom),st_ymax(the_geom))) as disty from (select cve_ent,ST_Envelope((ST_Dump(the_geom)).geom) as the_geom  from cat_ent where cve_ent='"+edo+"' and status=1 order by st_area(ST_Envelope((ST_Dump(the_geom)).geom)) desc limit 1) t1";




//out.println(consulta1);
      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
       conexion = DriverManager.getConnection(
                                             "jdbc:postgresql://10.153.3.25:5434/actcargeo10",
                                             "actcar",
                                             "actcar"
                                            );
      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      rs = str.executeQuery( consulta1 );
      out.println("<center><font class='titulo'>Avance pre-digitalizacion</font><br><br>");
      out.println("<table border=1><tr class=titulo2><th>&nbsp;Entidad&nbsp;<th>&nbsp;Frentes en manzanas&nbsp;<th>&nbsp;Frentes&nbsp;<br>&nbsp;sin&nbsp;manzana&nbsp;<th>&nbsp;Vialidades&nbsp;<th>&nbsp;Loc&nbsp;<br>&nbsp;Urbanas&nbsp;<th>&nbsp;Loc&nbsp;Urbanas&nbsp;<br>&nbsp;reportadas&nbsp;<th>&nbsp;Loc&nbsp;Rurales&nbsp;<br>&nbsp;con&nbsp;manz&nbsp;<th>&nbsp;Loc&nbsp;Rurales&nbsp;<br>&nbsp;reportadas&nbsp;");
      String cve_ent,nf,ce,cf,cm,lu1,lu2,lr1,lr2,xmax="",ymax="",xmin="",ymin="";
      double val1=0;
      double val2=0;
      double val=0;
      while(rs.next()){
        cve_ent=rs.getObject(1).toString();
        cm=rs.getObject(2).toString();
        cf=rs.getObject(3).toString();
        nf=rs.getObject(4).toString();
        ce=rs.getObject(5).toString();
        lu1=rs.getObject(6).toString();
        lu2=rs.getObject(7).toString();
        lr1=rs.getObject(8).toString();
        lr2=rs.getObject(9).toString();
        xmax=rs.getObject(10).toString();
        ymax=rs.getObject(11).toString();
        xmin=rs.getObject(12).toString();
        ymin=rs.getObject(13).toString();
        val1=Float.parseFloat(rs.getString(14))/400;
        val2=Float.parseFloat(rs.getString(15))/400;
        val=val1;
        if (val2<val1){
          val=val2;
        }
        val1=Math.floor(Float.parseFloat(rs.getString(14))/val);
        val2=Math.floor(Float.parseFloat(rs.getString(15))/val);
        out.println("<tr class=n2><td title='Ver avance por usuarios'><a href=\"avance_preedo_us.jsp?filedo="+cve_ent+"\">"+cve_ent+"</a><td>&nbsp;"+cf+" en "+cm+" manzanas&nbsp;<td>"+nf+"<td>"+ce+"<td>"+lu1+"<td>"+lu2+"<td>"+lr1+"<td>"+lr2);
      }
out.println("</table><br><img src='http://dc046068asdggma.inegi.gob.mx:8070/geoserver/INEGI/wms?LAYERS=INEGI%3APOLIGONOS_URBANOS%2CINEGI%3AESTADOS%2CINEGI%3Acartas5rep&TRANSPARENT=TRUE&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=&FORMAT=image%2Fpng&SRS=EPSG%3A900913&bbox="+xmin+","+ymin+","+xmax+","+ymax+"&width="+((int) val1)+"&height="+((int) val2)+"'></img>");
      str.close();
      conexion.close();

%>
</body>
</html>
