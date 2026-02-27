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

function abre(){
 ventana = window.open('avance_act_mg.html','Reporte','toolbar=no,Resizable=1,scrollbars=1');
  ventana.focus();

}

</script>
<link rel="stylesheet" href="menu_reporte.css" type="text/css">
<!--<body style="background:url('images/fondo1.jpg'); background-repeat: no-repeat; background-size: cover;">-->
<body style="background:url('http://dc046068asdggma.inegi.gob.mx:8888/mgpob2019/images/fondo1.jpg'); background-repeat: no-repeat; background-size: cover;">
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
+"(select count(*) from respaldo_z_digmz t2 where (cve_baja!='BCUU' or cve_baja is null) and t2.cve_ent=t1.cve_ent "+fechapre+") as pre1, "
+"(select count(*) from respaldo_z_digpe t2 where t2.cve_ent=t1.cve_ent "+fechapre+") as pre2, "
+"(select count(*) from respaldo_z_digmp t2 where t2.cve_ent=t1.cve_ent "+fechapre+") as pre3, "
+"(select count(*)||','||sum(predig::integer)||','||sum(mza_pre::integer)||','||sum(actual::integer)||','||sum(mza_act::integer)||','||sum(mza_dig::integer) from rep_actualizacion t2 where t2.digital='0' and t2.cve_ent=t1.cve_ent) as c1, "
+"(select loc_bufer||','||loc_total||','||loc_por_30||','||loc_pre||','||loc_act||','||loc_dig from rep_loc_no_mza t2 where t2.cve_ent=t1.cve_ent) as c2, "
+"count(*) as total, "
+"max(vregs) as ValREG,"
+"max(vocs) as ValOC,"
+"(select count(*) from respaldo_te_mza_coord where substring(clave,1,2)=t1.cve_ent) as forma , "
+"(select count(*) from cat_loc_val_arcgis t2 where clave in (select distinct cve_ent||cve_mun||cve_loc from cat_manz where ambito='R') and t2.cve_ent=t1.cve_ent) as plan1 "
+"from "
+"(select cve_ent,count(case when voc='S' then voc END) OVER (PARTITION BY cve_ent) as vocS,"
+"count(case when vreg='S' then vreg END) OVER (PARTITION BY cve_ent) as vregS,"
+"count(case when vreg='R' then vreg END) OVER (PARTITION BY cve_ent) as vregR "
+"from cat_ent t1 left join (select * from (select * from respaldo_te_mza union select * from respaldo_te_mza_cd) t5) t2 on t1.cve_ent=t2.ent_ant or t1.cve_ent=t2.ent_Act "
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
      out.println("<form method=\"post\" name=\"enviar\"><center><font class='titulo'>Seguimiento de la Actualizacion Rural 2019</font><br>");



out.println("<br><img src='images\\versiones.png' width=20px height=20px onclick='abre();'></img>");
 out.println("<div style='position:absolute;left:0;right:0;margin-left:auto;margin-right:auto;'>");
out.println("<br><table border=1 class=table><tr class=titulo2>");
out.println("<th rowspan=4>&nbsp;Entidad&nbsp;");
out.println("<th colspan=3 bgcolor=#bed3f3>&nbsp;PRE-DIGITALIZACION EN BD&nbsp;<br>");
out.println("<th colspan=15 bgcolor=#ffffb3>&nbsp;AVANCE DE ACTUALIZACION&nbsp;");
out.println("<th colspan=4 bgcolor=#c2f0c2>&nbsp;TABLAS DE EQUIVALENCIA (TOTAL)&nbsp;");
out.println("<tr class=titulo2>");
out.println("<th colspan=3 bgcolor=#bed3f3>");
out.println("<input type=checkbox name=entrega <input type=checkbox name=entrega onclick='document.enviar.submit();' ");
if (entrega!=null){
 out.println (" checked ");
}
out.println("'>Posterior al 1ro de Febrero");
//--out.println("<th rowspan=2 bgcolor=#bed3f3>&nbsp;*&nbsp;Manzanas&nbsp;<br>&nbsp;pendientes&nbsp;<br>&nbsp;en campo&nbsp;");
//out.println("<th rowspan=2 bgcolor=#bed3f3>&nbsp;Actualizaciones&nbsp;<br>&nbsp;registradas&nbsp;<br>&nbsp;en SIGMA&nbsp;");
out.println("<th colspan=7 bgcolor=#ffffb3>&nbsp;Amanzanadas&nbsp;");
out.println("<th colspan=8 bgcolor=#ffffb3>&nbsp;Puntuales&nbsp;");
out.println("<th rowspan=3 bgcolor=#c2f0c2>&nbsp;Registros de&nbsp;<br>&nbsp;actualizacion&nbsp;");
//out.println("<th rowspan=3 bgcolor=#ffffb3>&nbsp;Registros de&nbsp;<br>&nbsp;actualizacion dentro de la&nbsp;<br>&nbsp;cobertura CE&nbsp;");
out.println("<th rowspan=3 bgcolor=#c2f0c2>&nbsp;Registros validados REG&nbsp;");
out.println("<th rowspan=3 bgcolor=#c2f0c2>&nbsp;Registros validados OC&nbsp;");
out.println("<th rowspan=3 bgcolor=#ffffff>&nbsp;Manzanas con cambios de forma&nbsp;");
out.println("<tr class=titulo2>");

out.println("<th rowspan=2 bgcolor=#bed3f3>&nbsp;Manzanas&nbsp;");
out.println("<th rowspan=2 bgcolor=#bed3f3>&nbsp;Poligonos Externos&nbsp;");
out.println("<th rowspan=2 bgcolor=#bed3f3>&nbsp;Puntos&nbsp;");
out.println("<th rowspan=2 bgcolor=#ffffb3>&nbsp;Locs&nbsp;<br>&nbsp;Planeadas&nbsp;");
out.println("<th rowspan=2 bgcolor=#ffffb3>&nbsp;% de Avance&nbsp;");
//out.println("<th rowspan=2 bgcolor=#ffffb3>&nbsp;Locs&nbsp;<br>&nbsp;Avance&nbsp;");
out.println("<th colspan=2 bgcolor=#ffffb3>&nbsp;Pre-Digitalizadas&nbsp;");
out.println("<th colspan=2 bgcolor=#ffffb3>&nbsp;En campo&nbsp;");
out.println("<th rowspan=2 bgcolor=#ffffb3>&nbsp;En SIGMA&nbsp;");
out.println("<th rowspan=2 bgcolor=#ffffb3>&nbsp;Total&nbsp;<br>&nbsp;Planeadas&nbsp;");

out.println("<th rowspan=2 bgcolor=#ffffb3>&nbsp;En&nbsp;Buffer&nbsp;");
out.println("<th rowspan=2 bgcolor=#ffffb3>&nbsp;Fuera&nbsp;<br>&nbsp;de&nbsp;Buffer&nbsp;");
out.println("<th rowspan=2 colspan=2 bgcolor=#ffffb3>&nbsp;Planeadas&nbsp;<br>>30%&nbsp;fuera&nbsp;<br>&nbsp;de&nbsp;Buffer&nbsp;");
out.println("<th rowspan=2 bgcolor=#ffffb3>&nbsp;Pre-digitalizadas&nbsp;");
out.println("<th rowspan=2 bgcolor=#ffffb3>&nbsp;En&nbsp;<br>&nbsp;campo&nbsp;");
out.println("<th rowspan=2 bgcolor=#ffffb3>&nbsp;En&nbsp;<br>&nbsp;SIGMA&nbsp;");

out.println("<tr class=titulo2>");
out.println("<th bgcolor=#ffffb3>&nbsp;Locs&nbsp;");
out.println("<th bgcolor=#ffffb3>&nbsp;Mzns&nbsp;");
out.println("<th bgcolor=#ffffb3>&nbsp;Locs&nbsp;");
out.println("<th bgcolor=#ffffb3>&nbsp;Mzns&nbsp;");



      String cve_ent;
      int t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19,t20;
      int sum1=0;int sum2=0;int sum3=0;int sum4=0;int sum5=0;int sum6=0;int sum7=0;int sum8=0;int sum9=0;int sum10=0;
      int sum11=0;int sum12=0;int sum13=0;int sum14=0;int sum15=0;int sum16=0;int sum17=0;int sum18=0;int sum19=0;int sum20=0;
      DecimalFormat formateador = new DecimalFormat("###,###");

      String arr1,arr2;
      String[] a1;
      String[] a2;
      double porc;
	  double porc2;

      while(rs.next()){
        cve_ent=rs.getObject(1).toString();
        t1=Integer.parseInt(rs.getObject(2).toString());
        t2=Integer.parseInt(rs.getObject(3).toString());
        t3=Integer.parseInt(rs.getObject(4).toString());

        arr1=rs.getObject(5).toString();
        arr2=rs.getObject(6).toString();
        a1 = arr1.split(",");
        a2 = arr2.split(",");

        t4=Integer.parseInt(a1[0]);
        t5=Integer.parseInt(a1[1]);
        t6=Integer.parseInt(a1[2]);
        t7=Integer.parseInt(a1[3]);
        t8=Integer.parseInt(a1[4]);
        t9=Integer.parseInt(a1[5]);

        t10=Integer.parseInt(a2[0]);
        t11=Integer.parseInt(a2[1]);
        t12=Integer.parseInt(a2[2]);


        porc = Math.round((t12*100)/t11);
		porc2 = Math.round((t7*100)/t4);

        t13=Integer.parseInt(a2[3]);
        t14=Integer.parseInt(a2[4]);
        t15=Integer.parseInt(a2[5]);

        t16=Integer.parseInt(rs.getObject(7).toString());
        t17=Integer.parseInt(rs.getObject(8).toString());
        t18=Integer.parseInt(rs.getObject(9).toString());
        t19=Integer.parseInt(rs.getObject(10).toString());
        t20=Integer.parseInt(rs.getObject(11).toString());

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
        sum18+=(t18);
        sum19+=(t19);
        sum20+=(t20);

//out.println("<tr class=n2>");
out.println("<tr onmouseover='this.style.background=\"#c0c0c0\"' onmouseout='this.style.background=\"\"' class=n2>");
out.println("<td>"+cve_ent+"");
out.println("<td>"+formateador.format(t1)+"");
out.println("<td>"+formateador.format(t2)+"");
out.println("<td>"+formateador.format(t3)+"");

out.println("<td bgcolor='#ffffb3'>"+formateador.format(t20)+"");
//out.println("<td bgcolor='#ffffb3'>"+formateador.format(t4)+"");
out.println("<td>"+formateador.format((t7*100)/t4)+"%&nbsp;"+"");
out.println("<td>"+formateador.format(t5)+"");
out.println("<td>"+formateador.format(t6)+"");
out.println("<td>"+formateador.format(t7)+"");
out.println("<td>"+formateador.format(t8)+"");
out.println("<td bgcolor='#ffff66'>"+formateador.format(t9)+"");
out.println("<td>"+formateador.format(t10+t12)+"");
out.println("<td>"+formateador.format(t10)+"");
out.println("<td>"+formateador.format(t11)+"");
out.println("<td bgcolor='#ffffb3' nowrap>"+formateador.format(t12)+"<td align=center>&nbsp;"+formateador.format(porc)+"%&nbsp;");
out.println("<td>"+formateador.format(t13)+"");
out.println("<td>"+formateador.format(t14)+"");
out.println("<td bgcolor='#ffff66'>"+formateador.format(t15)+"");
out.println("<td bgcolor='#9FF781'>"+formateador.format(t16)+"");
out.println("<td>"+formateador.format(t17)+"");
out.println("<td>"+formateador.format(t18)+"");
out.println("<td>"+formateador.format(t19)+"");

}
porc = (sum12*100)/sum11;
porc2 = (sum7*100)/sum4;
out.println("<tr class=n3>");
out.println("<td>TOTAL");
out.println("<td>"+formateador.format(sum1)+"");
out.println("<td>"+formateador.format(sum2)+"");
out.println("<td>"+formateador.format(sum3)+"");
out.println("<td>"+formateador.format(sum20)+"");
//out.println("<td>"+formateador.format(sum4)+"");
out.println("<td>"+formateador.format(porc2)+"%&nbsp;"+"");
out.println("<td>"+formateador.format(sum5)+"");
out.println("<td>"+formateador.format(sum6)+"");
out.println("<td>"+formateador.format(sum7)+"");
out.println("<td>"+formateador.format(sum8)+"");
out.println("<td>"+formateador.format(sum9)+"");
out.println("<td>"+formateador.format(sum10+sum12)+"");
out.println("<td>"+formateador.format(sum10)+"");
out.println("<td>"+formateador.format(sum11)+"");
out.println("<td>"+formateador.format(sum12)+"<td align=center>&nbsp;"+formateador.format(porc)+"%&nbsp;");
out.println("<td>"+formateador.format(sum13)+"");
out.println("<td>"+formateador.format(sum14)+"");
out.println("<td>"+formateador.format(sum15)+"");
out.println("<td>"+formateador.format(sum16)+"");
out.println("<td>"+formateador.format(sum17)+"");
out.println("<td>"+formateador.format(sum18)+"");
out.println("<td>"+formateador.format(sum19)+"");


  out.println("</table><br>");
  //out.println("<div align='center' style='position:absolute;left:0;right:0;margin-left:auto;margin-right:auto;top:300;opacity:0.3;'><center><img src='http://dc046068asdggma.inegi.gob.mx:8070/geoserver/INEGI/wms?LAYERS=INEGI%3AESTADOS%2CINEGI%3Aa_rep_mun&TRANSPARENT=TRUE&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=estados%2Ca_rep_mun_av&FORMAT=image%2Fpng&SRS=EPSG%3A900913&bbox=-1.3181079254380183E7,1635334.4672155518,-9652558.161913535,3858019.1970224283&WIDTH=2871&HEIGHT=1480' width=800 height=512></img></center></div>");


  //out.println("");
      str.close();
      conexion.close();

%>
<center><br>
  <a class=n2 href="http://dc046068asdggma.inegi.gob.mx:8888/mgpob2019/">Regresar...</a></center>
  </div></form>

</body>
</html>

