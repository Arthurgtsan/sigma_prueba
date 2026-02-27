<%@ page import="java.util.*" %>
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

  function envia(){
    document.enviar.submit();
}

window.resizeTo(1600,800);

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
<%
String  ni = request.getParameter("ni");
String  ent = request.getParameter("ent");
%>
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
var entidad="";
var regional="";
	function incon(ent,ni,filent){
		//alert(filent);
		if(ent.toString().length==1){
			entidad="0"+ent;
		}else{
		entidad=ent;			
		}
		if(filent.toString().length==1){
			regional="0"+filent;
		}else{
			regional=filent;			
		}
		
		//ventana = window.open('inconsistencias.php?ent='+entidad,'Editar','toolbar=no,Resizable');
		ventana = window.open('inconsistencias.jsp?ent='+entidad+"&ni="+ni+"&edo="+regional,'Editar','toolbar=no,Resizable');
		ventana.focus();
}
var edostr="";
var ni_des="";
var conststr="";
function exp(edo,ni,cons){
	edostr=edo.toString().padStart(2,"0");
	ni_des=ni.toString().padStart(2,"0");
	conststr=cons.toString().padStart(2,"0");
	//alert(conststr);
ventana = window.open("exp_dbf.jsp?edo="+edostr+"&ni="+ni_des+"&cons="+conststr,'Exportar','scrollbars=no,toolbar=no');
}
	</script>
<%
out.println( "<center class='t'>Tablas de Equivalencia Provisional Definitiva<br><br>");

//ejemplo de substring
//String str3 = "Hello world!";
//String res3 = str3.substring(0, 1);
//out.println(res3); 

String ni="00";
String consulta="";
String filtro="";
String select="",filent="",where2="";
filent = request.getParameter("filent");
String nombre_base="actcargeo1";
String cadena="";
String  buscar = request.getParameter("gender");
int count=1;

if (filent==null){
  filent="00";
}
if (buscar==null){
  buscar="Todo";
}

if (ent=="00"){
	out.println("00");
}

if(ni.equals("11")){
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
}

//out.println( "<form  method=\"post\" name=\"enviar\">");
int tama=0;

	if(ent.equals("01") || ent.equals("04") || ent.equals("05") )
		{tama=4;}
		else if( ent.equals("02") || ent.equals("03") || ent.equals("06") || ent.equals("08") || ent.equals("09"))
		{tama=3;}
		else if(ent.equals("07"))
		{tama=5;}



if(ni.equals("11")){
	out.println( "<form  method=\"post\" name=\"enviar\">");
	consulta= " where (cve_ent_prov='"+ent+"' or cve_ent_def='"+ent+"')";
}
if(ni.equals("12")){
  //out.println( "<form  method=\"post\" name=\"enviar\">");
  String[] array_estados=new String[tama];
		switch(ent){
			case "01":
				nombre_base="actcargeo1";
				consulta= " where (cve_ent_prov='02' or cve_ent_prov='03' or cve_ent_prov='25' or cve_ent_prov='26'";
				consulta+=" or cve_ent_def='02' or cve_ent_def='03' or cve_ent_def='25' or cve_ent_def='26')";
				array_estados[0] = "02"; array_estados[1] = "03"; array_estados[2] = "25"; array_estados[3] = "26";

			break;
			case "02":
				nombre_base="actcargeo2";
				consulta= " where (cve_ent_prov='10' or cve_ent_prov='08' or cve_ent_prov='32'";
				consulta+=" or cve_ent_def='10' or cve_ent_def='08' or cve_ent_def='32')";
				array_estados[0] = "08"; array_estados[1] = "10"; array_estados[2] = "32";
			break;
			case "03":
				nombre_base="actcargeo3";
				consulta= " where (cve_ent_prov='28' or cve_ent_prov='05' or cve_ent_prov='19'";
				consulta+=" or cve_ent_def='28' or cve_ent_def='05' or cve_ent_def='19')";
				array_estados[0] = "05"; array_estados[1] = "19"; array_estados[2] = "28";
			break;
			case "04":
				nombre_base="actcargeo4";
				consulta= " where (cve_ent_prov='18' or cve_ent_prov='16' or cve_ent_prov='14' or cve_ent_prov='06'";
				consulta+=" or cve_ent_def='18' or cve_ent_def='16' or cve_ent_def='14' or cve_ent_def='06')";
				array_estados[0] = "06"; array_estados[1] = "14"; array_estados[2] = "16"; array_estados[3] = "18";
			break;
			case "05":
				nombre_base="actcargeo5";
				consulta= " where (cve_ent_prov='11' or cve_ent_prov='24' or cve_ent_prov='22' or cve_ent_prov='01'";
				consulta+=" or cve_ent_def='11' or cve_ent_def='24' or cve_ent_def='22' or cve_ent_def='01')";
				array_estados[0] = "01"; array_estados[1] = "11"; array_estados[2] = "22"; array_estados[3] = "24";
			break;
			case "06":
				nombre_base="actcargeo6";
				consulta= " where (cve_ent_prov='15' or cve_ent_prov='17' or cve_ent_prov='12'";
				consulta+=" or cve_ent_def='15' or cve_ent_def='17' or cve_ent_def='12')";
				array_estados[0] = "12";array_estados[1] = "15"; array_estados[2] = "17";
			break;
			case "07":
				nombre_base="actcargeo7";
				consulta= " where (cve_ent_prov='30' or cve_ent_prov='29' or cve_ent_prov='21' or cve_ent_prov='13' or cve_ent_prov='09'";
				consulta+=" or cve_ent_def='30' or cve_ent_def='29' or cve_ent_def='21' or cve_ent_def='13' or cve_ent_def='09')";
				array_estados[0] = "09"; array_estados[1] = "13"; array_estados[2] = "21"; array_estados[3] = "29"; array_estados[4] = "30";
			break;
			case "08":
				nombre_base="actcargeo8";
				consulta= " where (cve_ent_prov='27' or cve_ent_prov='20' or cve_ent_prov='07'";
				consulta+=" or cve_ent_def='27' or cve_ent_def='20' or cve_ent_def='07')";
				array_estados[0] = "07"; array_estados[1] = "20"; array_estados[2] = "27";
			break;
			case "09":
				nombre_base="actcargeo9";
				consulta= " where (cve_ent_prov='23' or cve_ent_prov='31' or cve_ent_prov='04'";
				consulta+=" or cve_ent_def='23' or cve_ent_def='31' or cve_ent_def='04')";
				array_estados[0] = "04"; array_estados[1] = "23"; array_estados[2] = "31";
			break;
		}


		if (filent.equals("00")){

		out.println( "<form  method=\"post\" name=\"enviar\">");
		select="<select name=filent class='boton'  onChange='envia();''>";
		select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
				for (int i=0;i<array_estados.length;i++){
						if(array_estados[i].equals(array_estados[tama-1])){
								select+="<option value='"+array_estados[i]+"' ";if (filent.equals(array_estados[i])){select+="selected";}select+="><b>"+array_estados[i]+"</b></option></select>";
						}else{
								select+="<option value='"+array_estados[i]+"' ";if (filent.equals(array_estados[i])){select+="selected";}select+="><b>"+array_estados[i]+"</b></option>";
							 }
				}
		out.println ("&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>Filtrar por estado:</font>&nbsp;"+select+"<br><br>");
		}else{
		consulta= " where (cve_ent_prov='"+filent+"' or cve_ent_def='"+filent+"')";
		out.println( "<form  method=\"post\" name=\"enviar\">");
		select="<select name=filent class='boton'  onChange='envia();''>";
		select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
				for (int i=0;i<array_estados.length;i++){
						if(array_estados[i].equals(array_estados[tama-1])){
								select+="<option value='"+array_estados[i]+"' ";if (filent.equals(array_estados[i])){select+="selected";}select+="><b>"+array_estados[i]+"</b></option></select>";
						}else{
								select+="<option value='"+array_estados[i]+"' ";if (filent.equals(array_estados[i])){select+="selected";}select+="><b>"+array_estados[i]+"</b></option>";
							 }
				}
		out.println ("&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>Filtrar por estado:</font>&nbsp;"+select+"<br><br>");
		}
 }

if(ni.equals("13")){

		if (filent.equals("00")){

		String array_estados[] = {"01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32"};
		out.println( "<form  method=\"post\" name=\"enviar\">");
		select="<select   name=filent class='boton'  onChange='envia();''>";

		select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">Seleccionar</option>";
				for (int i=0;i<array_estados.length;i++){
						if(array_estados[i].equals("32")){
								select+="<option value='"+array_estados[i]+"' ";if (filent.equals(array_estados[i])){select+="selected";}select+="><b>"+array_estados[i]+"</b></option></select>";
						}else{
								select+="<option value='"+array_estados[i]+"' ";if (filent.equals(array_estados[i])){select+="selected";}select+="><b>"+array_estados[i]+"</b></option>";
							 }
				}

		out.println ("&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>Filtrar por estado:</font>&nbsp;"+select+"<br><br>");
		}else{

				if (filent.equals("08") || filent.equals("10") || filent.equals("32"))
				{
					nombre_base="actcargeo2";
				}
				if (filent.equals("02") || filent.equals("03") || filent.equals("25") || filent.equals("26"))
				{
					nombre_base="actcargeo1";
				}
				if (filent.equals("06") || filent.equals("14") || filent.equals("16") || filent.equals("18"))
				{
					nombre_base="actcargeo4";
				}
				if (filent.equals("05") || filent.equals("19") || filent.equals("28"))
				{
					nombre_base="actcargeo3";
				}
				if (filent.equals("01") || filent.equals("11") || filent.equals("22") || filent.equals("24"))
				{
					nombre_base="actcargeo5";
				}
				if (filent.equals("12") || filent.equals("17") || filent.equals("15"))
				{
					nombre_base="actcargeo6";
				}
				if  (filent.equals("09") || filent.equals("13") || filent.equals("21") || filent.equals("29") || filent.equals("30"))
				{
					nombre_base="actcargeo7";
				}
				if (filent.equals("07") || filent.equals("20") || filent.equals("27") )
				{
					nombre_base="actcargeo8";
				}
				if (filent.equals("04") || filent.equals("23") || filent.equals("31"))
				{
					nombre_base="actcargeo9";
				}



			consulta= " where (cve_ent_prov='"+filent+"' or cve_ent_def='"+filent+"')";
		String array_estados[] = {"01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32"};
		out.println( "<form  method=\"post\" name=\"enviar\">");

		select="<select name=filent class='boton'  onChange='envia();''>";
		select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">Seleccionar</option>";
				for (int i=0;i<array_estados.length;i++){
						if(array_estados[i].equals("32")){
								select+="<option value='"+array_estados[i]+"' ";if (filent.equals(array_estados[i])){select+="selected";}select+="><b>"+array_estados[i]+"</b></option></select>";
						}else{
								select+="<option value='"+array_estados[i]+"' ";if (filent.equals(array_estados[i])){select+="selected";}select+="><b>"+array_estados[i]+"</b></option>";
							 }
				}
		out.println ("&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>Filtrar por estado:</font>&nbsp;"+select+"<br><br>");



		}
		}




	if(buscar.equals("Todo")){
	out.println ("<input type='radio' id='gender1' name='gender' value='Todo' onChange='envia();' checked><b class=n>Todo</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender2' name='gender' value='localidad' onChange='envia();'><b class=n>Localidad</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender3' name='gender' value='manzana' onChange='envia();'><b class=n>Manzana</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender4' name='gender' value='caserio' onChange='envia();'><b class=n>Caserio</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender5' name='gender' value='RegNar'  onChange='envia();'><b class=n><font color='#F87006'>Inconsistencias</font></b>");
	filtro="";
	}else if(buscar.equals("localidad")){
	out.println ("<input type='radio' id='gender1' name='gender' value='Todo' onChange='envia();' ><b class=n>Todo</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender2' name='gender' value='localidad' onChange='envia();' checked><b class=n>Localidad</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender3' name='gender' value='manzana' onChange='envia();'><b class=n>Manzana</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender4' name='gender' value='caserio' onChange='envia();'><b class=n>Caserio</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender5' name='gender' value='RegNar'  onChange='envia();'><b class=n><font color='#F87006'>Inconsistencias</font></b>");
	filtro=" and (de='L' or de='L-L' or de='L-M' or de='L-C')";
	}else if(buscar.equals("manzana")){
	out.println ("<input type='radio' id='gender1' name='gender' value='Todo' onChange='envia();'><b class=n>Todo</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender2' name='gender' value='localidad' onChange='envia();'><b class=n>Localidad</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender3' name='gender' value='manzana' onChange='envia();' checked><b class=n>Manzana</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender4' name='gender' value='caserio' onChange='envia();'><b class=n>Caserio</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender5' name='gender' value='RegNar'  onChange='envia();'><b class=n><font color='#F87006'>Inconsistencias</font></b>");
	filtro=" and (de='M' or de='M-M' or de='M-L' or de='M-C')";
	}else if(buscar.equals("caserio")){
	out.println ("<input type='radio' id='gender1' name='gender' value='Todo' onChange='envia();'><b class=n>Todo</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender2' name='gender' value='localidad' onChange='envia();'><b class=n>Localidad</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender3' name='gender' value='manzana' onChange='envia();' ><b class=n>Manzana</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender4' name='gender' value='caserio' onChange='envia();' checked><b class=n>Caserio</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender5' name='gender' value='RegNar'  onChange='envia();'><b class=n><font color='#F87006'>Inconsistencias</font></b>");
	filtro=" and (de='C' or de='C-C' or de='C-M' or de='C-L')";
	}else if(buscar.equals("RegNar")){
	out.println ("<input type='radio' id='gender1' name='gender' value='Todo' onChange='envia();'><b class=n>Todo</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender2' name='gender' value='localidad' onChange='envia();'><b class=n>Localidad</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender3' name='gender' value='manzana' onChange='envia();' ><b class=n>Manzana</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender4' name='gender' value='caserio' onChange='envia();' ><b class=n>Caserio</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender5' name='gender' value='RegNar'  onChange='envia();'checked><b class=n><font color='#F87006'>Inconsistencias</font></b>");
	//filtro=" and (de='C' or de='C-C' or de='C-M' or de='C-L')";
	}
	else{
	out.println ("<input type='radio' id='gender1' name='gender' value='Todo' onChange='envia();' checked><b class=n>Todo</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender2' name='gender' value='localidad' onChange='envia();'><b class=n>Localidad</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender3' name='gender' value='manzana' onChange='envia();'><b class=n>Manzana</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender4' name='gender' value='caserio' onChange='envia();'><b class=n>Caserio</b>&nbsp;&nbsp;&nbsp;");
	out.println ("<input type='radio' id='gender5' name='gender' value='RegNar'  onChange='envia();'><b class=n><font color='#F87006'>Inconsistencias</font></b>");
	filtro="";
	}

		out.println ("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' align='right' name='enviar' value='Inconsistencias' onclick='incon("+ent.toString()+","+ni+","+filent+");' class='boton'>");
		out.println ("<center class='t'><br>");

if(filent.equals("00") && ni.equals("13")){
	String  campos="";
	campos="<table border=1 ><tr onmouseover='this.style.background=#c0c0c0' onmouseout='this.style.background=#F87006' class=n bgcolor=#DBDBD>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>&nbsp;No&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>&nbsp;Cveoper&nbsp;<br>Censor</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>Cvegeo<br>&nbsp;&nbsp;Provisional&nbsp;&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>Clave<br>Entidad<br>&nbsp;Provisional&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>Clave<br>Municipio<br>&nbsp;Provisional&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>Clave<br>Localidad<br>&nbsp;Provisional&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>Clave<br>Ageb<br>&nbsp;Provisional&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>Clave<br>Manzana<br>&nbsp;Provisional&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>Tipo<br>&nbsp;Provisional&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>Fecha<br>&nbsp;Provisional&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>Cvegeo<br>&nbsp;Definitiva&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>Clave<br>Entidad<br>&nbsp;Definitiva&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>Clave<br>Municipio<br>&nbsp;Definitiva&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>Clave<br>Localidad<br>&nbsp;Definitiva&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>Clave<br>Ageb<br>&nbsp;Definitiva&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>Clave<br>Manzana<br>&nbsp;Definitiva&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>Tipo<br>&nbsp;Definitiva&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>&nbsp;De&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>&nbsp;Figura&nbsp;</strong>";
		out.println(campos);
		out.println("<tr class='n' align=center><td colspan=19>No existen datos.....");
}else{

	 String  campos="";
	 String datos="";
	 int colorfila=0;
	 String color="";
      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
	  conexion = DriverManager.getConnection(
                                             "jdbc:postgresql://l-appwebmd1:5434/"+nombre_base,
                                             "arcgis",
                                             "arcgis"
                                            );
											//out.println (nombre_base);
	  str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      rs = str.executeQuery("select *  from manz_afect2 "+consulta+ cadena+ filtro+" order by de desc,cvegeo_prov,cvegeo_def;" );
	  //out.println("select *  from manz_afect2 "+consulta+ cadena+ filtro+" order by de desc,cvegeo_prov,cvegeo_def;" );
String consulta_com="select *  from manz_afect2 "+consulta+ cadena+ filtro+" order by de desc,cvegeo_prov,cvegeo_def;" ;



		campos="<table border=1><tr onmouseover='this.style.background=#c0c0c0' onmouseout='this.style.background="+color+"' class=n bgcolor=#DBDBD>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>&nbsp;No&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>&nbsp;Cveoper&nbsp;<br>Censor</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>Cvegeo<br>&nbsp;Provisional&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>Clave<br>Entidad<br>&nbsp;Provisional&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>Clave<br>Municipio<br>&nbsp;Provisional&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>Clave<br>Localidad<br>&nbsp;Provisional&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>Clave<br>Ageb<br>&nbsp;Provisional&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>Clave<br>Manzana<br>&nbsp;Provisional&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>Tipo<br>&nbsp;Provisional&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>Fecha<br>&nbsp;Provisional&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>Cvegeo<br>&nbsp;Definitiva&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>Clave<br>Entidad<br>&nbsp;Definitiva&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>Clave<br>Municipio<br>&nbsp;Definitiva&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>Clave<br>Localidad<br>&nbsp;Definitiva&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>Clave<br>Ageb<br>&nbsp;Definitiva&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>Clave<br>Manzana<br>&nbsp;Definitiva&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>Tipo<br>&nbsp;Definitiva&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>&nbsp;De&nbsp;</strong>";
		campos+="<td align=center style='background-color:#9ED7EE;'><strong>&nbsp;Figura&nbsp;</strong>";
		out.println(campos);
		String st="";
		String salida="";
		int ban=0;



	while(rs.next()){
			/*if (colorfila==0){
				color= "#EEFDF8";
				colorfila=1;
			}else{
				color="";
				colorfila=0;
				}
*/
            String s1=rs.getObject(2).toString();//cveoper_censor
            String s2=rs.getObject(3).toString();//cvegeo_prov
            String s3=rs.getObject(4).toString();//cve_ent_prov
            String s4=rs.getObject(5).toString();//cve_mun_prov
            String s5=rs.getObject(6).toString();//cve_loc_prov
            String s6=rs.getObject(7).toString();//cve_ageb_prov
            String s7=rs.getObject(8).toString();//cve_mza_prov
			String s8=rs.getObject(9).toString();//tipo_prov
			String s9=rs.getObject(10).toString();//fecha_prov

			String s10=rs.getObject(12).toString();//cvegeo_def
			String s11=rs.getObject(13).toString();//cve_ent_def
			String s12=rs.getObject(14).toString();//cve_mun_def
			String s13=rs.getObject(15).toString();//cve_loc_def
			String s14=rs.getObject(16).toString();//cve_ageb_def
			String s15=rs.getObject(17).toString();//cve_mza_def
			String s16=rs.getObject(18).toString();//tipo_def
			String s17=rs.getObject(19).toString();//de
			String s18=rs.getObject(23).toString();//Figura

		if(buscar.equals("RegNar")){
		    if (((Integer.parseInt(s7)<700 || Integer.parseInt(s15)>899  || s10 ==null) && s17.substring(0, 1).equals("M")) || ((Integer.parseInt(s7)!=800 || Integer.parseInt(s15)>899  || s10 ==null) && s17.substring(0, 1).equals("C")) || (( Integer.parseInt(s5)<9000  || s10 ==null) && s17.substring(0, 1).equals("L")) || s16.equals("X")){

			datos= "<tr onmouseover=this.style.background='#c0c0c0' onmouseout=this.style.background='"+color+"' class=c bgcolor=#ffc299  align=center>";
			datos+="<td align=center>&nbsp;&nbsp;"+count+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s1+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s2+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s3+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s4+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s5+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s6+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s7+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s8+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s9+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s10+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s11+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s12+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s13+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s14+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s15+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s16+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s17+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s18+"&nbsp;&nbsp;";
			out.println(datos);
				count+=1;
			}
		}else{
			if (((Integer.parseInt(s7)<700 || Integer.parseInt(s15)>899  || s10 ==null) && s17.substring(0, 1).equals("M")) || ((Integer.parseInt(s7)!=800 || Integer.parseInt(s15)>899  || s10 ==null) && s17.substring(0, 1).equals("C")) || (( Integer.parseInt(s5)<9000  || s10 ==null) && s17.substring(0, 1).equals("L")) || s16.equals("X")){
				datos= "<tr onmouseover=this.style.background='#c0c0c0' onmouseout=this.style.background='"+color+"' class=c bgcolor=#ffc299  align=center >";
			}else{
				datos= "<tr onmouseover=this.style.background='#c0c0c0' onmouseout=this.style.background='"+color+"' class=c  align=center bgcolor='"+color+"'>";
			}
			datos+="<td align=center>&nbsp;&nbsp;"+count+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s1+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s2+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s3+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s4+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s5+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s6+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s7+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s8+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s9+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s10+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s11+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s12+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s13+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s14+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s15+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s16+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s17+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s18+"&nbsp;&nbsp;";
			out.println(datos);
				count+=1;
		}
	}
	out.println("</table><br><br>");
	  rs.close();
      str.close();
      conexion.close();
		if(ni.equals("11")){
		  out.println("<input class='boton' type='Button' onClick='exp("+ent+","+ni+","+filent+");' value=' Exportar a DBF '/>");
	  }
	  if(ni.equals("12") || ni.equals("13")){
		  //out.println(filent);//
		  out.println("<input class='boton' type='Button' onClick='exp("+ent+","+ni+","+filent+");' value=' Exportar a DBF '/>");

	  }

	  //out.println("<input class='boton' type='Button' onClick='exp("+"01"+","+filent+");' value=' Exportar a DBF '/>");




}
%>

</html>