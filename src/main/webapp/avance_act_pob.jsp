<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DecimalFormat"%>
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
    <title>
SIGMA
</title>
<script language='javascript' src="popcalendar.js"></script>
<style>
.titulo{ font-family: Arial, Helvetica, sans-serif; font-size: 18px; font-style: normal; line-height: normal; font-weight: bold; font-variant: normal; text-transform: none; color: #000000; text-indent: 10pt; text-align: center; white-space: nowrap; height: 14px; border-style: none}
.titulo2{ color:#000000; font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-style: normal; line-height: normal; font-weight: bold; text-align: center; }
.n{font-family: Arial;  text-align: center; font-size: 10pt; line-height: 1.3;}
.n0{font-family: Arial;  text-align: center; font-size: 8pt; line-height: 1.3;}
.n1{font-family: Arial;  text-align: left; font-size: 12px; line-height: 1.3; font-weight: bold;color: #000000;}
.n2{font-family: Arial;  text-align: center; font-size: 14px; line-height: 1.3; font-weight: bold;color: #000000;}
.n3{font-family: Arial;  text-align: center; font-size: 12px; line-height: 1.3; font-weight: bold;color: #000000; background-color: #D8D8D8;}
.n4{font-family: Arial;  text-align: center; font-size: 12px; line-height: 1.3; font-weight: bold; color: #999999;}
.boton{font-family: Verdana,sans-serif;  text-align: center; font-size: 10px; line-height: 1.3; font-weight: normal;}

.t{font-family: Arial;  text-align: center; font-size: 18px; line-height: 1.3; font-weight: bold;color: #000000;}
a:link {color: black; }
a:visited {color: black;}
a:hover {color: #FFFFFF; background-color: #000000}
.aa{font-family: Arial; font-size: 12px; font-weight: bold;text-decoration:underline}
.aa1{font-family: Arial; font-size: 14px; font-weight: bold;text-decoration:underline}
.fecha{font-family: Arial; font-size: 14px; font-weight: bold;text-decoration:underline}

table {
  border-collapse: collapse;
}
table1 {
  font-size:100%;
  font-family:inherit;
  border-top:1.0pt solid ;
  border-right:1.0pt solid ;
  border-bottom:1.0pt solid ;
  border-left:1.0pt solid ;
  color:#00002
}

table1 {
  font-size:100%;
  font-family:inherit;

}


td{
  padding: 3px;
}

th{
  padding: 5px;
}

</style>

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

String consulta1 = "select cve_ent,0,0,0,0,0,"
//+"(select count(*) from respaldo_z_digmz t2 where (cve_baja!='BCUU' or cve_baja is null) and t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as pre1, "
//+"(select count(*) from respaldo_z_digpe t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as pre2, "
//+"(select count(*) from respaldo_z_digmp t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as pre3, "
//+"(select count(*) from rep_avance.mz_predig_sin_act t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as faltantes, "  //pendientes de clave
//+"(select count(*) from rep_avance.mz_predig t2 where t2.cve_ent=t1.cve_ent and fact<='"+filfe2+"' "+fechapre+") as enact, "  //pendientes de clave
+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and figura='CENSOR' and (status=1 or status=0 or status=7) and f_registro<='"+filfe2+"' "+filentrega2+") as modcar1, "
+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and figura='CENSOR' and status=2 and f_registro<='"+filfe2+"' "+filentrega2+") as modcar2, "
+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and figura='CENSOR' and status in (3,4,5,6,8,9) and f_registro<='"+filfe2+"' "+filentrega2+") as modcar3, "
+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and (fresp<='"+filfe2+"' "+filentrega2+" and(proc!=0) or status=0 or cgo='46')) as ensigma, "
+"count(*) as total, "
+"(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and figura='TCAR' and f_registro<='"+filfe2+"' "+filentrega2+") as modcar34, "
//+"(select count(*) from (select * from respaldo_te_mza union select * from respaldo_te_mza_cd) t2 where (t1.cve_ent=t2.ent_ant or t1.cve_ent=t2.ent_act) and (ent_ant||mun_ant||loc_ant in (select cve from a_cob_ce19_definitivo) or ent_act||mun_act||loc_act in (select cve from a_cob_ce19_definitivo)) and fact<='"+filfe2+"' "+filentrega+") as te_cober,  "
+"max(vocs) as ValOC,"
+"max(vregs) as ValREG, "
+"(select count(*) from respaldo_te_mza_coord where substring(clave,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as forma,  "
+"(select count(*) from rep_avance.mz_descargadas_arcgis t2 where substring(t2.cve_geo,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as desc, 0,"
//+"(select count(*) from rep_avance.mz_descargadas_arcgis t2 where substring(t2.cve_geo,1,2)=t1.cve_ent and fact<='"+filfe2+"' "+filentrega+") as desc_mcc, "
+"(select count(*) from rep_avance.mz_descargadas_arcgis t2 where substring(t2.cve_geo,1,2)=t1.cve_ent and substring(cve_geo,1,5) in (select distinct cve_geo from rep_avance.mz_arcgis where substring(cve_geo,1,2)=t1.cve_ent) and fact<='"+filfe2+"' "+filentrega+") as mz_val "


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
      out.println("<form method=\"post\" name=\"enviar\"><br><CENTER CLASS=T ALIGN=CENTER>Avance de la Actualizaci&oacute;n Cartogr&aacute;fica a la fecha: <input class='boton' name='filfe2' type='text' id='p1id' onClick=\"popUpCalendar(this, enviar.p1id, 'yyyy-mm-dd');\" size='10' readOnly value='"+filfe2.substring(0,10)+"'>&nbsp;&nbsp;<input class='boton' type=submit value='Ir'>");
out.println("<br><br><center><table border=1 class=table><tr class=titulo2>");
out.println("<th rowspan=3 bgcolor=#dadeda>&nbsp;Entidad&nbsp;");
out.println("<th colspan=6 bgcolor=#3aad2a>&nbsp;ACTUALIZACION POBLACION&nbsp;");
out.println("<th colspan=4 bgcolor=#c2f0c2>&nbsp;TABLAS DE EQUIVALENCIA&nbsp;");
out.println("<th colspan=3 bgcolor=#FAD056>&nbsp;VALIDACION EN SIVEC (ARCGIS)&nbsp;");
out.println("<tr class=titulo2>");
//out.println("<th colspan=3 bgcolor=#bed3f3>&nbsp;Pre-Digitalizacion&nbsp;");
//out.println("<th rowspan=2 bgcolor=#bed3f3>&nbsp;*&nbsp;Manzanas&nbsp;<br>&nbsp;pendientes&nbsp;<br>&nbsp;en campo&nbsp;");
//out.println("<th rowspan=2 bgcolor=#bed3f3>&nbsp;Actualizaciones&nbsp;<br>&nbsp;registradas&nbsp;<br>&nbsp;en SIGMA&nbsp;");
out.println("<th colspan=5 bgcolor=#3aad2a>&nbsp;Actualizaciones&nbsp;<br>reportadas<br>&nbsp;desde MCC&nbsp;");
out.println("<th rowspan=2 bgcolor=#3aad2a>&nbsp;Actualizaciones&nbsp;<br>&nbsp;registradas o&nbsp;<br>relacionadas<br>&nbsp;en SIGMA&nbsp;");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Registros de&nbsp;<br>&nbsp;actualizacion&nbsp;");
//out.println("<th rowspan=2 bgcolor=#3aad2a>&nbsp;Registros de&nbsp;<br>&nbsp;actualizacion dentro de la&nbsp;<br>&nbsp;cobertura CE&nbsp;");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Registros&nbsp;<br>validados<br>&nbsp;OC&nbsp;");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Registros&nbsp;<br>validados<br>&nbsp;REG&nbsp;");
out.println("<th rowspan=2 bgcolor=#ffffff>&nbsp;Registros&nbsp;<br>cambios<br>&nbsp;de forma&nbsp;");
//out.println("<th rowspan=2 bgcolor=#FAD056>&nbsp;Manzanas descargadas de SIGMA&nbsp;");
out.println("<th rowspan=2 bgcolor=#FAD056>&nbsp;Manzanas&nbsp;<br> descargadas<br> &nbsp;en ARCIGS");
out.println("<th rowspan=2 bgcolor=#FAD056>&nbsp;Manzanas&nbsp;<br> validadas<br> &nbsp;en SIVEC&nbsp;");


out.println("<tr class=titulo2>");
//out.println("<th bgcolor=#bed3f3>&nbsp;Manzanas&nbsp;");
//out.println("<th bgcolor=#bed3f3>&nbsp;Poligonos Externos&nbsp;");
//out.println("<th bgcolor=#bed3f3>&nbsp;Localidades Puntuales&nbsp;");
out.println("<th bgcolor=#3aad2a>&nbsp;Aceptada&nbsp;");
out.println("<th bgcolor=#3aad2a>&nbsp;Aceptada&nbsp;<br>&nbsp;con&nbsp;cambios&nbsp;");
out.println("<th bgcolor=#3aad2a>&nbsp;Rechazadas&nbsp;");
out.println("<th bgcolor=#3aad2a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
out.println("<th bgcolor=#3aad2a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TCAR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      String cve_ent;
      String imprimir="";
      int t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18;
      int sum1=0;int sum2=0;int sum3=0;int sum4=0;int sum5=0;int sum6=0;int sum7=0;int sum8=0;int sum9=0;int sum10=0;
      int sum11=0;int sum12=0;int sum13=0;int sum14=0;int sum15=0;int sum16=0;int sum17=0;int sum18=0;
      DecimalFormat formateador = new DecimalFormat("###,###");
      int colorfila=0;
      String color="";
while(rs.next()){
      if (colorfila==0){
        color= "#FAFAFA";
        colorfila=1;
      }else{
        color="";
        colorfila=0;
      }
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
        imprimir+=("<tr onmouseover='this.style.background=\"#c0c0c0\"' onmouseout='this.style.background=\""+color+"\"' class=n align=center bgcolor='"+color+"'>");

        imprimir+=("<td>"+cve_ent+"");
        //imprimir+=("<td>"+formateador.format(t1)+"");
        //imprimir+=("<td>"+formateador.format(t2)+"");
        //imprimir+=("<td>"+formateador.format(t3)+"");
        //imprimir+=("<td bgcolor='#66ccff'>"+formateador.format(t4)+"");
        //imprimir+=("<td>"+formateador.format(t5)+"");

        //imprimir+=("<td bgcolor='#FF33F0'>"+formateador.format(t14)+""); //MCC
        imprimir+=("<td bgcolor=''>"+formateador.format(t6)+"");
        imprimir+=("<td bgcolor=''>"+formateador.format(t7)+"");
        //imprimir+=("&nbsp;&nbsp;("+formateador.format(t7)+")");

        imprimir+=("<td>"+formateador.format(t8)+"");
        imprimir+=("<td>"+formateador.format(t6+t7+t8)+"");

        imprimir+=("<td>"+formateador.format(t11)+""); // <-- actualizaciones del TCAR

        imprimir+=("<td bgcolor='#3aad2a'>"+formateador.format(t9)+"");


        imprimir+=("<td bgcolor='#9FF781'>"+formateador.format(t10)+"");

        imprimir+=("<td>"+formateador.format(t12)+"");
        imprimir+=("<td>"+formateador.format(t13)+"");
        imprimir+=("<td>"+formateador.format(t14)+"");
        imprimir+=("<td>"+formateador.format(t15)+"");
        //imprimir+=("<td>"+formateador.format(t16)+"");
        imprimir+=("<td >"+formateador.format(t17)+"");
}

    out.println("<tr class=n2 align=center style='background-color:#3aad2a;'><td>TOTAL");
//out.println("<td>"+formateador.format(sum1)+"");
//out.println("<td>"+formateador.format(sum2)+"");
//out.println("<td>"+formateador.format(sum3)+"");
//out.println("<td>"+formateador.format(sum4)+"");
//out.println("<td>"+formateador.format(sum5)+"");
out.println("<td>"+formateador.format(sum6)+"");
out.println("<td>"+formateador.format(sum7)+"");
out.println("<td>"+formateador.format(sum8)+"");
out.println("<td>"+formateador.format(sum6+sum7+sum8)+"");

out.println("<td>"+formateador.format(sum11)+"");  //TCAR

out.println("<td bgcolor='#3aad2a'>"+formateador.format(sum9)+"");

out.println("<td bgcolor='#9FF781'>"+formateador.format(sum10)+"");

out.println("<td>"+formateador.format(sum12)+"");
out.println("<td>"+formateador.format(sum13)+"");
out.println("<td>"+formateador.format(sum14)+"");
out.println("<td>"+formateador.format(sum15)+"");
//out.println("<td>"+formateador.format(sum16)+"");
out.println("<td>"+formateador.format(sum17)+"");
out.println(imprimir);

//out.println("<td>"+formateador.format(sum15)+"");
//out.println("&nbsp;&nbsp;("+formateador.format(sum16)+")");   //manzanas en registros

//out.println("<td>"+formateador.format(sum13));
  out.println("</table><font class=c align=left> <br>");
  //out.println("<div align='center' style='position:absolute;left:0;right:0;margin-left:auto;margin-right:auto;top:300;opacity:0.3;'><center><img src='http://dc046068asdggma.inegi.gob.mx:8070/geoserver/INEGI/wms?LAYERS=INEGI%3AESTADOS%2CINEGI%3Aa_rep_mun&TRANSPARENT=TRUE&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=estados%2Ca_rep_mun_av&FORMAT=image%2Fpng&SRS=EPSG%3A900913&bbox=-1.3181079254380183E7,1635334.4672155518,-9652558.161913535,3858019.1970224283&WIDTH=2871&HEIGHT=1480' width=800 height=512></img></center></div>");

out.println("</form>");

  //out.println("");
      str.close();
      conexion.close();

%>

</body>
</html>
