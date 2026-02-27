<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DecimalFormat"%>
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
    <title>
SIGMA
</title>
<script language='javascript' src="popcalendar.js"></script>
<script>

function ver(fecha) {
  ventana = window.open('avance_vermapa.jsp?fecha='+fecha,'Ver','scrollbars=no,toolbar=no');
  ventana.focus();
    }

</script>
<link rel="stylesheet" href="menu_reporte.css" type="text/css">
<!--<body style="background:url('images/fondo1.jpg'); background-repeat: no-repeat; background-size: cover;">-->
<body style="">
<%

Calendar fecha = Calendar.getInstance();
String m1="",d1="",fec1="",fec2="",filfe2="",filentrega="",filentrega2="",filentrega1="";
if (fecha.get(Calendar.MONTH)<9)m1="0";   // supongo que el mes empieza por 0
if (fecha.get(Calendar.DATE)<10)d1="0";
fec2=fecha.get(Calendar.YEAR) + "-" + m1 + (fecha.get(Calendar.MONTH)+1) + "-" + d1 + fecha.get(Calendar.DATE);
filfe2 = request.getParameter("filfe2");
String entrega = request.getParameter("entrega");
String fechapre="";
if (entrega!=null){
  //filentrega=" and fact>='2018-08-06' ";
  //filentrega1=" and fresp>='2018-08-06' ";
  //filentrega2=" and f_registro>='2018-08-06' ";
  fechapre=" and fact>='2019-02-01' ";
}
//filfe1 += " 00:00:00";
if (filfe2==null)filfe2=fec2;
filfe2 += " 23:59:59";


String consulta1 = "select cve_ent,"
+"(select count(*) from respaldo_z_digmz t2 where (cve_baja!='BCUU' or cve_baja is null) and t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as pre1, "
+"(select count(*) from respaldo_z_digpe t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as pre2, "
+"(select count(*) from respaldo_z_digmp t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as pre3, "
+"(select count(*) from rep_avance.mz_predig_sin_act t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as faltantes, "  //pendientes de clave
+"(select count(*) from rep_avance.mz_predig t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as enact, "  //pendientes de clave
+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and (status=1 or status=4) and f_registro<='"+filfe2+"' "+filentrega2+") as modcar1, "
+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and status=2 and figura='CENSOR' and f_registro<='"+filfe2+"' "+filentrega2+") as modcar2, "
+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and status=3 and f_registro<='"+filfe2+"' "+filentrega2+") as modcar3, "
+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and proc>0 and fresp<='"+filfe2+"' "+filentrega2+") as modcar3, "
+"count(*) as total, "
+"(select count(*) from (select * from respaldo_te_mza union select * from respaldo_te_mza_cd) t2 where (t1.cve_ent=t2.ent_ant or t1.cve_ent=t2.ent_act) and (ent_ant||mun_ant||loc_ant in (select cve from a_cob_ce19_definitivo) or ent_act||mun_act||loc_act in (select cve from a_cob_ce19_definitivo)) and fact<='"+filfe2+"' "+filentrega+") as te_cober,  "
+"max(vocs) as ValOC,"
+"max(vregs) as ValREG,"
+"(select count(*) from respaldo_te_mza_coord where substring(clave,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as forma,  "
+"(select count(*) from rep_avance.mz_descargadas_arcgis t2 where substring(t2.cve_geo,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as desc, "
+"(select count(*) from rep_avance.mz_descargadas_arcgis t2, manz_afect_todas t3 where cve_geo=cvegeo_def and substring(t2.cve_geo,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as desc_mcc, "
+"(select count(*) from rep_avance.mz_descargadas_arcgis t2, manz_afect_todas t3 where cve_geo=cvegeo_def and substring(t2.cve_geo,1,2)=t1.cve_ent and substring(cve_geo,1,5) in (select distinct cve_geo from rep_avance.mz_arcgis where substring(cve_geo,1,2)=t1.cve_ent) and fact<='"+filfe2+"' "+filentrega+") as mz_val "


/*

+"max(vocs) as ValOC,"
+"max(vocr) as RetOC,"
//+"max(vocn) as SinOC,"
+"max(vregs) as ValREG,"
+"max(vregr) as RetREG,"
//+"max(vregn) as SinREG,"
+"(select count(*) from rep_avance.mz_arcgis_av t2 where substring(cve_geo,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as arcgis,  "
+"(select count(*) from respaldo_te_mza_coord where substring(clave,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as forma,  "
+"(select count(*) from respaldo_manz_bcu t2 where t2.cve_ent=t1.cve_ent and proc = 1 and fresp<='"+filfe2+"' "+filentrega1+") as bcu1,"
+"(select count(*) from respaldo_manz_bcu t2 where t2.cve_ent=t1.cve_ent and proc > 1 and fresp<='"+filfe2+"' "+filentrega1+") as bcu2,"
+"(select count(*) from respaldo_manz_bcu t2 where t2.cve_ent=t1.cve_ent and (proc = 0 or fresp>'"+filfe2+"' ) ) as bcu3, "
+"(select count(*) from cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and proc=0 and f_registro<='"+filfe2+"' "+filentrega2+") as modcar, "
+"(select count(*) from rep_avance.mz_predig_faltanencampo t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as falcampo, "
+"(select count(*) from rep_avance.mz_avance t2 where substring(t2.cve_geo,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as avance, "
+"(select count(*) from rep_avance.mz_nuevas t2 where substring(t2.cve_geo,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as news " */
+"from "
+"(select cve_ent,count(case when voc='S' then voc END) OVER (PARTITION BY cve_ent) as vocS,"
//+"count(case when voc='R' then voc END) OVER (PARTITION BY cve_ent) as vocR,"
//+"count(case when voc='N' then voc END) OVER (PARTITION BY cve_ent) as vocN,"
+"count(case when vreg='S' then vreg END) OVER (PARTITION BY cve_ent) as vregS,"
+"count(case when vreg='R' then vreg END) OVER (PARTITION BY cve_ent) as vregR "
//+",count(case when vreg='N' then vreg END) OVER (PARTITION BY cve_ent) as vregN "
+"from cat_ent t1 left join (select * from (select * from respaldo_te_mza union select * from respaldo_te_mza_cd) t5 where fact<='"+filfe2+"' "+filentrega+") t2 on t1.cve_ent=t2.ent_ant or t1.cve_ent=t2.ent_Act "
+"where status=1  order by t1.cve_ent) t1 group by cve_ent";
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
      //out.println(consulta1);
      rs = str.executeQuery( consulta1 );
      out.println("<form method=\"post\" name=\"enviar\"><center><font class='titulo'>Avance por Estado</font><br>");


      out.println("<div style='position:absolute;left:0;right:0;margin-left:auto;margin-right:auto;'>");
out.println("<table border=0 width=900px><tr><td align=left><img title='Ver en mapa' onclick='ver(\""+filfe2+"\");' border='0' src='images/map2.png' border=0 width=20></img><td align=center class=boton><!--<input type=checkbox name=entrega onclick='document.enviar.submit()'");
if (entrega!=null){
  out.println (" checked ");
}
  out.println(">Registros posterior a la entrega de planeacion --> <td align=right><input class='boton' name='filfe2' type='text' id='p1id' onClick=\"popUpCalendar(this, enviar.p1id, 'yyyy-mm-dd');\" size='10' readOnly value='"+filfe2.substring(0,10)+"'>&nbsp;&nbsp;<input class='boton' type=submit value='Ir'></table>");
out.println(" <table border=1 class=table><tr class=titulo2>");
out.println("<th rowspan=3>&nbsp;Entidad&nbsp;");
out.println("<th colspan=5 bgcolor=#bed3f3>&nbsp;ACTUALIZACION RURAL&nbsp;");
out.println("<input type=checkbox name=entrega <input type=checkbox name=entrega onclick='document.enviar.submit();' ");
if (entrega!=null){
 out.println (" checked ");
}
out.println("'>Posterior al 1ro de Febrero");
out.println("<th colspan=5 bgcolor=#ffffb3>&nbsp;ACTUALIZACION CENSOS ECONOMICOS&nbsp;");
out.println("<th colspan=5 bgcolor=#c2f0c2>&nbsp;TABLAS DE EQUIVALENCIA&nbsp;");
out.println("<th colspan=3 bgcolor=#FAD056>&nbsp;VALIDACION EN SIVEC (ARCGIS)&nbsp;");
out.println("<tr class=titulo2>");
out.println("<th colspan=3 bgcolor=#bed3f3>&nbsp;Pre-Digitalizacion&nbsp;");
out.println("<th rowspan=2 bgcolor=#bed3f3>&nbsp;*&nbsp;Manzanas&nbsp;<br>&nbsp;pendientes&nbsp;<br>&nbsp;en campo&nbsp;");
out.println("<th rowspan=2 bgcolor=#bed3f3>&nbsp;Actualizaciones&nbsp;<br>&nbsp;registradas&nbsp;<br>&nbsp;en SIGMA&nbsp;");
out.println("<th colspan=4 bgcolor=#ffffb3>&nbsp;Actualizaciones reportadas desde MCC&nbsp;");
out.println("<th rowspan=2 bgcolor=#ffffb3>&nbsp;Actualizaciones&nbsp;<br>&nbsp;registradas&nbsp;<br>&nbsp;en SIGMA&nbsp;");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Registros de&nbsp;<br>&nbsp;actualizacion&nbsp;");
out.println("<th rowspan=2 bgcolor=#ffffb3>&nbsp;Registros de&nbsp;<br>&nbsp;actualizacion dentro de la&nbsp;<br>&nbsp;cobertura CE&nbsp;");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Registros validados OC&nbsp;");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Registros validados REG&nbsp;");
out.println("<th rowspan=2 bgcolor=#ffffff>&nbsp;Manzanas con cambios de forma&nbsp;");
out.println("<th rowspan=2 bgcolor=#FAD056>&nbsp;Manzanas descargadas de SIGMA&nbsp;");
out.println("<th rowspan=2 bgcolor=#ffffb3>&nbsp;Manzanas descargadas&nbsp;<br>&nbsp;dentro de la&nbsp;<br>&nbsp;cobertura CE&nbsp;");
out.println("<th rowspan=2 bgcolor=#FAD056>&nbsp;Manzanas descargadas (cobertura) validadas en SIVEC&nbsp;");

out.println("<tr class=titulo2>");
out.println("<th bgcolor=#bed3f3>&nbsp;Manzanas&nbsp;");
out.println("<th bgcolor=#bed3f3>&nbsp;Poligonos Externos&nbsp;");
out.println("<th bgcolor=#bed3f3>&nbsp;Localidades Puntuales&nbsp;");
out.println("<th bgcolor=#ffffb3>&nbsp;Aceptada&nbsp;");
out.println("<th bgcolor=#ffffb3>&nbsp;Aceptada&nbsp;<br>&nbsp;con&nbsp;cambios&nbsp;");
out.println("<th bgcolor=#ffffb3>&nbsp;Rechazadas&nbsp;");
out.println("<th bgcolor=#ffffb3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      String cve_ent;
      int t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18;
      int sum1=0;int sum2=0;int sum3=0;int sum4=0;int sum5=0;int sum6=0;int sum7=0;int sum8=0;int sum9=0;int sum10=0;
      int sum11=0;int sum12=0;int sum13=0;int sum14=0;int sum15=0;int sum16=0;int sum17=0;int sum18=0;
      DecimalFormat formateador = new DecimalFormat("###,###");
      while(rs.next()){
        cve_ent=rs.getObject(1).toString();
        t1=Integer.parseInt(rs.getObject(2).toString());
        t2=Integer.parseInt(rs.getObject(3).toString());
        t3=Integer.parseInt(rs.getObject(4).toString());
        t4=Integer.parseInt(rs.getObject(5).toString());
        t5=Integer.parseInt(rs.getObject(6).toString());
        t6=Integer.parseInt(rs.getObject(7).toString());
        t7=Integer.parseInt(rs.getObject(8).toString());
        t8=Integer.parseInt(rs.getObject(9).toString());
        t9=Integer.parseInt(rs.getObject(10).toString());
        t10=Integer.parseInt(rs.getObject(11).toString());
        t11=Integer.parseInt(rs.getObject(12).toString());
        t12=Integer.parseInt(rs.getObject(13).toString());
        t13=Integer.parseInt(rs.getObject(14).toString());
        t14=Integer.parseInt(rs.getObject(15).toString());
        t15=Integer.parseInt(rs.getObject(16).toString());
        t16=Integer.parseInt(rs.getObject(17).toString());
        t17=Integer.parseInt(rs.getObject(18).toString());
        //t14=Integer.parseInt(rs.getObject(15).toString());
        //t15=Integer.parseInt(rs.getObject(16).toString());
        //t16=Integer.parseInt(rs.getObject(17).toString());
        //t17=Integer.parseInt(rs.getObject(18).toString());
        //t18=Integer.parseInt(rs.getObject(19).toString());
        sum1+=(t1);
        sum2+=(t2);
        sum3+=(t3);
        sum4+=(t4);
        sum5+=(t5);
        sum6+=(t6);
        sum7+=(t7);
        sum8+=(t8);
        sum9+=(t9);
        sum10+=(t10);
        sum11+=(t11);
        sum12+=(t12);
        sum13+=(t13);
        sum14+=(t14);
        sum15+=(t15);
        sum16+=(t16);
        sum17+=(t17);
        //sum15+=(t15);
        //sum16+=(t16);
        //sum17+=(t17);
        //sum18+=(t18);

//out.println("<tr class=n2>");
out.println("<tr onmouseover='this.style.background=\"#c0c0c0\"' onmouseout='this.style.background=\"\"' class=n2>");
out.println("<td>"+cve_ent+"");
out.println("<td>"+formateador.format(t1)+"");
out.println("<td>"+formateador.format(t2)+"");
out.println("<td>"+formateador.format(t3)+"");
out.println("<td bgcolor='#66ccff'>"+formateador.format(t4)+"");
out.println("<td>"+formateador.format(t5)+"");

//out.println("<td bgcolor='#FF33F0'>"+formateador.format(t14)+""); //MCC
out.println("<td bgcolor=''>"+formateador.format(t6)+"");
out.println("<td bgcolor=''>"+formateador.format(t7)+"");
//out.println("&nbsp;&nbsp;("+formateador.format(t7)+")");

out.println("<td>"+formateador.format(t8)+"");
out.println("<td>"+formateador.format(t6+t7+t8)+"");

out.println("<td bgcolor='#ffff66'>"+formateador.format(t9)+"");
out.println("<td bgcolor='#9FF781'>"+formateador.format(t10)+"");
out.println("<td>"+formateador.format(t11)+"");
out.println("<td>"+formateador.format(t12)+"");
out.println("<td>"+formateador.format(t13)+"");
out.println("<td>"+formateador.format(t14)+"");
out.println("<td>"+formateador.format(t15)+"");
out.println("<td>"+formateador.format(t16)+"");
out.println("<td >"+formateador.format(t17)+"");   
}

out.println("<tr class=n3>");
out.println("<td>TOTAL");
out.println("<td>"+formateador.format(sum1)+"");
out.println("<td>"+formateador.format(sum2)+"");
out.println("<td>"+formateador.format(sum3)+"");
out.println("<td>"+formateador.format(sum4)+"");
out.println("<td>"+formateador.format(sum5)+"");
out.println("<td>"+formateador.format(sum6)+"");
out.println("<td>"+formateador.format(sum7)+"");
out.println("<td>"+formateador.format(sum8)+"");
out.println("<td>"+formateador.format(sum6+sum7+sum8)+"");
out.println("<td>"+formateador.format(sum9)+"");
out.println("<td>"+formateador.format(sum10)+"");
out.println("<td>"+formateador.format(sum11)+"");
out.println("<td>"+formateador.format(sum12)+"");
out.println("<td>"+formateador.format(sum13)+"");
out.println("<td>"+formateador.format(sum14)+"");
out.println("<td>"+formateador.format(sum15)+"");
out.println("<td>"+formateador.format(sum16)+"");
out.println("<td>"+formateador.format(sum17)+"");
//out.println("<td>"+formateador.format(sum15)+"");
//out.println("&nbsp;&nbsp;("+formateador.format(sum16)+")");   //manzanas en registros

//out.println("<td>"+formateador.format(sum13));
  out.println("</table><font class=c align=left> "
  + "* <font style='background-color: #66ccff'><b>Manzanas pendientes de campo</b></font>, son las manzanas pre-digitalizadas que no intersectan con manzanas en <font style='background-color:#9FF781'><b>registros de actualizacion</b></font> (la diferencia es espacial)"
  + "</font><br><br></div>");
  //out.println("<div align='center' style='position:absolute;left:0;right:0;margin-left:auto;margin-right:auto;top:300;opacity:0.3;'><center><img src='http://dc046068asdggma.inegi.gob.mx:8070/geoserver/INEGI/wms?LAYERS=INEGI%3AESTADOS%2CINEGI%3Aa_rep_mun&TRANSPARENT=TRUE&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=estados%2Ca_rep_mun_av&FORMAT=image%2Fpng&SRS=EPSG%3A900913&bbox=-1.3181079254380183E7,1635334.4672155518,-9652558.161913535,3858019.1970224283&WIDTH=2871&HEIGHT=1480' width=800 height=512></img></center></div>");

out.println("</form>");

  //out.println("");
      str.close();
      conexion.close();

%>

</body>
</html>
