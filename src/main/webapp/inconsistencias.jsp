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

window.resizeTo(800,800);

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
<%
String  ni = request.getParameter("ni");
String  ent = request.getParameter("ent");
String  edo = request.getParameter("edo");
String condicion="";
String texto="";


if(ni.equals("11")){
texto="para el Estado "+ent;
condicion=" where substring(cvegeo::text, 1, 2)='"+ent+"' ";

}else if(ni.equals("12")){
texto="para la regional "+Integer.parseInt(ent);;	
	if(ni.equals("01")){
    condicion= " where (substring(cvegeo::text, 1, 2)='02' or substring(cvegeo::text, 1, 2)='03' or substring(cvegeo::text, 1, 2)='25' or substring(cvegeo::text, 1, 2)='26') ";
	}else if(ni.equals("02")){
    condicion= " where (substring(cvegeo::text, 1, 2)='10' or substring(cvegeo::text, 1, 2)='08' or substring(cvegeo::text, 1, 2)='32') ";
	}else if(ni.equals("03")){
    condicion= " where (substring(cvegeo::text, 1, 2)='28' or substring(cvegeo::text, 1, 2)='05' or substring(cvegeo::text, 1, 2)='19') ";
	}else if(ni.equals("04")){
    condicion= " where (substring(cvegeo::text, 1, 2)='18' or substring(cvegeo::text, 1, 2)='16' or substring(cvegeo::text, 1, 2)='14' or substring(cvegeo::text, 1, 2)='06') ";
	}else if(ni.equals("05")){
    condicion= " where (substring(cvegeo::text, 1, 2)='11' or substring(cvegeo::text, 1, 2)='24' or substring(cvegeo::text, 1, 2)='22' or substring(cvegeo::text, 1, 2)='01') ";
	}else if(ni.equals("06")){
    condicion= " where (substring(cvegeo::text, 1, 2)='15' or substring(cvegeo::text, 1, 2)='17' or substring(cvegeo::text, 1, 2)='12') ";
	}else if(ni.equals("07")){
    condicion= " where (substring(cvegeo::text, 1, 2)='30' or substring(cvegeo::text, 1, 2)='29' or substring(cvegeo::text, 1, 2)='21' or substring(cvegeo::text, 1, 2)='13' or substring(cvegeo::text, 1, 2)='09') ";
	}else if(ni.equals("08")){
    condicion= " where (substring(cvegeo::text, 1, 2)='27' or substring(cvegeo::text, 1, 2)='20' or substring(cvegeo::text, 1, 2)='07') ";
	}else if(ni.equals("09")){
    condicion= " where (substring(cvegeo::text, 1, 2)='23' or substring(cvegeo::text, 1, 2)='31' or substring(cvegeo::text, 1, 2)='04') ";
	}

}else if(ni.equals("13")){
	if(edo.equals("00")){
		texto=" Nacional";
		condicion="";
	}else{
		texto="para el Estado "+edo;
        condicion=" where substring(cvegeo::text, 1, 2)='"+edo+"' ";	
	}
	
}

out.println( "<center class='t'><H2><CENTER CLASS=T ALIGN=CENTER> Informacion de Inconsistencias "+texto+"</H2>");

try {
	 String  campos="";
	 String datos="";
	 int colorfila=0;
	 String color="";
      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
	  conexion = DriverManager.getConnection(
                                             "jdbc:postgresql://10.153.3.25:5434/actcargeo10",
                                             "actcar",
                                             "actcar"
                                            );
											//out.println (consulta);
	  str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
	  //out.println("select * from val_mc_vs_manz_afect "+condicion+" order by cvegeo;" );
      rs = str.executeQuery("select * from val_mc_vs_manz_afect "+condicion+" order by cvegeo;" );

		campos="<table border=1><tr class=n bgcolor=#DBDBD>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>&nbsp;No&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>&nbsp;Cvegeo&nbsp;</strong>";
		campos+="<td align=center style='background-color:#dadeda;'><strong>&nbsp;Informacion&nbsp;</strong>";
		out.println(campos);
		String st="";
		String salida="";
		int ban=0;
		int count=1;


		datos= "<tr class=c bgcolor='"+color+"' class=n align=center bgcolor='"+color+"'><td class=n colspan=3>No existe informacion";
		while(rs.next()){
			if (colorfila==0){
				color= "#EEFDF8";
				colorfila=1;
			}else{
				color="";
				colorfila=0;
				}

            String s1=rs.getObject(1).toString();//cveoper_censor
            String s2=rs.getObject(2).toString();//cvegeo_prov


			datos= "<tr class=c bgcolor='"+color+"' class=n align=center bgcolor='"+color+"'>";

			datos+="<td align=center>&nbsp;&nbsp;"+count+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s1+"&nbsp;&nbsp;";
			datos+="<td align=center>&nbsp;&nbsp;"+s2+"&nbsp;&nbsp;";
			out.println(datos);
			datos="";
				count+=1;

		}
		out.println(datos);
	out.println("</table><br><br>");
	  rs.close();
      str.close();
      conexion.close();
}catch (SQLException ex){
      out.println("<script>");
      out.println("  alert(\'Se genero la expresion de SQL: "+ex.getMessage()+" !\');");
      out.println("</script>");
    }
%>

</html>