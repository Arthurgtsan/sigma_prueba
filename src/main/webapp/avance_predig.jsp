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
</script>
<link rel="stylesheet" href="menu_reporte.css" type="text/css">
<body style="background:url('images/fondo1.jpg'); background-repeat: no-repeat; background-size: cover;">
<%

String consulta1 = "select cve_ent,(select count(*) from respaldo_z_digmz where (cve_baja!='BCUU' or cve_baja is null) and cve_ent =t1.cve_ent) as cm, (select count(*) from respaldo_z_digpe where cve_ent =t1.cve_ent) as cf, (select count(*) from respaldo_z_digmp where cve_ent =t1.cve_ent) as ce from cat_ent t1 where status=1 ";

// (select count(*) from cat_loc where status=1 and ambito='U' and cve_ent=t1.cve_ent) as locu, (select count(distinct(clave)) from cat_loc t3,a_rep_cardig t2 where status=1 and t3.cve_ent=t2.cve_ent and ambito='U' and t3.cve_ent=t1.cve_ent and t2.cve_ent=t1.cve_ent and the_geom_pu && st_transform(geom,32800)) as locu_rep, (select count(*) from cat_loc where status=1 and ambito='R' and the_geom_pr is not null and cve_ent=t1.cve_ent) as locr, (select count(distinct(clave)) from cat_loc t3,a_rep_cardig t2 where status=1 and t3.cve_ent=t2.cve_ent and ambito='R' and the_geom_pr is not null and t3.cve_ent=t1.cve_ent and t2.cve_ent=t1.cve_ent and the_geom_pr && st_transform(geom,32800)) as locr_rep from cat_ent t1 where status=1 ";
//consulta1+= " and 1=0";

consulta1+= " order by cve_ent";
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
      out.println("<center><font class='titulo'>Avance por estado y localidades cubiertas</font><br><br>");
      //out.println("<table border=1><tr class=titulo2><th>&nbsp;Entidad&nbsp;<th>&nbsp;Manzanas&nbsp;<th>&nbsp;Frentes&nbsp;<th>&nbsp;Frentes&nbsp;<br>&nbsp;sin&nbsp;manzana&nbsp;<th>&nbsp;Vialidades&nbsp;<th>&nbsp;Loc&nbsp;<br>&nbsp;Urbanas&nbsp;<th>&nbsp;Loc&nbsp;Urbanas&nbsp;<br>&nbsp;reportadas&nbsp;<th>&nbsp;Loc&nbsp;Rurales&nbsp;<br>&nbsp;con&nbsp;manz&nbsp;<th>&nbsp;Loc&nbsp;Rurales&nbsp;<br>&nbsp;reportadas&nbsp;");
	  out.println("<table class=table border=1><tr class=titulo2><th>&nbsp;Entidad&nbsp;<th>&nbsp;Manzanas&nbsp;<th>&nbsp;Poligonos Externos&nbsp;<th>&nbsp;Puntos&nbsp;");
      String cve_ent,ce,cf,cm,lu1,lu2,lr1,lr2,nf;
      int sumcm=0;
      int sumcf=0;
      int sumnf=0;
      int sumce=0;
      int sumlu1=0;
      int sumlu2=0;
      int sumlr1=0;
      int sumlr2=0;
      while(rs.next()){
        cve_ent=rs.getObject(1).toString();
        cm=rs.getObject(2).toString();
        cf=rs.getObject(3).toString();
        nf=rs.getObject(4).toString();
        //ce=rs.getObject(5).toString();
        //lu1=rs.getObject(6).toString();
        //lu2=rs.getObject(7).toString();
        //lr1=rs.getObject(8).toString();
        //lr2=rs.getObject(9).toString();
        sumcm+=Integer.parseInt(cm);
        sumcf+=Integer.parseInt(cf);
        sumnf+=Integer.parseInt(nf);
        //sumce+=Integer.parseInt(ce);
        //sumlu1+=Integer.parseInt(lu1);
        //sumlu2+=Integer.parseInt(lu2);
        //sumlr1+=Integer.parseInt(lr1);
        //sumlr2+=Integer.parseInt(lr2);
          //out.println("<tr class=n2><td title='Ver avance por usuarios'><a href='#' onClick=\"abre1('"+cve_ent+"')\">"+cve_ent+"<td>&nbsp;"+cm+"&nbsp;<td>&nbsp;"+cf+"&nbsp;<td>"+nf+"<td>"+ce+"<td>"+lu1+"<td>"+lu2+"<td>"+lr1+"<td>"+lr2);
		  out.println("<tr class=n2><td title='Ver avance por usuarios'><a href='#' onClick=\"abre1('"+cve_ent+"')\">"+cve_ent+"<td>&nbsp;"+cm+"&nbsp;<td>&nbsp;"+cf+"&nbsp;<td>"+nf);
      }
      //out.println("<tr class=n3><td>TOTAL<td>&nbsp;"+sumcm+"&nbsp;<td>&nbsp;"+sumcf+"&nbsp;<td>"+sumnf+"<td>"+sumce+"<td>"+sumlu1+"<td>"+sumlu2+"<td>"+sumlr1+"<td>"+sumlr2);
	  out.println("<tr class=n3><td>TOTAL<td>&nbsp;"+sumcm+"&nbsp;<td>&nbsp;"+sumcf+"&nbsp;<td>"+sumnf);
//out.println("</table><br><img src='http://dc046068asdggma.inegi.gob.mx:8070/geoserver/INEGI/wms?LAYERS=INEGI%3AESTADOS%2CINEGI%3Acartas5rep&TRANSPARENT=TRUE&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=&FORMAT=image%2Fpng&SRS=EPSG%3A900913&bbox=-1.3181079254380183E7,1635334.4672155518,-9652558.161913535,3858019.1970224283&WIDTH=2871&HEIGHT=1480' width=800 height=512></img>");
      str.close();
      conexion.close();

%>
</table><br><br>
</body>
</html>
