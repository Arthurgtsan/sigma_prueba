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

window.resizeTo(1200,600);

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
.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;   }
select, option {
    line-height: 0;       /* Reduce el espacio entre líneas */
    padding: 0px;         /* Ajusta el padding interno */
    font-size: 12px;      /* Reduce el tamaño de la fuente si es necesario */
}

</style>
<%
out.println( "<center class='t'>ERRORES DE VALIDACIONES<br><br>");
String  ni = request.getParameter("ni");
String  sinloc = request.getParameter("sinloc");
String  ent = request.getParameter("ent");
String consulta="";
String select="",filent="",where2="" ,select2="" ,filent2="";
filent = request.getParameter("filent");
filent2 = request.getParameter("filent2");


if (filent==null){
  filent="00";
}
if (filent2==null){
  filent2="00";
}

int tama=0;

	if(ent.equals("01") || ent.equals("04") || ent.equals("05") || ent.equals("07"))
		{tama=4;}
		else if( ent.equals("02") || ent.equals("03") || ent.equals("06") || ent.equals("08") || ent.equals("09"))
		{tama=3;}
		else if(ent.equals("10"))
		{tama=1;}

if(ni.equals("11")){
consulta= " where cve_ent='"+ent+"' ";
		String array_estados[] = {ent};
		out.println( "<form  method=\"post\" name=\"enviar\"><center class='t'>");
		select="<select name=filent class='boton'  onChange='envia();'>";
		//select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
				for (int i=0;i<array_estados.length;i++){
								select+="<option value='"+array_estados[i]+"' ";if (filent.equals(array_estados[i])){select+="selected";}select+="><b>"+array_estados[i]+"</b></option></select>";
						}



}
 if(ni.equals("12")){
  String[] array_estados=new String[tama];
		switch(ent){
			case "01":
				consulta= " where (cve_ent='02' or cve_ent='03' or cve_ent='25' or cve_ent='26') ";
				array_estados[0] = "02"; array_estados[1] = "03"; array_estados[2] = "25"; array_estados[3] = "26";
			break;
			case "02":
				consulta= " where (cve_ent='10' or cve_ent='08' or cve_ent='32') ";
				array_estados[0] = "08"; array_estados[1] = "10"; array_estados[2] = "32";
			break;
			case "03":
				consulta= " where (cve_ent='28' or cve_ent='05' or cve_ent='19') ";
				array_estados[0] = "05"; array_estados[1] = "19"; array_estados[2] = "28";
			break;
			case "04":
				consulta= " where (cve_ent='18' or cve_ent='16' or cve_ent='14' or cve_ent='06') ";
				array_estados[0] = "06"; array_estados[1] = "14"; array_estados[2] = "16"; array_estados[3] = "18";
			break;
			case "05":
				consulta= " where (cve_ent='11' or cve_ent='24' or cve_ent='22' or cve_ent='01') ";
				array_estados[0] = "01"; array_estados[1] = "11"; array_estados[2] = "22"; array_estados[3] = "24";
			break;
			case "06":
				consulta= " where (cve_ent='15' or cve_ent='17' or cve_ent='12') ";
				array_estados[0] = "12";array_estados[1] = "15"; array_estados[2] = "17";
			break;
			case "07":
				consulta= " where (cve_ent='30' or cve_ent='29' or cve_ent='21' or cve_ent='13') ";
				array_estados[0] = "13"; array_estados[1] = "21"; array_estados[2] = "29"; array_estados[3] = "30";
			break;
			case "08":
				consulta= " where (cve_ent='27' or cve_ent='20' or cve_ent='07') ";
				array_estados[0] = "07"; array_estados[1] = "20"; array_estados[2] = "27";
			break;
			case "09":
				consulta= " where (cve_ent='23' or cve_ent='31' or cve_ent='04') ";
				array_estados[0] = "04"; array_estados[1] = "23"; array_estados[2] = "31";
			break;
			case "10":
				consulta= " where cve_ent='09' ";
				array_estados[0] = "09";
			break;
		}

		if (filent.equals("00")){

		out.println( "<form  method=\"post\" name=\"enviar\"><center class='t'>");
		select="<select name=filent class='boton'  onChange='envia();''>";
		select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
				for (int i=0;i<array_estados.length;i++){
						if(array_estados[i].equals(array_estados[tama-1])){
								select+="<option value='"+array_estados[i]+"' ";if (filent.equals(array_estados[i])){select+="selected";}select+="><b>"+array_estados[i]+"</b></option></select>";
						}else{
								select+="<option value='"+array_estados[i]+"' ";if (filent.equals(array_estados[i])){select+="selected";}select+="><b>"+array_estados[i]+"</b></option>";
							 }
				}

		}else{
		consulta= " where cve_ent='"+filent+"' ";
		out.println( "<form  method=\"post\" name=\"enviar\"><center class='t'>");
		select="<select name=filent class='boton'  onChange='envia();''>";
		select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
				for (int i=0;i<array_estados.length;i++){
						if(array_estados[i].equals(array_estados[tama-1])){
								select+="<option value='"+array_estados[i]+"' ";if (filent.equals(array_estados[i])){select+="selected";}select+="><b>"+array_estados[i]+"</b></option></select>";
						}else{
								select+="<option value='"+array_estados[i]+"' ";if (filent.equals(array_estados[i])){select+="selected";}select+="><b>"+array_estados[i]+"</b></option>";
							 }
				}

		}
 }

if(ni.equals("13")){

		if (filent.equals("00")){

		String array_estados[] = {"01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32"};
		out.println( "<form  method=\"post\" name=\"enviar\"><center class='t'>");
		select="<select   name=filent class='boton'  onChange='envia();''>";

		select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
				for (int i=0;i<array_estados.length;i++){
						if(array_estados[i].equals("32")){
								select+="<option value='"+array_estados[i]+"' ";if (filent.equals(array_estados[i])){select+="selected";}select+="><b>"+array_estados[i]+"</b></option></select>";
						}else{
								select+="<option value='"+array_estados[i]+"' ";if (filent.equals(array_estados[i])){select+="selected";}select+="><b>"+array_estados[i]+"</b></option>";
							 }
				}


		}else{
			consulta= " where cve_ent='"+filent+"' ";
		String array_estados[] = {"01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32"};
		out.println( "<form  method=\"post\" name=\"enviar\"><center class='t'>");
		select="<select name=filent class='boton'  onChange='envia();'>";
		select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
				for (int i=0;i<array_estados.length;i++){
						if(array_estados[i].equals("32")){
								select+="<option value='"+array_estados[i]+"' ";if (filent.equals(array_estados[i])){select+="selected";}select+="><b>"+array_estados[i]+"</b></option></select>";
						}else{
								select+="<option value='"+array_estados[i]+"' ";if (filent.equals(array_estados[i])){select+="selected";}select+="><b>"+array_estados[i]+"</b></option>";
							 }
				}


		}
}


String sinlochec="";
String sinlocons="";
//out.println(consulta);
if (!(sinloc == null)){
	sinlochec="checked";
	if (consulta == ""){
		sinlocons=" where resultado!='(L) Localidad (Plano) no interseca con Manzana' ";
	}else{
		sinlocons=" and resultado!='(L) Localidad (Plano) no interseca con Manzana' ";
	}
}



String consErr="";

	if (filent2.equals("00")){
		consErr="";
	}else if(filent.equals("00") && ni.equals("13")) {
			consErr= " where resultado ilike '%"+filent2+"%' ";
	}else{
		consErr= " and resultado ilike '%"+filent2+"%' ";
	}

		//String array_estados[] = {"(M) Error geometria","(M) Error geometria: Multipoligono","(M) Sin Localidad en Catalogo Unico","(C) Sin Localidad en Catalogo Unico","(M) Sin clave de Poligono Rural","(C) Sin clave de Poligono Externo","(M) No interseca con Poligono Rural","(C) No interseca con Poligono Externo","(M) No interseca con Poligono Rural","(C) No interseca con Poligono Externo","(M) Sin clave de poligono de AGEB urbana","(C) Sin clave de poligono de AGEB urbana","(M) No interseca con AGEB urbana","(C) No interseca con PEM","(M) No interseca con AGEB urbana","(C) interseca con L"};

				String array_estados[] = {
					"Digito verificador erroneo",      							//1
					"Error geometria",															//2
					"Interseca con L",
					"Interseca con Localidad Puntual",
					"Interseca con Manzana",
					"Interseca con PE",
					"Interseca con AGEB",
					"Localidad (Croquis) no interseca con PE",
					"Localidad (Plano) no interseca con Manzana",
					"Mal en la conformacion de la clave",
					"No interseca con AGEB urbana",
					"No interseca con PEM",
					"No interseca con Poligono Externo",
					"No interseca con Poligono Rural",
					"Sin clave de poligono de AGEB urbana",
					"Sin clave de Poligono Externo",
					"Sin clave de Poligono Rural",
					"Sin Localidad en Catalogo Unico",
					"Interseca con PEM",
					"No tiene caserio",
					"Lejos de su localidad",											//21
					"Frentes mal cerrados",												//22
					"Frentes duplicados",													//23
					"Manzana sin frentes",												//24
					"Manzanas con un solo frente",								//25
					"EIC" 																				//26
					};

		//out.println( "<form  method=\"post\" name=\"enviar\"><center class='t'>");
		select2="<select name=filent2 class='boton'  onChange='envia();'>";
		select2+="<option value='00' ";if (filent2.equals("00")){select2+="selected";}select2+=">TODAS</option>";
				for (int i=0;i<array_estados.length;i++){
								if (i==0 || i==1 || i==3 || i==4 || i==8 || i==13 || i==14 || i==15 || i==16  ) {
								//select2+="<option style='background-color: #EA3A3A' value='"+array_estados[i]+"' ";if (filent2.equals(array_estados[i])){select2+="selected";}select2+=">"+array_estados[i]+"</option>";
								select2+="<option value='"+array_estados[i]+"' ";if (filent2.equals(array_estados[i])){select2+="selected";}select2+=">"+array_estados[i]+"</option>";
					}else if ( i>=21 && i<=24) {
								select2+="<option style='background-color: #94e4ff' value='"+array_estados[i]+"' ";if (filent2.equals(array_estados[i])){select2+="selected";}select2+=">"+array_estados[i]+"</option>";
					}else if ( i==25) {
								//select2+="<option style='background-color: #01f03f' value='"+array_estados[i]+"' ";if (filent2.equals(array_estados[i])){select2+="selected";}select2+=">Area modificada para la EIC</option>";
					}else{
								select2+="<option value='"+array_estados[i]+"' ";if (filent2.equals(array_estados[i])){select2+="selected";}select2+=">"+array_estados[i]+"</option>";
					}	
				}
				select2+="</select>";

out.println("&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>Filtrar por Estado:</font>&nbsp;"+select+"&nbsp;&nbsp;&nbsp;");
//out.println("<input type=checkbox name=sinloc "+sinlochec+" class=boton onclick='envia();'><font class=c>Excluir \"(L) Localidad (Plano) no interseca con Manzana\"</font><br><br>");
out.println("&nbsp;&nbsp;&nbsp;<font class=n>Filtrar por Resultado:</font>&nbsp;"+select2+"</font><br><br>");
//out.println ("select cve_ent,  cve_mun ,  cve_loc ,  cve_ageb,  cve_mza,  resultado, fecha,st_x(ST_Transform(ST_PointOnSurface(st_makevalid(the_geom)),4326)),st_y(ST_Transform(ST_PointOnSurface(st_makevalid(the_geom)),4326)) from temp_mza_rev_errores "+consulta+sinlocons+consErr+" order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza;" );
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
      rs = str.executeQuery("select cve_ent,  cve_mun ,  cve_loc ,  cve_ageb,  cve_mza,  resultado, fecha,st_x(ST_Transform(ST_PointOnSurface(st_makevalid(the_geom)),4326)),st_y(ST_Transform(ST_PointOnSurface(st_makevalid(the_geom)),4326)) from temp_mza_rev_errores "+consulta+sinlocons+consErr+" order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza;" );

		//out.println("select cve_ent,  cve_mun ,  cve_loc ,  cve_ageb,  cve_mza,  resultado, fecha,st_x(ST_Transform(ST_PointOnSurface(st_makevalid(the_geom)),4326)),st_y(ST_Transform(ST_PointOnSurface(st_makevalid(the_geom)),4326)) from temp_mza_rev_errores "+consulta+sinlocons+consErr+" order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza;");
		out.println( "<table border=1><tr class=n bgcolor=#BBBBBB>			<td style='background-color:#BDBDBD;'><strong>&nbsp;No&nbsp;</strong>        <td style='background-color:#BDBDBD;'<trong>&nbsp;Entidad&nbsp;</strong>		<td style='background-color:#BDBDBD;'><strong>&nbsp;&nbsp;Municipio&nbsp;&nbsp;</strong>		<td style='background-color:#BDBDBD;'<trong>&nbsp;&nbsp;Localidad&nbsp;&nbsp;</strong>		<td style='background-color:#BDBDBD;'><strong>&nbsp;&nbsp;Ageb&nbsp;&nbsp;</strong>		<td style='background-color:#BDBDBD;'<trong>&nbsp;&nbsp;Manzana&nbsp;&nbsp;</strong>        <td style='background-color:#DBDBD;' align=center><strong>&nbsp;&nbsp;Resultado&nbsp;&nbsp;</strong><td style='background-color:#DBDBD;' align=center><strong>&nbsp;&nbsp;Fecha&nbsp;&nbsp;</strong><td style='background-color:#DBDBD;'   align=center><strong>&nbsp;&nbsp;Referencia&nbsp;&nbsp;</strong>");
		String st="";
		String salida="";
		int ban=0;
		int count=0;
			String s1="";
            String s2="";
            String s3="";
            String s4="";
            String s5="";
            String s6="";
            String s7="";
            String lon="";
            String lat="";
			String color="";
			int colorfila=0;
		while(rs.next()){
			count++;
			/*if (colorfila==0){
				color= "#EEFDF8";
				colorfila=1;
			}else{
				color="";
				colorfila=0;
				}
*/
             s1=rs.getObject(1).toString();
             s2=rs.getObject(2).toString();
             s3=rs.getObject(3).toString();
             s4=rs.getObject(4).toString();
             s6=rs.getObject(6).toString();
             s5=rs.getObject(5).toString();
             s7=rs.getObject(7).toString();
			if (rs.getObject(8) != null){
				lon=rs.getObject(8).toString();
			}
			if (rs.getObject(9) != null){
				lat=rs.getObject(9).toString();
			}
            out.println("<tr onmouseover=this.style.background='#c0c0c0' onmouseout=this.style.background='"+color+"' class=c bgcolor='"+color+"'>");
			out.println( "<td align=center>&nbsp;&nbsp;"+count+"&nbsp;&nbsp;<td align=center>&nbsp;&nbsp;"+s1+"&nbsp;&nbsp;<td align=center>&nbsp;&nbsp;"+s2+"&nbsp;&nbsp;<td align=center>&nbsp;&nbsp;"+s3+"&nbsp;&nbsp;<td align=center>&nbsp;&nbsp;"+s4+"&nbsp;&nbsp;<td align=center>&nbsp;&nbsp;"+s5+"&nbsp;&nbsp;<td >&nbsp;&nbsp;"+s6+"&nbsp;&nbsp;<td >&nbsp;&nbsp;"+s7+"&nbsp;&nbsp;");
		out.println("<td align=center><input type=button onclick='buscazoomosm("+lon+","+lat+");' value=' Ver '' class='boton'>");
		}

	//out.println("</table><font class=r>Se oculta temporalmente las manzanas de 1 frente<br><br><font class=t>Total:"+count);
	out.println("</table><font class=r><br><br><font class=t>Total:"+count);
out.println("<br><br>");
	  rs.close();
      str.close();
      conexion.close();

%>
<br>
</html>