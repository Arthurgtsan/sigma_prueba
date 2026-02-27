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
window.resizeTo(1100,700);
</script>
<link rel="stylesheet" href="menu_reporte.css" type="text/css">
<body style="background:url('images/fondo1.jpg'); background-repeat: no-repeat; background-size: cover;">
<%
String  edo = request.getParameter("filedo");

String consulta1 = "select t1.carta ,";
consulta1+="(select count(*) from z_digmz_respaldo where cve_ent ='"+edo+"' and st_intersects(z_digmz_respaldo.geom,t1.geom)) as cm , ";
consulta1+="(select count(*) from z_digf_respaldo where cve_ent ='"+edo+"' and st_intersects(z_digf_respaldo.the_geom,t1.geom)) as cf , ";
consulta1+="(select count(*) from z_digf_respaldo   where nfr_noroe is null and cve_ent ='"+edo+"' and st_intersects(z_digf_respaldo.the_geom,t1.geom)) as nf, ";
consulta1+="(select count(*) from z_dige_respaldo where cve_ent ='"+edo+"' and st_intersects(z_dige_respaldo.the_geom,t1.geom)) as ce,";
consulta1+="st_Area(t1.geom) as area1,";
consulta1+="((sum(CASE WHEN 1=1        THEN st_area(st_transform(t2.geom,32800)) else 0 END))) as area2,";
consulta1+="((sum(CASE WHEN sup in (1,2) THEN st_area(st_transform(t2.geom,32800)) else 0 END))) as vreg,";
consulta1+="((sum(CASE WHEN voc in (1,2) THEN st_area(st_transform(t2.geom,32800)) else 0 END))) as voc,  ";
consulta1+="max(fact) as fact,pasada ";
consulta1+="from cat_cartas20 t1 left join a_rep_cardig t2 ";
consulta1+="on t1.carta=substring(t2.carta,1,7) where st_intersects((select the_geom from cat_ent where cve_ent='"+edo+"'),t1.geom)   ";
consulta1+="group by t1.carta,t1.geom,t1.pasada order by t1.carta";


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
      out.println("<center><font class='titulo'>Avance por carta 20,000 - Estado "+edo+" </font><br><br>");
            //out.println("<table border=1><tr class=titulo2><th>&nbsp;Carta&nbsp;<th>&nbsp;Frentes en manzanas&nbsp;<th>&nbsp;Frentes&nbsp;<br>&nbsp;sin&nbsp;manzana&nbsp;<th>&nbsp;Vialidades&nbsp;<th>&nbsp;Cubrimiento&nbsp;<th>&nbsp;Validado&nbsp;<br>&nbsp;Regional&nbsp;<th>&nbsp;Validado&nbsp;<br>&nbsp;Centrales&nbsp;<th>&nbsp;Ultima&nbsp;<br>&nbsp;Actividad&nbsp;<th>&nbsp;Numero de&nbsp;<br>&nbsp;pasadas&nbsp;");
      out.println("<table border=1><tr class=titulo2><th>&nbsp;Carta&nbsp;<th>&nbsp;Manzanas&nbsp;<br>Cerradas<th>&nbsp;Frentes&nbsp;<th>&nbsp;Frentes&nbsp;<br>&nbsp;sin&nbsp;manzana&nbsp;<th>&nbsp;Vialidades&nbsp;<th>&nbsp;Cubrimiento&nbsp;<th>&nbsp;Validado&nbsp;<br>&nbsp;Regional&nbsp;<th>&nbsp;Validado&nbsp;<br>&nbsp;Centrales&nbsp;<th>&nbsp;Ultima&nbsp;<br>&nbsp;Actividad&nbsp;<th>&nbsp;Numero de&nbsp;<br>&nbsp;pasadas&nbsp;<th><img src='images/s.png'></img>");
      
      String cve_ent,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11;
      int sum1=0;
      int sum2=0;
      int sum3=0;
      int sum4=0;
      int sum5=0;
      int sum6=0;
      int sum7=0;
      int sum8=0;
      int sum9=0;
      double prom1=0;
      double prom2=0;
      double prom3=0;
      double prom4=0;
      double f1=0;
      double f2=0;
      double f3=0;
      while(rs.next()){
        sum1=sum1+1;
        c1=rs.getObject(1).toString();
        c2=rs.getObject(2).toString();
        c3=rs.getObject(3).toString();
        c4=rs.getObject(4).toString();
        c5=rs.getObject(5).toString();
        c6=rs.getObject(6).toString();
        c7="0";
        if (rs.getString(7)!=null){
          c7=rs.getObject(7).toString();
        }
        c8=rs.getObject(8).toString();
        c9=rs.getObject(9).toString();
        c11=rs.getObject(11).toString();
        c10="0000-00-00";
        if (rs.getString(10)!=null){
          c10=rs.getObject(10).toString().substring(0,10);
        }
        prom1=Float.parseFloat(c6);
        prom2=Float.parseFloat(c7);
        prom3=Float.parseFloat(c8);
        prom4=Float.parseFloat(c9);
        if (prom2!=0){f1=(prom2*100)/prom1;}else{f1=0; }
        if (prom3!=0){f2=(prom3*100)/prom1;}else{f2=0; }
        if (prom4!=0){f3=(prom4*100)/prom1;}else{f3=0; }
        //out.println("<tr class=n2><td>&nbsp;"+c1+"&nbsp;<td>&nbsp;"+c3+" en "+c2+" manzanas&nbsp;<td>&nbsp;"+c4+"&nbsp;<td>&nbsp;"+c5+"&nbsp;<td>&nbsp;"+c6+"%&nbsp;");
        out.println("<tr class=n2><td>&nbsp;"+c1+"&nbsp;<td>&nbsp;"+c2+"&nbsp;<td>&nbsp;"+c3+"&nbsp;<td>&nbsp;"+c4+"&nbsp;<td>&nbsp;"+c5+"&nbsp;<td>&nbsp;"+Math.round(f1)+"%&nbsp;<td>&nbsp;"+Math.round(f2)+"%&nbsp;<td>&nbsp;"+Math.round(f3)+"%&nbsp;<td>&nbsp;"+c10+"&nbsp;<td>&nbsp;"+c11+"&nbsp;");
        if (Math.round(f1)<50){
          out.println("<td>&nbsp;<img src='images/3.png'></img>&nbsp;");
        }else if(Math.round(f1)<100){
          out.println("<td>&nbsp;<img src='images/2.png'></img>&nbsp;");
        }else{
          out.println("<td>&nbsp;<img src='images/1.png'></img>&nbsp;");
        }
      }
      //out.println("</table><br><img src='http://dc046068asdggma.inegi.gob.mx:8070/geoserver/INEGI/wms?LAYERS=INEGI%3APOLIGONOS_URBANOS%2CINEGI%3AESTADOS%2CINEGI%3Acartas5rep&TRANSPARENT=TRUE&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=&FORMAT=image%2Fpng&SRS=EPSG%3A900913&bbox="+xmin+","+ymin+","+xmax+","+ymax+"&width="+((int) val1)+"&height="+((int) val2)+"'></img>");
      str.close();
      conexion.close();

%>
</table>
<br>
</body>
</html>

