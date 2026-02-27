<%@ page import="java.util.*" session="true" %> 
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>


<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-Q856GDCQ02"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-Q856GDCQ02');
</script>

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
<script language="javascrpt" type="text/javascript">
window.resizeTo(500,400);
function desc(){
	if (document.enviar.forma[0].checked){
		var co = opener.map.getExtent();
		co = co.toString();
		var coord = co.split(",");
		document.enviar.c0.value=coord[0];
		document.enviar.c1.value=coord[1];
		document.enviar.c2.value=coord[2];
		document.enviar.c3.value=coord[3];
	}else{
		if (document.enviar.filtro.value.length<2){
			alert ("Debe de proporcionar algun filtro!!");
			return false;
		}
	}
	document.enviar.ban.value=1;
	document.enviar.submit();
}

function bajazip(nom){
	ventana = window.open('descargazip.jsp?nom='+nom,'ZIP','toolbar=no,Resizable=1,scrollbars=1');
    ventana.focus();
}
</script>
  </head>
<body>
<form action="descarga.jsp" method="post" name="enviar">
<%

HttpSession sesion = request.getSession(true);

if ((sesion != null && !sesion.isNew())) {
        //out.println("LA SESION SIGUE ACTIVA");



String regionalid  = session.getAttribute("regionalid").toString();
  	  String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
String ban = request.getParameter("ban");
String cons = "U:"+session.getAttribute("userName").toString();
String registro = "";


	if (ban==null){
		out.println ("<center><br><table border=1 cellpadding=2>"+
		"<tr class=n bgcolor=#BBBBBB align=center><th colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Descargar informacion en SHP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
		"<tr class=n align=center><td class=n colspan=2>&nbsp;Regional: "+regionalid+
		"<tr class=n align=center><td class=n align=right>Capa:&nbsp;&nbsp;<td align=left>&nbsp;&nbsp;<select class=c name=capa>"+
		"<option value=0>Cartas 1:50</option>"+
		"<option value=1>Entidad</option>"+
		"<option value=2>Municipio</option>"+
		"<option value=3>Ageb rural</option>"+
		"<option value=4 style='color:blue'>Ageb urbana (actualizada)</option>"+
		"<option value=5>Localidad urbana</option>"+
		"<option value=6 style='color:blue'>Loc rural amanzanada (actualizada)</option>"+
		"<option value=61 style='color:blue'>Poligono externo (actualizada)</option>"+
		"<option value=7>Localidades vigentes (puntos)</option>"+
		"<option value=8>Asentamientos</option>"+
		"<option value=9  style='color:blue'>Manzanas (actualizada)</option>"+
		"<option value=92  style='color:blue'>Frentes (actualizada)</option>"+
		"<option value=13 style='color:blue'>Caserio (actualizada)</option>"+
		"<option value=131 style='color:blue'>PEM-Urbano (actualizada)</option>"+
		"<option value=14 style='color:blue'>Manzana+Caserio (actualizada) (Multi-Poligono)</option>"+
		"<option value=22  style='color:#D618D3'>Manzanas CUR</option>"+
		"<option value=221  style='color:#D618D3'>Frentes CUR</option>"+
		//"<option value=12  style='color:#CF7236'>Manzanas MCC</option>"+
		//"<option value=121  style='color:#CF7236'>Frentes MCC</option>"+
		//"<option value=122  style='color:#CF7236'>Localidades MCC</option>"+
		//"<option value=51 style='color:#FF8800'>Pre-Dig Frentes</option>"+
		//"<option value=52 style='color:#FF8800'>Pre-Dig Ejes</option>"+
		"<option value=53 style='color:#FEC177'>Pre-Dig Manzanas</option>"+
		"<option value=54 style='color:#FEC177'>Pre-Dig Poligonos Externos</option>"+
		"<option value=55 style='color:#FEC177'>Pre-Dig Puntos</option>"+
		"<option value=10>Vialidades</option>"+
		"<option value=11>Captura</option>"+
		"<option value=21>Marcas</option>"+
		//"<option value=99 style='color:#D618D3'>Puntos DENUE (preliminar)</option>"+
		"</select>"+
		"<tr class=c align=center><td class=n align=right>Forma:&nbsp;&nbsp;<td align=left class=c>"+
		"&nbsp;&nbsp;<input class='boton' type='radio' name='forma' value='1' checked>Por extension de mapa<br>"+
		"&nbsp;&nbsp;<input class='boton' type='radio' name='forma' value='2'>Por filtro de clave"+
		"<tr class=c align=center><td class=n align=right>Filtro:&nbsp;&nbsp;<td align=left class=c>&nbsp;&nbsp;<input class='boton' type='text' name='filtro'>"+
		"<input type='hidden' name=c0><input type='hidden' name=c1><input type='hidden' name=c2><input type='hidden' name=c3><input type='hidden' name=ban><input type='hidden' name=as><input type='hidden' name=vial>");
		out.println ("<tr><td colspan=2>&nbsp;<tr><td nowrap colspan=2 align=center><input class='boton' type='Button' name='descargar' onClick='desc();' value=' Descargar SHP '/>");
		out.println ("</table><br><font class=f>* Se limita la descarga a 500,000 rasgos</font>");
	}else{
	  int capa = Integer.parseInt(request.getParameter("capa"));
	  int forma = Integer.parseInt(request.getParameter("forma"));
	  String filtro = request.getParameter("filtro").replace("-","");
	  Random rnd = new Random();
		String nom="Exp_"+rnd.nextInt(10000);
		String f1="",f2="";
		String base="actcargeo10";
		if (forma==1){
			String c0 = request.getParameter("c0");
			String c1 = request.getParameter("c1");
			String c2 = request.getParameter("c2");
			String c3 = request.getParameter("c3");
			registro =  "insert into usuarios_descsigma (origen,usuario,fecha,capa,filtro,regional) values('SIGMA','"+cons+"',CURRENT_TIMESTAMP(0),"+capa+",'"+c0+","+c1+","+c2+","+c3+"','"+regionalid+"')";

			switch (capa){
			case 0:
				f1="select cve_carta,nombre,the_geom from cat_cartas where the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by cve_carta";
				break;
			case 1:
				f1="select cve_ent,nom_ent,the_geom from cat_ent where status=1 and the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by clave";
				break;
			case 2:
				f1="select cve_ent,cve_mun,nom_mun,the_geom from cat_mun where status=1 and the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by clave";
				break;
			case 3:
				f1="select cve_ent,cve_mun,replace(cve_ageb,'-','') as cve_ageb,the_geom from cat_ageb where status=1 and the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by clave";
				break;
			case 4:
				f1="select cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,the_geom,fact,img,fdg,ban,us from edit_ploc.edit_agebu where ban not in ('9','3','4') and the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by cve_ent,cve_mun,cve_loc,cve_ageb";
				break;
			case 5:
				f1="select cve_ent,cve_mun,cve_loc,nom_loc,ambito,latitud,longitud,altitud,cve_carta,plano,the_geom_pu from cat_loc where status=1 and ambito='U' and the_geom_pu && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by clave";
				break;
			case 6:
				f1="select cve_ent,cve_mun,replace(cve_ageb,'-','') as cve_ageb,cve_loc,the_geom,fact,img,fdg,ban,us from edit_ploc.edit_locr where  ban not in ('3','4') and the_geom is not null and the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by cve_ent,cve_mun,cve_loc";
				break;
			case 61:
				f1="select cve_ent,cve_mun,cve_loc,the_geom,fact,img,fdg,ban,us from edit_ploc.edit_pe where ban not in ('3','4') and the_geom is not null and the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by cve_ent,cve_mun,cve_loc";
				break;
			case 7:
				f1="select cve_ent,cve_mun,replace(cve_ageb,'-','') as cve_ageb,cve_loc,nom_loc,ambito,latitud,longitud,altitud,cve_carta,plano,status,the_geom from cat_loc where status=1 and the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by clave";
				break;
			case 8:
				f1="select cve_ent,cve_mun,cve_loc,cve_asen,nom_asen,tipo,fecha_act,cp,the_geom from cat_asen where the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by clave";
				break;
			case 9:
				f1="select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza as cvegeo,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,tipomza::text,ambito,the_geom,proy,img,fdg,vienede,ban,usuario from cat_manz where ban not in ('X','3','1','5','6','Y','E','D','H','G','M','I','N','O','K','R','T','C','J','L') and the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza ";
				break;
			case 92:
				f1="select cvegeo,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,cve_ft,cve_vial, cve_seg,the_geom from cat_fm where the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza ";
				break;
			case 10:
				f1="select cve_ent,cve_mun,cve_loc,cve_via,nom_via, tipo,the_geom from cat_vial where the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by clave";
				break;
			case 11:
				f1="select id,entidad,cgo1,nom_loc,err,the_geom from a_bd_loc where the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by id";
				break;
			case 12:
				f1="select gid as Id,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,tipomza as tipomza_mc,cgo as cgo_mc,proc as resp,fresp,cve_def,tipo,status,nota,geom,cveoper,figura,mal from mcc_poblacion.cat_manz_modcar where ((figura='CENSOR' and status!=2) or (figura='TCAR')) and geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza ";
				break;
			case 121:
				f1="select gid as Id,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,cveft,cvevial,cveseg,codigoact as cgo_mc,status,geom from mcc_poblacion.frentes where baja is false and ((figura='CENSOR' and status!=2) or (figura='TCAR')) and geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza||cveft ";
				break;
			case 122:
				f1="select gid as Id,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,nomgeo,codigoact as cgo_mc,proc as resp,fresp,cve_def,status,nota,geom,cveoper from mcc_poblacion.loc_rur where geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by cve_ent||cve_mun||cve_loc||cve_ageb";
				break;
			case 22:
				f1="select gid as Id,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,ambito,tipo, tip_act,cvegeo, fecha_mod, f_registro ,proc , fresp , geom  from act_cu.bcu_bd_manzana where geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza ";
				break;
			case 221:
				f1="select gid as Id,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,cveft,cvevial,cvevial1,cvevial2,cvevial3,cvegeo, geom , fecha_mod , procmz from act_cu.bcu_bd_frentes where geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza||cveft ";
				break;
			case 13:
				f1="select cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,the_geom,proy,img,fdg from cat_cd where the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza ";
				break;
			case 131:
				f1="select cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,the_geom,proy,img,fdg from cd_polext where the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by cve_ent||cve_mun||cve_loc||cve_ageb ";
				break;
			case 14:
				f1="select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza as cvegeo,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,tipomza::text,ambito,the_geom from cat_manz where ban not in ('X','3','1','5','6','Y','E','D','H','G','M','I','N','O','K','R','T','C','J','L') and the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) union select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza as cvegeo,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,'9' as tipomza,tipo as ambito,st_transform(st_collect(st_triangle_32800(the_geom,5.3)),32800) as the_geom from cat_cd where the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) group by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,tipo order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza";
				break;
			case 51:
				f1="select gid as id,cve_ent,fact,img,fdg,nfr_orden,nfr_noroe,the_geom from z_digf where the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by gid ";
				break;
			case 52:
				f1="select gid as id,cve_ent,fact,img,fdg,the_geom from z_dige where the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by gid ";
				break;
			case 53:
				f1="select gid as id,cve_ent,fact,img,fdg,baja,cve_baja,conviv,cvegeo,(select nombre from usuarios where us=cons) as usuario, forma ,aplicado, case when cur=1 then 'CUR' else 'MG' end as criterio,cod as cod_act, the_geom from z_digmz where the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by gid ";
				break;
			case 54:
				f1="select gid as id,cve_ent,cve_mun,cve_ageb,cve_loc,fact,img,fdg,conviv,cvegeo,(select nombre from usuarios where us=cons) as usuario,aplicado,the_geom from z_digpe where the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by gid ";
				break;
			case 55:
				f1="select gid as id,cve_ent,fact,img,fdg,baja,cve_baja,cvegeo,(select nombre from usuarios where us=cons) as usuario,aplicado,the_geom from z_digmp where the_geom && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800) order by gid ";
				break;
			case 21:
				f1="select cve_ent,descripcion,fact,st_transform(the_geom,32800) as geom from cat_marks where the_geom && ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857) order by fact";
				break;
			case 99:
				f1="select * from mcc_poblacion.inmuebles where the_geom_itrf08 && st_transform(ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 3857),32800)";
				break;
			}
		}else{  //forma=2
						registro =  "insert into usuarios_descsigma (origen,usuario,fecha,capa,filtro,regional) values('SIGMA','"+cons+"',CURRENT_TIMESTAMP(0),"+capa+",'"+filtro+"','"+regionalid+"')";

			switch (capa){
			case 0:
				f1="select cve_carta,nombre,the_geom from cat_cartas where cve_carta ilike '"+filtro+"%' order by cve_carta";
				break;
			case 1:
				f1="select cve_ent,nom_ent,the_geom from cat_ent where status=1 and clave ilike '"+filtro+"%' order by clave";
				break;
			case 2:
				f1="select cve_ent,cve_mun,nom_mun,the_geom from cat_mun where status=1 and clave ilike '"+filtro+"%' order by clave";
				break;
			case 3:
				f1="select cve_ent,cve_mun,replace(cve_ageb,'-','') as cve_ageb,the_geom from cat_ageb where status=1 and clave ilike '"+filtro+"%' order by clave";
				break;
			case 4:
				f1="select cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,the_geom,fact,img,fdg,ban,us from edit_ploc.edit_agebu where ban not in ('9','3','4') and cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','') ilike '"+filtro+"%' order by cve_ent,cve_mun,cve_loc,cve_ageb";
				break;
			case 5:
				f1="select cve_ent,cve_mun,cve_loc,nom_loc,ambito,latitud,longitud,altitud,cve_carta,plano,the_geom_pu from cat_loc where status=1 and ambito='U' and clave ilike '"+filtro+"%' order by clave";
				break;
			case 6:
				f1="select cve_ent,cve_mun,replace(cve_ageb,'-','') as cve_ageb,cve_loc,the_geom,fact,img,fdg,ban,us from edit_ploc.edit_locr where  ban not in ('3','4') and the_geom is not null and cve_ent||cve_mun||cve_loc ilike '"+filtro+"%' order by cve_ent,cve_mun,cve_loc";
				break;
			case 61:
				f1="select cve_ent,cve_mun,cve_loc,the_geom,fact,img,fdg,ban,us from edit_ploc.edit_pe where  ban not in ('3','4') and the_geom is not null and cve_ent||cve_mun||cve_loc ilike '"+filtro+"%' order by cve_ent,cve_mun,cve_loc";
				break;
			case 7:
				f1="select cve_ent,cve_mun,replace(cve_ageb,'-','') as cve_ageb,cve_loc,nom_loc,ambito,latitud,longitud,altitud,cve_carta,plano,status,the_geom from cat_loc where status=1 and clave ilike '"+filtro+"%' order by clave";
				break;
			case 8:
				f1="select cve_ent,cve_mun,cve_loc,cve_asen,nom_asen,tipo,fecha_act,cp,the_geom from cat_asen where clave ilike '"+filtro+"%' order by clave";
				break;
			case 9:
				f1="select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza as cvegeo,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,tipomza::text,ambito,the_geom,proy,img,fdg,vienede,ban,usuario from cat_manz where ban not in ('X','3','1','5','6','Y','E','D','H','G','M','I','N','O','K','R','T','C','J','L') and cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza ilike '"+filtro+"%' order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza ";
				break;
			case 92:
				f1="select cvegeo,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,cve_ft,cve_vial, cve_seg,the_geom from cat_fm where cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza ilike '"+filtro+"%' order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza ";
				break;
			case 10:
				f1="select cve_ent,cve_mun,cve_loc,cve_via,nom_via,tipo,the_geom from cat_vial where clave ilike '"+filtro+"%' order by clave";
				break;
			case 11:
				f1="select id,entidad,cgo1,nom_loc,err,the_geom from a_bd_loc where entidad ilike '"+filtro+"%' order by id";
				break;
			case 12:
				f1="select gid as Id,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,tipomza as tipomza_mc,cgo as cgo_mc,proc as resp,fresp,cve_def,tipo,status,nota,geom,cveoper,figura,mal from mcc_poblacion.cat_manz_modcar where ((figura='CENSOR' and status!=2) or (figura='TCAR')) and cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza ilike '"+filtro+"%' order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza ";
				break;
			case 121:
				f1="select gid as Id,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,cveft,cvevial,cveseg,codigoact as cgo_mc,status,geom from mcc_poblacion.frentes where baja is false  and ((figura='CENSOR' and status!=2) or (figura='TCAR')) and cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza||cveft ilike '"+filtro+"%' order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza||cveft ";
				break;
			case 122:
					f1="select gid as Id,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,nomgeo,codigoact as cgo_mc,proc as resp,fresp,cve_def,status,nota,geom,cveoper from mcc_poblacion.loc_rur where cvegeo ilike '"+filtro+"%' order by cve_ent||cve_mun||cve_loc||cve_ageb";
				break;
			case 22:
				f1="select gid as Id,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,ambito,tipo, tip_act,cvegeo, fecha_mod, f_registro ,proc , fresp , geom  from act_cu.bcu_bd_manzana where cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza ilike '"+filtro+"%' order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza";
				break;
			case 221:
				f1="select gid as Id,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,cveft,cvevial,cvevial1,cvevial2,cvevial3,cvegeo, geom , fecha_mod , procmz from act_cu.bcu_bd_frentes where cvegeo ilike '"+filtro+"%' order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza||cveft ";
				break;
			case 13:
				f1="select cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,the_geom,proy,img,fdg from cat_cd where cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza ilike '"+filtro+"%' order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza ";
				break;
			case 131:
				f1="select cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,the_geom,proy,img,fdg from cd_polext where cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','') ilike '"+filtro+"%' order by cve_ent||cve_mun||cve_loc||cve_ageb ";
				break;
			case 14:
				f1="select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza as cvegeo,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,tipomza::text,ambito,the_geom from cat_manz where ban not in ('X','3','1','5','6','Y','E','D','H','G','M','I','N','O','K','R','T','C','J','L') and cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza ilike '"+filtro+"%' union select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza as cvegeo,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,'9' as tipomza,tipo as ambito,st_transform(st_collect(st_triangle_32800(the_geom,5.3)),32800) as the_geom from cat_cd where cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza ilike '"+filtro+"%' group by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,tipo order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza";
				break;
			case 51:
				f1="select gid as id,cve_ent,fact,img,fdg,nfr_orden,nfr_noroe,the_geom from z_digf where cve_ent ilike '"+filtro+"%' order by gid ";
				break;
			case 52:
				f1="select gid as id,cve_ent,fact,img,fdg,the_geom from z_dige where cve_ent ilike '"+filtro+"%' order by gid ";
				break;
			case 53:
				f1="select gid as id,cve_ent,fact,img,fdg,baja,cve_baja,conviv,cvegeo,(select nombre from usuarios where us=cons) as usuario, forma,aplicado, case when cur=1 then 'CUR' else 'MG' end as criterio,cod as cod_act,the_geom from z_digmz where cvegeo ilike '"+filtro+"%' order by gid ";
				break;
			case 54:
				f1="select gid as id,cve_ent,cve_mun,cve_ageb,cve_loc,fact,img,fdg,conviv,cvegeo,(select nombre from usuarios where us=cons) as usuario,aplicado,the_geom from z_digpe where cvegeo ilike '"+filtro+"%' order by gid ";
				break;
			case 55:
				f1="select gid as id,cve_ent,fact,img,fdg,baja,cve_baja,cvegeo,(select nombre from usuarios where us=cons) as usuario,aplicado,the_geom from z_digmp where cvegeo ilike '"+filtro+"%' order by gid ";
				break;
			case 21:
				f1="select cve_ent,descripcion,fact,st_transform(the_geom,32800) as geom from cat_marks where cve_ent ilike '"+filtro+"%' order by fact";
				break;
			case 99:
				f1="select * from mcc_poblacion.inmuebles where cvegeo ilike '"+filtro+"%'";
				break;
			}
		}

		//out.println(f1);

		f1= f1+" limit 500000";
		String sexec="";
		String sFichero="";
		String user="-P actcar -u actcar";
		user="actcar";
		if (capa==0 || capa==1 || capa==2 || capa==3 || capa==5 || capa==7 || capa==8 || capa==10 || capa==11){
			hostbd=base;
		}

		//f1="SET CLIENT_ENCODING TO 'utf8';"+f1;
		//sexec ="set pgclientencoding=latin1 &&";
		//sexec =sexec + "D:\\Sitio\\PostgreSQL\\9.2\\bin\\pgsql2shp -f D:\\Sitio\\apps\\catalogos\\temp\\"+nom+".shp -h "+remotehostbd+" -p 5434 "+user+" "+hostbd+" \""+f1+"\"";
	
		sexec = "D:\\Sitio\\Tomcat\\webapps\\"+request.getContextPath()+"\\exporta.bat "+nom+" "+remotehostbd+" "+user+" "+hostbd+" \""+f1+"\"";
		//out.println(sexec);
		Runtime runtime = Runtime.getRuntime();
		Process exec = runtime.exec(sexec);
		int i = exec.waitFor();
		sFichero = "D:\\Sitio\\apps\\catalogos\\temp\\"+nom+".shp";
		File fichero = new File(sFichero);
		File file=new File(sFichero);
		if (file.exists()){
			out.println ("<center><br><table border=1>");
			out.println ("<tr class=n bgcolor=#BBBBBB><th>TIPO<th>LINK");
			out.println ("<tr align=center><td class=c align=center>PRJ<td align=center class=c><a href='http://"+request.getServerName()+":8888/catalogos/temp/"+nom+".prj'>Descargar<a>");
			out.println ("<tr align=center><td class=c align=center>SHX<td align=center class=c><a href='http://"+request.getServerName()+":8888/catalogos/temp/"+nom+".shx'>Descargar<a>");
			out.println ("<tr align=center><td class=c align=center>DBF<td align=center class=c><a href='http://"+request.getServerName()+":8888/catalogos/temp/"+nom+".dbf'>Descargar<a>");
			out.println ("<tr align=center><td class=c align=center>SHP<td align=center class=c><a href='http://"+request.getServerName()+":8888/catalogos/temp/"+nom+".shp'>Descargar<a>");
			out.println ("<tr align=center><td colspan=2 class=c>&nbsp;");
			out.println ("<tr align=center><td colspan=2 class=c>(Boton derecho, Guardar Como...)");
			//if (capa==53){
				out.println ("<tr align=center><td colspan=2 class=c>&nbsp;");
				//out.println ("<tr align=center><td colspan=2 class=c onclick='bajazip(\""+nom+"\")'><a href=#>Descargar ZIP para MCC</a>");
				out.println ("<tr align=center><td colspan=2 class=c onclick='bajazip(\""+nom+"\")'><a href=#>Descargar ZIP </a>");
			//}
			out.println ("</table>");

			///registra la descarga


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
          //out.println(registro);
				str.executeUpdate( registro);
        str.close();
        conexion.close();

		}else{
			out.println ("<center><br><table border=1>");
			out.println ("<tr class=n bgcolor=#BBBBBB><th>TIPO<th>LINK");
			out.println ("<tr align=center><td colspan=2 class=c>&nbsp;");
			out.println ("<tr align=center><td colspan=2 class=c>Falta informacion...");
			out.println ("<tr align=center><td colspan=2 class=c>&nbsp;");
			out.println ("</table>");
		}
	out.println ("<center><br><br><A class='liga2' HREF='"+request.getRequestURL()+"'>Descargar otro SHP...</a></center>");

	}
}

%>
</form>
</body>
</html>