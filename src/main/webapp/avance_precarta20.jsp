<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
    <title>
SIGMA
</title>
<script>
function abre1(cve){
   ventana = window.open('avance_preedo_us.jsp?filedo='+cve,'Avance1','scrollbars=no,toolbar=no');
   ventana.focus();
}

function abre2(cve){
   ventana = window.open('avance_precarta20_carta.jsp?filedo='+cve,'Avance2','scrollbars=no,toolbar=no');
   ventana.focus();
}
</script>
<link rel="stylesheet" href="menu_reporte.css" type="text/css">
<body style="background:url('images/fondo1.jpg'); background-repeat: no-repeat; background-size: cover;">
<%

String consulta1 = "";

consulta1+="select cve_ent";
consulta1+=",case when c20 is null then 0 else c20 end as c20 ";
consulta1+=",case when cm is null then 0 else cm end as cm ";
consulta1+=",case when cf is null then 0 else cf end as cf ";
consulta1+=",case when nf is null then 0 else nf end as nf ";
consulta1+=",case when ce is null then 0 else ce end as ce ";
consulta1+=",area ";
consulta1+=",case when arep is null then 0 else arep end as arep ";
consulta1+=",case when areg is null then 0 else areg end as areg ";
consulta1+=",case when aoc is null then 0 else aoc end as aoc ";
consulta1+="from (select cve_ent ";
consulta1+=",(select count(*) from cat_cartas20 where st_intersects(geom,t1.the_geom)) as c20 ";
consulta1+=",(select count(*) from z_digmz_respaldo where cve_ent =t1.cve_ent) as cm ";
consulta1+=",(select count(*) from z_digf_respaldo where cve_ent =t1.cve_ent) as cf ";
consulta1+=",(select count(*) from z_digf_respaldo where nfr_noroe is null and cve_ent =t1.cve_ent) as nf ";
consulta1+=",(select count(*) from z_dige_respaldo where cve_ent =t1.cve_ent) as ce ";
consulta1+=",st_Area(the_geom) as area ";
consulta1+=",(select sum(st_area(st_transform(geom,32800))) from a_rep_cardig where cve_ent=t1.cve_ent group by the_geom) as arep ";
consulta1+=",(select sum(st_area(st_transform(geom,32800))) from a_rep_cardig where sup in (1,2) and cve_ent=t1.cve_ent group by the_geom) as areg ";
consulta1+=",(select sum(st_area(st_transform(geom,32800))) from a_rep_cardig where voc in (1,2) and cve_ent=t1.cve_ent group by the_geom) as aoc  ";
consulta1+="from cat_ent t1 where status=1 order by cve_ent ) c1 ";

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
      out.println("<center><font class='titulo'>Avance por estado y cartas involucradas</font><br><br>");
      out.println("<table border=1><tr class=titulo2><th>&nbsp;Entidad&nbsp;<th>&nbsp;Numero de cartas&nbsp;<br>&nbsp;20,000 involucradas&nbsp;<th>&nbsp;Manzanas&nbsp;<br>Cerradas<th>&nbsp;Frentes&nbsp;<br>&nbsp;Digitalizados&nbsp;<th>&nbsp;Frentes&nbsp;<br>&nbsp;sin manzana&nbsp;<th>&nbsp;Vialidades&nbsp;<br>&nbsp;Digitalizadas&nbsp;<th>&nbsp;Cubrimiento&nbsp;<br>&nbsp;reportado&nbsp;<th>&nbsp;Validado&nbsp;<br>&nbsp;Regional&nbsp;<th>&nbsp;Validado&nbsp;<br>&nbsp;Centrales&nbsp;");
      String cve_ent,c20,cf,ce,area,arep,areg,aoc,nf,cm;
      int sumc20=0;
      int sumcf=0;
      int sumcm=0;
      int sumnf=0;
      int sumce=0;
      double sumarea=0;
      double sumarep=0;
      double sumareg=0;
      double sumaoc=0;
      double a1=0;
      double a2=0;
      double a3=0;
      double a4=0;
      while(rs.next()){
        cve_ent=rs.getObject(1).toString();
        c20=rs.getObject(2).toString();
        cm=rs.getObject(3).toString();
        cf=rs.getObject(4).toString();
        nf=rs.getObject(5).toString();
        ce=rs.getObject(6).toString();
        area=rs.getObject(7).toString();
        arep=rs.getObject(8).toString();
        areg=rs.getObject(9).toString();
        aoc=rs.getObject(10).toString();
        sumc20+=Integer.parseInt(c20);
        sumcm+=Integer.parseInt(cm);
        sumcf+=Integer.parseInt(cf);
        sumnf+=Integer.parseInt(nf);
        sumce+=Integer.parseInt(ce);
        a1=Float.parseFloat(area);
        a2=Float.parseFloat(arep);
        a3=Float.parseFloat(areg);
        a4=Float.parseFloat(aoc);
        sumarea+=a1;
        sumarep+=a2;
        sumareg+=a3;
        sumaoc+=a4;
          out.println("<tr class=n2><td title='Ver avance por usuarios'><a href='#' onClick=\"abre1('"+cve_ent+"')\">"+cve_ent+"<td title='Ver avance por carta 20,000'><a href='#' onClick=\"abre2('"+cve_ent+"')\">"+c20+"<td>&nbsp;"+cm+"&nbsp;<td>&nbsp;"+cf+"&nbsp;<td>&nbsp;"+nf+"&nbsp;<td>&nbsp;"+ce+"&nbsp;");
          out.println("<td>"+Math.round((a2*100)/a1)+"%<td>"+Math.round((a3*100)/a1)+"%<td>"+Math.round((a4*100)/a1)+"%");
      }
      out.println("<tr class=n3><td colspan=2>TOTAL<td>"+sumcm+"<td>"+sumcf+"<td>"+sumnf+"<td>"+sumce+"<td>"+Math.round((sumarep*100)/sumarea)+"%<td>"+Math.round((sumareg*100)/sumarea)+"%<td>"+Math.round((sumaoc*100)/sumarea)+"%");
//out.println("</table><br><img src='http://dc046068asdggma.inegi.gob.mx:8070/geoserver/INEGI/wms?LAYERS=INEGI%3AESTADOS%2CINEGI%3Acartas5rep&TRANSPARENT=TRUE&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=&FORMAT=image%2Fpng&SRS=EPSG%3A900913&bbox=-1.3181079254380183E7,1635334.4672155518,-9652558.161913535,3858019.1970224283&WIDTH=2871&HEIGHT=1480' width=800 height=512></img>");
      str.close();
      conexion.close();

%></table>
</body>
</html>
