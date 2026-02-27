<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Expires" content="0">
  <meta http-equiv="Last-Modified" content="0">
  <meta http-equiv="Cache-Control" content="no-cache, mustrevalidate">
  <meta http-equiv="Pragma" content="no-cache">
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
<script language="javascrpt" type="text/javascript">
window.resizeTo(500,300);
function desc(){
		if (document.enviar.filtro.value.length<2){
			alert ("Debe de proporcionar algun filtro!!");
			return false;
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
<form action="adescarga.jsp" method="get" name="enviar">
<%

String ban = request.getParameter("ban");
String capa = request.getParameter("capa");
try {
	if (ban==null){
		out.println ("<center><br><table border=1 cellpadding=2>"+
		"<tr class=n bgcolor=#BBBBBB align=center><th colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Descargar informacion en SHP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
		"<tr class=n align=center><td class=n align=right>Capa:&nbsp;&nbsp;<td align=left>&nbsp;&nbsp;<select class=c name=capa>"+
		"<option value=0>Manzanas CM+RA+SE</option>"+
		"<option value=1>Frentes CM+RA+SE</option>"+
		"</select>"+
		"<tr class=c align=center><td class=n align=right>Forma:&nbsp;&nbsp;<td align=left class=c>"+
		
		"&nbsp;&nbsp;<input class='boton' type='radio' name='forma' value='2' checked>Por filtro de clave"+
		"<tr class=c align=center><td class=n align=right>Filtro:&nbsp;&nbsp;<td align=left class=c>&nbsp;&nbsp;<input class='boton' type='text' name='filtro'>"+
		"<input type='hidden' name=ban>");
		out.println ("<tr><td colspan=2>&nbsp;<tr><td nowrap colspan=2 align=center><input class='boton' type='Button' name='descargar' onClick='desc();' value=' Descargar SHP '/>");
	}else{
	  String filtro = request.getParameter("filtro").replace("-","");
		Random rnd = new Random();
		String nom="Exp_"+rnd.nextInt(10000);
		String f1="",f2="";
		String base="actcargeo10";
			if (capa.equals("0")){
				f1="select cveoper,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,log_act,the_geom_itrf08 from mcc_poblacion.view_cartografia_mza where cvegeo ilike '"+filtro+"%' order by cvegeo";
			}else if (capa.equals("1")){
				f1="select cveoper,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,cveft,the_geom_itrf08 from mcc_poblacion.view_cartografia_fr where cvegeo ilike '"+filtro+"%' order by cvegeo";
			}
	
		String sexec="";
		String sFichero="";
		String user="";
			String remotehostbd="10.153.3.25 -p 5434";
			String hostbd=base;
			user=" -P actcar -u actcar ";
		sexec ="D:\\Sitio\\PostgreSQL\\9.2\\bin\\pgsql2shp -f D:\\Sitio\\apps\\catalogos\\temp\\"+nom+".shp -h "+remotehostbd+" "+user+" "+base+" \""+f1+"\"";
		//out.println(f1);
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
    catch(Exception ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion: "+ex.getMessage()+" !\");");
      out.println("</script>");
    }

%>
</form>
</body>
</html>