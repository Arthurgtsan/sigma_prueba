<%@ page import="java.util.*" session="true" %>
<%@ page import="java.io.*"%>
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

  function envia(){
    document.enviar.submit();
}

window.resizeTo(500,300);

function buscazoomosm(lon,lat){
	var ban=0;
if (opener.busqueda.latitud.value==''){
	ban=1;
}
opener.busqueda.latitud.value=lat;
opener.busqueda.longitud.value=lon;
opener.enviar(500);
if (ban==1){
opener.busqueda.latitud.value='';
opener.busqueda.longitud.value='';
}

}

</script>

<style type="text/css">
table {
  border-collapse: collapse;
}
.t{font-size: 12pt; font-family: Arial; font-weight: bold; color: #000000;}
.c{font-family: Arial; font-size: 10pt; line-height: 1.3; font-weight: normal;}
.n{font-family: Arial; font-size: 10pt; line-height: 1.3; font-weight: bold;}
.r{font-family: Arial; font-size: 8pt; line-height: 1.3;}
.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}

</style>
<script language="javascrpt" type="text/javascript">

	</script>
<%
String  edo = request.getParameter("edo");
String  ni = request.getParameter("ni");
String  cons = request.getParameter("cons");
String ent="";
String nombre_base="";
int ran=0;
Random num = new Random();
ran = num.nextInt(100000);
String nom="";

if(ni.equals("11")){
	ent=edo;		
}else if(ni.equals("12") || ni.equals("13")){	
	if(cons.equals("00")){
		if(edo.equals("01")){
			nombre_base="actcargeo1";
		}else if(edo.equals("02")){
			nombre_base="actcargeo2";
		}else if(edo.equals("03")){
			nombre_base="actcargeo3";
		}else if(edo.equals("04")){
			nombre_base="actcargeo4";
		}else if(edo.equals("05")){
			nombre_base="actcargeo5";
		}else if(edo.equals("06")){
			nombre_base="actcargeo6";
		}else if(edo.equals("07")){
			nombre_base="actcargeo7";
		}else if(edo.equals("08")){
			nombre_base="actcargeo8";
		}else if(edo.equals("09")){
			nombre_base="actcargeo9";
		}	
	}else
	{
		ent=cons;	
	}
}

	if (ent.equals("08") || ent.equals("10") || ent.equals("32"))
	{
	nombre_base="actcargeo2";
	}
	if (ent.equals("02") || ent.equals("03") || ent.equals("25") || ent.equals("26"))
	{
		nombre_base="actcargeo1";
	}
	if (ent.equals("06") || ent.equals("14") || ent.equals("16") || ent.equals("18"))
	{
		nombre_base="actcargeo4";
	}
	if (ent.equals("05") || ent.equals("19") || ent.equals("28"))
	{
		nombre_base="actcargeo3";
	}
	if (ent.equals("01") || ent.equals("11") || ent.equals("22") || ent.equals("24"))
	{
		nombre_base="actcargeo5";
	}
	if (ent.equals("12") || ent.equals("17") || ent.equals("15"))
	{
		nombre_base="actcargeo6";
	}
	if  (ent.equals("13") || ent.equals("21") || ent.equals("29") || ent.equals("30") || ent.equals("09"))
	{
		nombre_base="actcargeo7";
	}
	if (ent.equals("07") || ent.equals("20") || ent.equals("27"))
	{
		nombre_base="actcargeo8";
	}
	if (ent.equals("04") || ent.equals("23") || ent.equals("31"))
	{
		nombre_base="actcargeo9";
	}

String cmd="";
String expor1="";
if (edo!=null){

	if(ni.equals("11"))
	{
		nom="te_prov_def2024_"+edo+".dbf";
		cmd ="D:\\Sitio\\PostgreSQL\\9.2\\bin\\pgsql2shp -f D:\\Sitio\\apps\\catalogos\\temp\\"+nom+" -h l-appwebmd1 -p 5434 -P actcar -u actcar "+nombre_base+" \"select gid_prov,operativo,cveoper_censor,cveoper_act,cvegeo_prov,cve_ent_prov as ent_ant,cve_mun_prov as mun_ant,cve_loc_prov as loc_ant,cve_ageb_prov  as ageb_ant,cve_mza_prov as mza_ant,tipo_prov as tipo_ant,fecha_prov,gid_def,cvegeo_def,cve_ent_def as ent_act,cve_mun_def as mun_act,cve_loc_def as loc_act,cve_ageb_def as ageb_act,cve_mza_def as mza_act,tipo_def as tipo_act,de,figura,status from temp_def_pob where (cve_ent_prov='"+edo+"' or cve_ent_def='"+edo+"')   order by de desc,cvegeo_prov,cvegeo_def\"";	
	}
	else if(ni.equals("12") || ni.equals("13"))
	{		
		if(cons.equals("00")){
			nom="te_prov_def2024_R_"+edo+".dbf";
			cmd ="D:\\Sitio\\PostgreSQL\\9.2\\bin\\pgsql2shp -f D:\\Sitio\\apps\\catalogos\\temp\\"+nom+" -h l-appwebmd1 -p 5434 -P actcar -u actcar "+nombre_base+" \"select gid_prov,operativo,cveoper_censor,cveoper_act,cvegeo_prov,cve_ent_prov as ent_ant,cve_mun_prov as mun_ant,cve_loc_prov as loc_ant,cve_ageb_prov  as ageb_ant,cve_mza_prov as mza_ant,tipo_prov as tipo_ant,fecha_prov,gid_def,cvegeo_def,cve_ent_def as ent_act,cve_mun_def as mun_act,cve_loc_def as loc_act,cve_ageb_def as ageb_act,cve_mza_def as mza_act,tipo_def as tipo_act,de,figura,status from temp_def_pob  order by de desc,cvegeo_prov,cvegeo_def\"";					
			
		}else{
			nom="te_prov_def2024_"+cons+".dbf";
			cmd ="D:\\Sitio\\PostgreSQL\\9.2\\bin\\pgsql2shp -f D:\\Sitio\\apps\\catalogos\\temp\\"+nom+" -h l-appwebmd1 -p 5434 -P actcar -u actcar "+nombre_base+" \"select gid_prov,operativo,cveoper_censor,cveoper_act,cvegeo_prov,cve_ent_prov as ent_ant,cve_mun_prov as mun_ant,cve_loc_prov as loc_ant,cve_ageb_prov  as ageb_ant,cve_mza_prov as mza_ant,tipo_prov as tipo_ant,fecha_prov,gid_def,cvegeo_def,cve_ent_def as ent_act,cve_mun_def as mun_act,cve_loc_def as loc_act,cve_ageb_def as ageb_act,cve_mza_def as mza_act,tipo_def as tipo_act,de,figura,status from temp_def_pob where (cve_ent_prov='"+cons+"' or cve_ent_def='"+cons+"')   order by de desc,cvegeo_prov,cvegeo_def\"";						
		}
	}

  expor1 = "<br><br><a href='http://"+request.getServerName()+":8888/catalogos/temp/"+nom+"'>Descargar DBF</a>";

  out.print("<br><center>Exportando...");
//out.flush();
//out.println(cmd);

try {
    String sFichero="";
    //out.println(f1);
    //out.println(sexec);
    Runtime runtime = Runtime.getRuntime();
    Process exec = runtime.exec(cmd);
    int i = exec.waitFor();
    sFichero = "D:\\Sitio\\apps\\catalogos\\temp\\"+nom;
    File fichero = new File(sFichero);
    File file=new File(sFichero);

    if (file.exists()){
      out.println (expor1);
    }else{
      out.println ("<br><br>Falta informacion");
    }
  }
    catch(Exception ex){
        out.println (ex);
        out.println(cmd);
    }
finally{
//out.println(expor1);
}
}
%>

</html>