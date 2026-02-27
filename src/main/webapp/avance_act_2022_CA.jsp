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

  fechapre=" and fact>='2019-02-01' ";
}

if (filfe2==null)filfe2=fec2;
filfe2 += " 23:59:59";

String consulta1 = "select cve_ent,"; 
consulta1 += "(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and proc=1 ) as modcar1,";
consulta1 += "(select count(*) from mcc_poblacion.cat_manz_modcar t2 where t2.cve_ent=t1.cve_ent and proc=2 ) as modcar2, ";
consulta1 += "count(*) as total, 0,";
consulta1 += "max(vocs) as ValOC,";
consulta1 += "max(vregs) as ValREG, ";
consulta1 += "(select count(*) from respaldo_te_mza_coord where substring(clave,1,2)=t1.cve_ent) as forma,";
consulta1 += "max(cod4) as cod4, ";
consulta1 += "max(cod2) as cod2,";
consulta1 += "max(cod1) as cod1, ";
consulta1 += "max(cod3) as cod3 ";
consulta1 += "from ";
consulta1 += "(select cve_ent,count(case when voc='S' then voc END) OVER (PARTITION BY cve_ent) as vocS,";
consulta1 += "count(case when vreg='S' then vreg END) OVER (PARTITION BY cve_ent) as vregS,";
consulta1 += "count(case when vreg='R' then vreg END) OVER (PARTITION BY cve_ent) as vregR, ";
consulta1 += "count(case when t2.cgo_act in ('4','B','A') then t2.cgo_act END) OVER (PARTITION BY cve_ent) as cod4, ";
consulta1 += "count(case when t2.cgo_act='2' then t2.cgo_act END) OVER (PARTITION BY cve_ent) as cod2, ";
consulta1 += "count(case when t2.cgo_act='1' then t2.cgo_act END) OVER (PARTITION BY cve_ent) as cod1,";
consulta1 += "count(case when t2.cgo_act in ('3','C','K','R','T') then t2.cgo_act END) OVER (PARTITION BY cve_ent) as cod3 ";
consulta1 += "from cat_ent t1 left join (select * from (select * from respaldo_te_mza union select * from respaldo_te_mza_cd) t5) t2 on t1.cve_ent=t2.ent_ant or t1.cve_ent=t2.ent_Act ";
consulta1 += "where status=1  order by t1.cve_ent) t1 group by cve_ent";


//out.println("<center><img src='images/reporte2.png' width='100px'  height='100px'></img>");


//out.println(consulta1);
      Statement str = null;
	  Statement str1 = null;
      ResultSet rs = null;
	  ResultSet rs1 = null;
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
	  
      out.println("<form method=\"post\" name=\"enviar\"><CENTER CLASS=T ALIGN=CENTER>Avance de la Actualizacion Cartografica (Manzanas Aceptadas)<!-- a la fecha: <input class='boton' name='filfe2' type='text' id='p1id' onClick=\"popUpCalendar(this, enviar.p1id, 'yyyy-mm-dd');\" size='10' readOnly value='"+filfe2.substring(0,10)+"'>&nbsp;&nbsp;<input class='boton' type=submit value='Ir'>-->");
out.println("<br><br><center><table border=1 class=table><tr class=titulo2>");
out.println("<th rowspan=3 bgcolor=#dadeda>&nbsp;Entidad&nbsp;");
out.println("<th colspan=1 rowspan=3 bgcolor=#8299BB>&nbsp;&nbsp;Actualizaciones&nbsp;<br>&nbsp;integradas<br>&nbsp;en SIGMA&nbsp;&nbsp;");
out.println("<th colspan=1 rowspan=3 bgcolor=#aac6f0>&nbsp;&nbsp;Actualizaciones&nbsp;<br>&nbsp;Relacionadas<br>&nbsp;en SIGMA&nbsp;&nbsp;");

out.println("<th colspan=8 bgcolor=#c2f0c2>&nbsp;TABLAS DE EQUIVALENCIA&nbsp;");
out.println("<tr class=titulo2>");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Registros de&nbsp;<br>&nbsp;actualizacion&nbsp;");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Alta&nbsp;");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Subdivision&nbsp;");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Fusion&nbsp;");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Baja&nbsp;");


out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Registros&nbsp;<br>validados<br>&nbsp;OC&nbsp;");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Registros&nbsp;<br>validados<br>&nbsp;REG&nbsp;");
out.println("<th rowspan=2 bgcolor=#ffffff>&nbsp;Registros&nbsp;<br>cambios<br>&nbsp;de forma&nbsp;");



out.println("<tr class=titulo2>");
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
        t1=Integer.parseInt(rs.getObject(2).toString()); //val1 - modcar1 - ensigma
        t2=Integer.parseInt(rs.getObject(3).toString()); //val2 - modcar2
        t3=Integer.parseInt(rs.getObject(4).toString()); //val3 - total
        t4=Integer.parseInt(rs.getObject(5).toString()); //val4 - column
        t5=Integer.parseInt(rs.getObject(6).toString()); //val5 - valoc
        t6=Integer.parseInt(rs.getObject(7).toString()); //modcar1 - valreg
        t7=Integer.parseInt(rs.getObject(8).toString()); //modcar2 - forma
        t8=Integer.parseInt(rs.getObject(9).toString()); //modcar3 - cod4
        t9=Integer.parseInt(rs.getObject(10).toString());  //ensigma - cod2
        t10=Integer.parseInt(rs.getObject(11).toString()); //total - cod1
        t11=Integer.parseInt(rs.getObject(12).toString()); //column - cod3
       // t12=Integer.parseInt(rs.getObject(13).toString()); //valoc
       // t13=Integer.parseInt(rs.getObject(14).toString()); //valreg
       // t14=Integer.parseInt(rs.getObject(15).toString()); //forma
       // t15=Integer.parseInt(rs.getObject(16).toString()); //cod4
       // t16=Integer.parseInt(rs.getObject(17).toString()); //cod2
       // t17=Integer.parseInt(rs.getObject(18).toString()); //cod1
       // t18=Integer.parseInt(rs.getObject(19).toString()); //cod3


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
        //sum12+=(t12);
       // sum13+=(t13);
       // sum14+=(t14);
       // sum15+=(t15);
        //sum16+=(t16);
        //sum17+=(t17);

        //sum18+=(t18);


        imprimir+=("<tr onmouseover='this.style.background=\"#c0c0c0\"' onmouseout='this.style.background=\""+color+"\"' class=n align=center bgcolor='"+color+"'>");
        imprimir+=("<td>"+cve_ent+"");
        imprimir+=("<td bgcolor='#8299BB'>"+formateador.format(t1)+"");
		imprimir+=("<td bgcolor='#aac6f0'>"+formateador.format(t2)+"");
        imprimir+=("<td bgcolor='#9FF781'>"+formateador.format(t3)+"");
        imprimir+=("<td>"+formateador.format(t8)+"");
        imprimir+=("<td>"+formateador.format(t9)+"");
        imprimir+=("<td >"+formateador.format(t10)+"");
        imprimir+=("<td >"+formateador.format(t11)+"");
        imprimir+=("<td>"+formateador.format(t5)+"");
        imprimir+=("<td>"+formateador.format(t6)+"");
        imprimir+=("<td>"+formateador.format(t7)+"");

}



    out.println("<tr class=n2 align=center style='background-color:#8299BB;'><td>TOTAL");


out.println("<td bgcolor='#8299BB'>"+formateador.format(sum1)+"");
out.println("<td bgcolor='#8299BB'>"+formateador.format(sum2)+"");

out.println("<td bgcolor='#8299BB'>"+formateador.format(sum3)+"");

out.println("<td>"+formateador.format(sum8)+"");
out.println("<td>"+formateador.format(sum9)+"");
out.println("<td>"+formateador.format(sum10)+"");
out.println("<td>"+formateador.format(sum11)+"");



out.println("<td>"+formateador.format(sum5)+"");
out.println("<td>"+formateador.format(sum6)+"");
out.println("<td>"+formateador.format(sum7)+"");
out.println(imprimir);


   String consulta9 = "insert into usuarios_reporte values (DEFAULT, '"+request.getRemoteAddr()+"',current_timestamp,'Avance_Act');";
 str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);

 str.executeUpdate(consulta9);

  out.println("</table><font class=c align=left> <br>");

  
out.println("</form>");


  
      str.close();
      conexion.close();

%>

</body>
</html>
