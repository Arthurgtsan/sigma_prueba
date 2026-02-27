<!-- Creador: Jasiel.Briano  -->
<!-- Fecha: 19/05/2022  -->
<!-- Descripcion : Script que relaciona SILAVAC con una manzana de SIGMA  -->
<!--                Lo relaciona con el ultimo corte en esta ventana  -->
<%@ page import="java.util.*"%>
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
.t{font-size: 12pt; font-family: Arial; font-weight: bold; color: #000000;}
.c{font-family: Arial; font-size: 10pt; line-height: 1; font-weight: normal;}
.n{font-family: Arial; font-size: 10pt; line-height: 1.3; font-weight: bold;}
.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}
.f{font-family: Arial; font-size: 9px; line-height: 1; font-weight: normal;}
a.liga2:link {font-family: Arial;color: black; font-size: 9pt; text-decoration: underline}
a.liga2:visited {font-family: Arial;color: black; font-size: 9pt; text-decoration: underline}
a.liga2:hover {font-family: Arial;color: black; font-size: 9pt; text-decoration: underline; background-color: #FFFFFF}


</style>
<body onload="vincular()"> <center><table   border="1"  bgcolor="#dddddd" width=80% align="center">

<%




String clave= request.getParameter("clave");
String cons= request.getParameter("cons");
String consul= request.getParameter("ban");
String ent=clave.substring(0,2);

String base="";
Integer  conteo=0;
String box="";
String equipo="";
String imagen="";
String ban="";
String pasSigma="";
String regionalid="";
if (ent.equals("08") || ent.equals("10") || ent.equals("32"))
    {base="actcargeo2"; equipo="GEOGAT046166D";regionalid="02";}
if (ent.equals("02") || ent.equals("03") || ent.equals("25") || ent.equals("26"))
    {base="actcargeo1"; equipo="GEOGAT045732D";regionalid="01";}
if (ent.equals("06") || ent.equals("14") || ent.equals("16") || ent.equals("18"))
    {base="actcargeo4"; equipo="GEOGAT046078D";regionalid="04";}
if (ent.equals("05") || ent.equals("19") || ent.equals("28"))
    {base="actcargeo3"; equipo="GEOGAT046025D";regionalid="03";}
if (ent.equals("01") || ent.equals("11") || ent.equals("22") || ent.equals("24"))
    {base="actcargeo5"; equipo="GEOGAT046050D";regionalid="05";}
if (ent.equals("12") || ent.equals("17") || ent.equals("15"))
    {base="actcargeo6"; equipo="GEOGAT045677D";regionalid="06";}
if  (ent.equals("13") || ent.equals("21") || ent.equals("29") || ent.equals("30") || ent.equals("09"))
    {base="actcargeo7"; equipo="GEOGAT045713D";regionalid="07";}
if (ent.equals("07") || ent.equals("20") || ent.equals("27"))
    {base="actcargeo8"; equipo="GEOGAT046028D";regionalid="08";}
if (ent.equals("04") || ent.equals("23") || ent.equals("31"))
    {base="actcargeo9"; equipo="GEOGAT045744D";regionalid="09";}





Statement str = null;
ResultSet rs = null;
Connection conexion = null;
Class.forName("org.postgresql.Driver");
conexion = DriverManager.getConnection(
                                     "jdbc:postgresql://l-appwebmd1:5434/"+base+"",
                                     "arcgis",
                                     "arcgis"
                                    );

str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
// str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);

String consulta="";
String bandera="0";
if(cons==null || cons==""){
	out.println("<H3>No es usuario de SIGMA</H3>");

}else{

consulta ="select md5(password) from usuarios where cons="+cons;
rs = str.executeQuery( consulta );
while(rs.next()){
		pasSigma=rs.getObject(1).toString();	
}
bandera="1";	
}
//out.println(pasSigma);
//out.println(clave);
//1 manzana
//2 ageb
//3 localidad
if (consul.equals("1")){
consulta ="SELECT replace(replace(replace(((ST_Extent(st_transform(st_buffer(st_centroid(the_geom),1000),3857)) over ())::text),'BOX(',''),' ',','),')','') as geom, cve_temp, ban, vienede FROM cat_manz where   (cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza)=replace('"+clave+"','-','')";
}else if(consul.equals("2")){
consulta ="SELECT replace(replace(replace(((ST_Extent(st_transform(st_buffer(st_centroid(the_geom),1000),3857)) over ())::text),'BOX(',''),' ',','),')','') ";
consulta=consulta+"as geom, null as cve_temp, '0' as ban, null as vienede  "; 
consulta=consulta+"FROM cat_agebu ";
consulta=consulta+"WHERE (cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')) = replace('"+clave+"','-','')";
consulta=consulta+"UNION ALL ";
consulta=consulta+"SELECT replace(replace(replace(((ST_Extent(st_transform(st_buffer(st_centroid(the_geom),1000),3857)) over ())::text),'BOX(',''),' ',','),')','') ";
consulta=consulta+"as geom, null as cve_temp, '0' as ban, null as vienede  "; 
consulta=consulta+"FROM cat_ageb ";
consulta=consulta+"WHERE (cve_ent||cve_mun||replace(cve_ageb,'-','')) = replace('"+clave+"',substring('"+clave+"',6,4),'')";



//consulta ="SELECT replace(replace(replace(((ST_Extent(st_transform(st_buffer(st_centroid(the_geom),1000),3857)) over ())::text),'BOX(',''),' ',','),')','') as geom, cve_temp, ban, vienede FROM cat_manz where   (cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-',''))=replace('"+clave+"','-','') limit 1";	
}else if(consul.equals("3")){
	consulta ="SELECT replace(replace(replace(((ST_Extent(st_transform(st_buffer(st_centroid(the_geom),1000),3857)) over ())::text),'BOX(',''),' ',','),')','')"; 
	consulta=consulta+" as geom, null as cve_temp, '0' as ban, null as vienede FROM cat_loc where (cve_ent||cve_mun||cve_loc)='"+clave+"'";
	
//consulta ="SELECT replace(replace(replace(((ST_Extent(st_transform(st_buffer(st_centroid(the_geom),1000),3857)) over ())::text),'BOX(',''),' ',','),')','') as geom, cve_temp, ban, vienede FROM cat_manz where   (cve_ent||cve_mun||cve_loc)='"+clave+"' limit 1";	
}

rs = str.executeQuery( consulta );
ban="NO";
while(rs.next()){
    if (rs.getObject(1)==null){box=null;}else{box=rs.getObject(1).toString();}
    if (rs.getObject(3)==null){ban=null;}else{ban=rs.getObject(3).toString();}
}
if (!(ban.equals("NO"))){ //quiere decir que SI EXISTE
     String status="";
    if (ban.equals("3") || ban.equals("1") || ban.equals("5") || ban.equals("6") || ban.equals("Y") || ban.equals("E") || ban.equals("D") || ban.equals("H") || ban.equals("G") || ban.equals("I") || ban.equals("M") || ban.equals("N") || ban.equals("O") || ban.equals("K") || ban.equals("R") || ban.equals("T") || ban.equals("C") || ban.equals("X")){
		status="<b>BAJA</b>";
	}else{
		status="<b>VIGENTE</b>";
	}
    if (box==null){
        imagen="images/descarga.jpg";
        out.println ("<H1><CENTER CLASS=n ALIGN=CENTER> Clave de Manzana: "+(clave)+" - Status: "+(status)+"</H1><img align='center' style='border: 1px solid'  src='"+(imagen)+"' width=275 height=183></table>");
    }else{ //si tiene geometria
        //imagen="http://"+equipo+".inegi.gob.mx:8070/geoserver/INEGI/wms?service=WMS&version=1.1.0&request=GetMap&srs=EPSG:4326&bbox="+box+"&width=600&height=600&layers=INEGI:ESTADOS,INEGI:ESTADOS,INEGI:POLIGONOS_URBANOS,INEGI:POLIGONOS_URBANOS,INEGI:locs_puntuales_b,INEGI:locs_puntuales_b,INEGI:locs_puntuales_v,INEGI:locs_puntuales_v,INEGI:cat_manz,INEGI:cat_manz,INEGI:edit_locr&styles=estados,estadoset,urbanas,urbanaset,locsrur0,locsruret0,locsrur1,locsruret1,mza,mzaetbd,porur&CQL_FILTER=INCLUDE;INCLUDE;INCLUDE;INCLUDE;INCLUDE;INCLUDE;INCLUDE;INCLUDE;ban%3C%3E%273%27%20and%20ban%3C%3E%271%27%20and%20ban%3C%3E%275%27%20and%20ban%3C%3E%276%27%20and%20ban%3C%3E%27Y%27%20and%20ban%3C%3E%27E%27%20and%20ban%3C%3E%27D%27%20and%20ban%3C%3E%27H%27%20and%20ban%3C%3E%27G%27%20and%20ban%3C%3E%27I%27%20and%20ban%3C%3E%27M%27%20and%20ban%3C%3E%27N%27%20and%20ban%3C%3E%27O%27%20and%20ban%3C%3E%27K%27%20and%20ban%3C%3E%27R%27%20and%20ban%3C%3E%27T%27%20and%20ban%3C%3E%27C%27%20and%20ban%3C%3E%27X%27;ban%3C%3E%273%27%20and%20ban%3C%3E%271%27%20and%20ban%3C%3E%275%27%20and%20ban%3C%3E%276%27%20and%20ban%3C%3E%27Y%27%20and%20ban%3C%3E%27E%27%20and%20ban%3C%3E%27D%27%20and%20ban%3C%3E%27H%27%20and%20ban%3C%3E%27G%27%20and%20ban%3C%3E%27I%27%20and%20ban%3C%3E%27M%27%20and%20ban%3C%3E%27N%27%20and%20ban%3C%3E%27O%27%20and%20ban%3C%3E%27K%27%20and%20ban%3C%3E%27R%27%20and%20ban%3C%3E%27T%27%20and%20ban%3C%3E%27C%27%20and%20ban%3C%3E%27X%27;ban%3C%3E%273%27&format=image%2Fjpeg";
        //imagen="http://w-webintratslic.inegi.gob.mx:8080/geoserver/INEGI/wms?service=WMS&version=1.1.0&request=GetMap&srs=EPSG:4326&bbox="+box+"&width=600&height=600&layers=INEGI:ESTADOS,INEGI:MUNICIPIOS,INEGI:AGEB,INEGI:AGEB,INEGI:POLIGONOS_URBANOS,INEGI:POLIGONOS_URBANOS,INEGI"+regionalid+":edit_pe,INEGI:locs_puntuales_v,INEGI:locs_puntuales_v,INEGI"+regionalid+":cat_manz,INEGI"+regionalid+":cat_manz,INEGI"+regionalid+":edit_agebu,INEGI"+regionalid+":edit_agebu,INEGI"+regionalid+":edit_locr,INEGI"+regionalid+":cat_cd&styles=estados,municipios,agebs,agebset,urbanas,urbanaset,pol_rur_ext,locsrur1,locsruret1,mza,mzaetbd,agebs,agebsetbd,porur,caserio&CQL_FILTER=INCLUDE;INCLUDE;INCLUDE;INCLUDE;INCLUDE;INCLUDE;ban%3C%3E%273%27;INCLUDE;INCLUDE;ban%3C%3E%273%27%20and%20ban%3C%3E%271%27%20and%20ban%3C%3E%275%27%20and%20ban%3C%3E%276%27%20and%20ban%3C%3E%27Y%27%20and%20ban%3C%3E%27E%27%20and%20ban%3C%3E%27D%27%20and%20ban%3C%3E%27H%27%20and%20ban%3C%3E%27G%27%20and%20ban%3C%3E%27I%27%20and%20ban%3C%3E%27M%27%20and%20ban%3C%3E%27N%27%20and%20ban%3C%3E%27O%27%20and%20ban%3C%3E%27K%27%20and%20ban%3C%3E%27R%27%20and%20ban%3C%3E%27T%27%20and%20ban%3C%3E%27C%27%20and%20ban%3C%3E%27X%27;ban%3C%3E%273%27%20and%20ban%3C%3E%271%27%20and%20ban%3C%3E%275%27%20and%20ban%3C%3E%276%27%20and%20ban%3C%3E%27Y%27%20and%20ban%3C%3E%27E%27%20and%20ban%3C%3E%27D%27%20and%20ban%3C%3E%27H%27%20and%20ban%3C%3E%27G%27%20and%20ban%3C%3E%27I%27%20and%20ban%3C%3E%27M%27%20and%20ban%3C%3E%27N%27%20and%20ban%3C%3E%27O%27%20and%20ban%3C%3E%27K%27%20and%20ban%3C%3E%27R%27%20and%20ban%3C%3E%27T%27%20and%20ban%3C%3E%27C%27%20and%20ban%3C%3E%27X%27;ban%3C%3E%273%27%20and%20ban%3C%3E%274%27%20and%20ban%3C%3E%279%27;ban%3C%3E%273%27%20and%20ban%3C%3E%274%27%20and%20ban%3C%3E%279%27;ban%3C%3E%273%27;INCLUDE&format=image%2Fjpeg";
		imagen="http://w-webintratslic.inegi.gob.mx:8080/geoserver/wms?service=WMS&version=1.3.0&request=GetMap&srs=EPSG:3857&bbox="+box+"&width=600&height=600&layers=INEGI:ESTADOS,INEGI:MUNICIPIOS,INEGI:AGEB,INEGI:AGEB,INEGI:POLIGONOS_URBANOS,INEGI:POLIGONOS_URBANOS,INEGI"+regionalid+":edit_pe,INEGI:locs_puntuales_v,INEGI:locs_puntuales_v,INEGI"+regionalid+":cat_manz,INEGI"+regionalid+":cat_manz,INEGI"+regionalid+":edit_agebu,INEGI"+regionalid+":edit_agebu,INEGI"+regionalid+":edit_locr,INEGI"+regionalid+":cat_cd&styles=estados,municipios,agebs,agebset,urbanas,urbanaset,pol_rur_ext,locsrur1,locsruret1,mza,mzaetbd,agebs,agebsetbd,porur,caserio&CQL_FILTER=INCLUDE;INCLUDE;INCLUDE;INCLUDE;INCLUDE;INCLUDE;ban%3C%3E%273%27;INCLUDE;INCLUDE;ban%3C%3E%273%27%20and%20ban%3C%3E%271%27%20and%20ban%3C%3E%275%27%20and%20ban%3C%3E%276%27%20and%20ban%3C%3E%27Y%27%20and%20ban%3C%3E%27E%27%20and%20ban%3C%3E%27D%27%20and%20ban%3C%3E%27H%27%20and%20ban%3C%3E%27G%27%20and%20ban%3C%3E%27I%27%20and%20ban%3C%3E%27M%27%20and%20ban%3C%3E%27N%27%20and%20ban%3C%3E%27O%27%20and%20ban%3C%3E%27K%27%20and%20ban%3C%3E%27R%27%20and%20ban%3C%3E%27T%27%20and%20ban%3C%3E%27C%27%20and%20ban%3C%3E%27X%27;ban%3C%3E%273%27%20and%20ban%3C%3E%271%27%20and%20ban%3C%3E%275%27%20and%20ban%3C%3E%276%27%20and%20ban%3C%3E%27Y%27%20and%20ban%3C%3E%27E%27%20and%20ban%3C%3E%27D%27%20and%20ban%3C%3E%27H%27%20and%20ban%3C%3E%27G%27%20and%20ban%3C%3E%27I%27%20and%20ban%3C%3E%27M%27%20and%20ban%3C%3E%27N%27%20and%20ban%3C%3E%27O%27%20and%20ban%3C%3E%27K%27%20and%20ban%3C%3E%27R%27%20and%20ban%3C%3E%27T%27%20and%20ban%3C%3E%27C%27%20and%20ban%3C%3E%27X%27;ban%3C%3E%273%27%20and%20ban%3C%3E%274%27%20and%20ban%3C%3E%279%27;ban%3C%3E%273%27%20and%20ban%3C%3E%274%27%20and%20ban%3C%3E%279%27;ban%3C%3E%273%27;INCLUDE&format=image%2Fjpeg";
//out.println (imagen); 


		out.println ("<H1><CENTER CLASS=n ALIGN=CENTER> Clave de Manzana: "+(clave)+" - Status: "+(status)+"</H1><img align='center' style='border: 1px solid'  src='"+(imagen)+"' width=600 height=600></table>");
   
		if(bandera=="1"){
			out.println("<br><a href='javascript:close_tab();' class='boton'>Cerrar</a>");
			String[] boxa = box.split(",");

			out.println("</center></body><script language='javascrpt' type='text/javascript'>window.resizeTo(640,380);");
			out.println("function close_tab() {   window.close();}");
			out.println("function vincular() {");

			Float boxa0 = Float.parseFloat(boxa[0])-2000;
			Float boxa1 = Float.parseFloat(boxa[1])-2000;
			Float boxa2 = Float.parseFloat(boxa[2])+2000;
			Float boxa3 = Float.parseFloat(boxa[3])+2000;

			String texto="href='http://dc046068asdggma.inegi.gob.mx:8070/openlayers/index.jsp?sts=1&ban=1&st=AMBAS&capa=12&c1="+boxa[0]+"&c2="+boxa[1]+"&c3="+boxa[2]+"&c4="+boxa[3]+"&password="+(pasSigma)+"&cat=X'";

			out.println("window.location.replace("+texto+");");
			out.println("}");
		}

   }
}else{  //no encotrada
    imagen="images/descarga.jpg";
    out.println ("<H1><CENTER CLASS=n ALIGN=CENTER> Clave de Manzana: "+(clave)+" - Status: <b>NO ENCONTRADA</b></H1><img align='center' style='border: 1px solid'  src='"+(imagen)+"' width=275 height=183></table>");
}
str.close();
conexion.close();

/*
out.println("<br><a href='javascript:close_tab();' class='boton'>Cerrar</a>");
String[] boxa = box.split(",");


out.println("</center></body><script language='javascrpt' type='text/javascript'>window.resizeTo(640,380);");
out.println("function close_tab() {   window.close();}");
out.println("function vincular() {");

Float boxa0 = Float.parseFloat(boxa[0])-2000;
Float boxa1 = Float.parseFloat(boxa[1])-2000;
Float boxa2 = Float.parseFloat(boxa[2])+2000;
Float boxa3 = Float.parseFloat(boxa[3])+2000;




String texto="href='http://dc046068asdggma.inegi.gob.mx:8070/openlayers/index.jsp?sts=1&ban=1&st=AMBAS&capa=11&c1="+boxa[0]+"&c2="+boxa[1]+"&c3="+boxa[2]+"&c4="+boxa[3]+"&password="+(pasSigma)+"&cat=X'";

out.println("window.location.replace("+texto+");");
out.println("}");*/
%>
</script>

</html>





