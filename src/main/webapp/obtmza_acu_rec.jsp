<%@ page import="java.util.*" session="true" %>
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
.c{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: normal;}
.n{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: bold;}
.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}
a.liga1:link { font-size: 9pt; color: black;text-decoration: none;font-family: Arial;}
a.liga1:visited {font-size: 9pt;color: black;text-decoration: none;font-family: Arial;}
a.liga1:hover {font-size: 9pt;color: black;text-decoration: none;font-family: Arial;}

</style>
<%
String  x = request.getParameter("x");
String  y = request.getParameter("y");
String  ca = request.getParameter("capa");
String consulta="";
int capa = Integer.parseInt(ca);
String cgo="";
			String cve_ent="";
			String cve_mun="";
			String cve_loc="";
			String cve_ageb="";
			String cve_mza= request.getParameter("cve_mza");
			int proc=0;
			String f_registro="";
			String cve_def="";
			String fresp="";
			int cgo_def=0,status=0;

HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();


if (cve_mza != null){   //aqui entra del mismo archivo para recuperar por funcion la manzana
	out.println("<script>document.getElementById('espere').innerHTML = 'ESPERE'</script>");
	consulta = "select act_cu.recupera_mza_cur('"+cve_mza+"')";
}else{

		consulta = "select * from (select gid,tip_act,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,fecha_mod,fecha_mod,0 as proc,'',ST_AsText(st_transform(geom,3857)) as geom,ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,a_sinacentos(tipo),'','',NULL as cgo_def,status,0 as mal,1 as ord from manzanabcu_res where st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) ";
		consulta = consulta + " ) tt order by ord,proc,status,mal,st_Area(geom),cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza desc limit 1";
}


//consulta = "select gid,tip_act,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(geom,3857)),ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,a_sinacentos(tipo),'','',cgo_def,status,mal from act_cu.bcu_bd_manzana where st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) order by proc,status,mal,st_Area(geom),cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza desc limit 1";


	//}

//consulta = "select gid,tip_act,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(geom,3857)),ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,a_sinacentos(tipo),'','',cgo_def,status,mal from act_cu.bcu_bd_manzana where st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) order by proc,status,mal,st_Area(geom),cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza desc limit 1";



	//out.println(ca);
	  ResultSet rs = null;ResultSet rs1 = null;
      Statement str = null;Statement str1 = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
      
    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    rs = str.executeQuery( consulta );
	int n=0;
	String vale="";
	String punto="";
	String tipomza="";
	String tipomzan="";
	String tipo2="";
	String figura="";
	int tip=0;
	int gid=0;
	int mal=0;
	String ft1=" - ";
	String ft2=" - ";
		String cveoper="";


if (cve_mza != null){   //aqui entra del mismo archivo para recuperar por funcion la manzana
	while(rs.next()){
		String id = rs.getObject(1).toString();
		if (id.equals("0")){  //no hubo manzana
						out.println("<br><center><table><tr><td class=n>Manzana ya integrada en la capa de MZ-CUR");
		}else{

						out.println ("<script>if (opener.mza_acu.getVisibility()){opener.mza_acu.redraw(true);}");
						out.println ("location.replace('obtmza.jsp?x="+x+"&y="+y+"&capa1=0&capa2=1&capa3=0&capa4=0');</script>");

		}
	}
}else{
	while(rs.next()){
		gid = (Integer)(rs.getObject(1));
		cgo = rs.getObject(2).toString().substring(0,1);
		cve_ent = rs.getObject(3).toString();
		cve_mun = rs.getObject(4).toString();
		cve_loc = rs.getObject(5).toString();
		cve_ageb = rs.getObject(6).toString().substring(0,3)+'-'+rs.getObject(6).toString().substring(3,4);
		cve_mza = rs.getObject(7).toString();
		f_registro = rs.getObject(8).toString().substring(0,10);
		if (rs.getObject(9) != null){
			fresp = rs.getObject(9).toString().substring(0,10);
		}
		proc = (Integer)(rs.getObject(10));
		cve_def="";
		if (rs.getObject(11) != null){
			cve_def = rs.getObject(11).toString();
		}
		vale = rs.getObject(12).toString();
		punto = rs.getObject(13).toString();
		tipomzan="";
		if (rs.getObject(14) != null){
			tipomzan=rs.getObject(14).toString();
		}

		tipo2=rs.getObject(15).toString();
		figura=rs.getObject(16).toString();
		if (rs.getObject(17) != null){
			cgo_def=Integer.parseInt(rs.getObject(17).toString());
		}
		if (rs.getObject(18) != null){
			status=Integer.parseInt(rs.getObject(18).toString());
		}
		mal=Integer.parseInt(rs.getObject(19).toString());
//cveoper= rs.getObject(20).toString();
		n++;
	}
	 String tipotxt="";
    if (n==0){
		out.println("<script>window.resizeTo(400,200);</script><body>");
		if (n==0){
			out.println("<br><center><table><tr><td class=n>No existe manzana que graficar");
		}
		out.println("<tr><td align=center><br><input type=button class=boton value=' Cerrar ' onclick='window.close();'></center>");
	}else{
		out.println("<script>window.resizeTo(800,350);</script><body><form name='regis'>");
		String cgotxt="";
		switch(cgo){
			//case "0":cgotxt="Manzanan pre-digitalizada";break;
		    case "1":cgotxt="Fusion de mza";break;
		    case "2":cgotxt="Subdivision de mza";break;
		    case "3":cgotxt="Baja de mza";break;
		    case "4":cgotxt="Creacion de mza";break;
		    //case "5":cgotxt="Cambio mza de ageb";break;
		    //case "6":cgotxt="Cabmio mza de loc";break;
		    case "F":cgotxt="Cambio de forma de mza";break;
		    case "6":cgotxt="Apertura de vialidad";break;
		    case "44":cgotxt="Creacion de Caserio";break;
		    case "45":cgotxt="Baja de Caserio";break;
		    case "46":cgotxt="Modificacion de Caserio";break;
   		    case "FR":cgotxt="Cambio de frentes";break;
		}


		out.println("<br><center class=c><table><tr><td bgcolor='#DEE8FE' class=c>RECUPERAR Manzana desde <u><b>* CUR *</b></u></table></center>");

		out.println("<br><table align=center border=1>");
		if (proc==1){
			out.println("<tr class=n><td colspan=10 align=center><font color=red>Esta actualizacion ya se agrego el "+fresp+"</font>");
		}else{
				out.println("<tr class=n><td colspan=10 align=center>* <font color=red>Esta manzana se va a RECUPERAR para ser integrada, debido a que son actualizaciones anteriores al 2025 que no se aceptaron</font>");
				out.println("<br>* <font color=red>Se RECUPERAN sus frentes de manzana y sus vialidades asociadas </font>");
		}
		out.println("<tr class=n><th>&nbsp;&nbsp;Clave&nbsp;&nbsp;<th>&nbsp;Codigo&nbsp;<th>&nbsp;Fecha&nbsp;<!--<th>SI<br>&nbsp;Procede&nbsp;<th>NO<br>&nbsp;Procede&nbsp;--><th>&nbsp;INTEGRAR&nbsp;");
				out.println( "<tr class=c>");
        out.println("<td align=center nowrap>&nbsp;"+cve_ent+"&nbsp;"+cve_mun+"&nbsp;"+cve_loc+"&nbsp;"+cve_ageb+"&nbsp;"+cve_mza+"&nbsp;");
        out.println("<td align=center nowrap title='"+cgotxt+"'>&nbsp;&nbsp;"+cgo+"&nbsp;&nbsp;");
        out.println("<td align=center nowrap>&nbsp;&nbsp;"+f_registro+"&nbsp;&nbsp;");

    	String esc1="";
    	String esc2="";
    	String esc3="";
    	String esc4="";

		out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton1 onclick='agrega(\""+cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza+"\")' value=' RECUPERAR ' class='boton'>&nbsp;");

    	out.println("</table><br><center class=n>Esta manzana se agregar&aacute; al listado de ''<font  style='background-color: #E7A4F9;'>Informacion procedente de la AC Integral&nbsp;&nbsp;(MANZANAS)</font>''");

    	out.println("<br><br><div id='espere' style='text-align:center' bgcolor='#EFFA0C'></div>");
    	String addsap="";
    	String txtrel="";
   	}
} /// este es el else del CVE_MZA is null que es detectar de la cur



    str.close();
    conexion.close();
 /*   }
    catch (SQLException ex){
      out.print("ERROR SQL");
  }
      catch(Exception ex){
        out.print("ERROR");
   }*/

%>
</form>
</table>
</body>
<script>
var value='<% out.print (cve_ent+cve_mun+cve_loc+cve_ageb.replace("-","")+cve_mza);%>';
var cgo='<% out.print (cgo);%>';
var tipomza='<% out.print (tipomza);%>';
var figura='<% out.print (figura);%>';
var tipofigura='';
var  x = '<% out.print (x);%>';
var y = '<% out.print (y);%>';
var ca = '<% out.print (ca);%>';


function agrega(gid,cgo,vale){
	document.getElementById('espere').innerHTML = '.... ESPERE ....';
	location.replace('obtmza_acu_rec.jsp?cve_mza='+value+'&x='+x+'&y='+y+'&capa='+ca);

}


function nuevoAjax()
{
    /* Crea el objeto AJAX. Esta funcion es generica para cualquier utilidad de este tipo, por
    lo que se puede copiar tal como esta aqui */
    var xmlhttp=false;
    try {
        // Creacion del objeto AJAX para navegadores no IE
        xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch(e){
        try {
            // Creacion del objet AJAX para IE
            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }catch(E){
            if (!xmlhttp && typeof XMLHttpRequest!=undefined) xmlhttp=new XMLHttpRequest();
        }
    }return xmlhttp;
}
</script>

</html>