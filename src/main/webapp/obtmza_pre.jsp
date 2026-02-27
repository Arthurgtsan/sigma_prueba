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

			String cve_ent="";
			int proc=0;
			String fresp="";

HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();

//try {
	//if (capa==1){ //MCC
		consulta = "select gid,cve_ent,ST_AsText(st_transform(st_multi(the_geom),3857)),ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,conviv,substring(cvegeo,1,5)||'0000'||substring(cvegeo,6,5) from z_digmz where st_intersects(the_geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) order by st_Area(the_geom) limit 1";
	//}
	//out.println(consulta);
	//out.println(ca);
	  ResultSet rs = null;
      Statement str = null;
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
	String conviv="";
	int tip=0;
	int gid=0;
	String cvegeo="";
	while(rs.next()){
		gid = (Integer)(rs.getObject(1));
		cve_ent = rs.getObject(2).toString();
		vale = rs.getObject(3).toString();
		punto = rs.getObject(4).toString();
		conviv = rs.getObject(5).toString();
		cvegeo = rs.getObject(6).toString()+"901";
		n++;
	}
	if (n==0){
		out.println("<script>window.resizeTo(400,200);</script><body>");
		out.println("<br><center><table><tr><td class=n>No existe manzana que graficar");
		out.println("<tr><td align=center><br><input type=button class=boton value=' Cerrar ' onclick='window.close();'></center>");
	}else{
		out.println("<script>window.resizeTo(800,350);</script><body><form name='regis'>");
		out.println("<br><center class=c><table><tr><td bgcolor='#ffe48d' class=c>Manzana viene desde <u><b>* Pre-digitalizacion *</b></u></table></center>");

		out.println("<br><table align=center border=1>");
//		if (proc!=0){
//			out.println("<tr class=n><td colspan=10 align=center><font color=red>Esta actualizacion ya se agrego el "+fresp+"</font>");
//		}else{
				out.println("<tr class=n><td colspan=10 align=center><font color=red>Pre-digitalizada - nuevas manzanas o cambios de forma con la manzana que sobreponga</font>");
				out.println("<tr class=n><td colspan=10 align=center>* <font color=red>En la fusion primero se fusiona la(s) manzana(s) a desaparecer y al final cambia de forma la clave que permanece</font>");
				out.println("<br>* <font color=red>En la subdivision primero subdivide las manzanas y al final cambia de forma la clave original</font>");
//		}
		out.println("<tr class=n><th>&nbsp;Codigo&nbsp;<br>&nbsp;de&nbsp;creacion&nbsp;<th>&nbsp;Clave&nbsp;de&nbsp;creacion&nbsp;<br>EEMMMLLLLAAA-AMMM<th>&nbsp;Ingresar&nbsp;");
		out.println("<th>&nbsp;Cambio&nbsp;");
		out.println( "<tr class=c>");
    	String esc1="";
    	String esc2="";
    	String esc3="";
    	String esc4="";
    		out.println("<td align=center nowrap>&nbsp;<select name=codef class='boton'>");
    		//out.println("<option value='1' >1-Fusion</option>");
    		out.println("<option value='2' >2-Subdivision</option>");
    		out.println("<option value='4' selected>4-Nueva</option>");
    		out.println("</select>");
	        out.println("<td align=center nowrap>&nbsp;<input class='boton' type='text' size='18' name='proccve' maxlength='17' value=''>");
        	out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton1 onclick='agrega("+gid+",4,\""+vale+"\",\""+conviv+"\")' value=' Agregar ' class='boton' >&nbsp;");
        	out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton2 onclick='cambiageom(4,"+gid+",\""+vale+"\",\""+punto+"\",\"901\",\""+cvegeo+"\")' value=' Forma ' class='boton' >&nbsp;");
	}


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
var cgo='4';
var mzamaxloc=window.opener.mzamax+1;
var valeloc=mzamaxloc;
var valestr='';
                if (String(valeloc).length<3){
                    valestr=window.opener.pad("0"+valeloc, 3);
                }else{
                    valestr=String(valeloc);
                }
                if (valestr.length>3){
                    valestr=valestr.substring(valestr.length-3,valestr.length);
                }
//document.regis.proccve.value=window.opener.cve_ent+window.opener.cve_mun+window.opener.cve_loc+window.opener.cve_ageb+valestr;
document.regis.proccve.value='<% out.print(cvegeo); %>';

/* //ANTES
function cambiageom(cgo,gid,vale,punto,conviv){
		window.opener.vienedegid='P'+gid;
		window.opener.cambiageom(cgo,vale,punto,conviv);
		window.close();
}
*/
function cambiageom(cgo,gid,vale,punto,cvemza,clave){
	//if (document.regis.procede.checked){
		window.opener.vienedegid=''; //'P'+gid;
		window.opener.cambiageom(cgo,vale,punto,cvemza,clave);
		window.close();
	//}
}

function fusiona(gid,cgo,vale,conviv){
	var cgo1=document.regis.codef.value;
	if (cgo1!=cgo){
		cgo=parseInt(cgo1);
		if (cgo==2 || cgo==4){
			agrega(gid,cgo,vale,conviv);
			return false;
		}
	}
		var cve=document.regis.proccve.value;
		window.opener.vienedegid=''; //'P'+gid;
		window.opener.mcctipomza='4';
		window.opener.fusionamz(cve,vale,conviv);
		window.close();
}

function agrega(gid,cgo,vale,conviv){
	var cgo1=document.regis.codef.value;
	if (cgo1!=cgo){
		cgo=parseInt(cgo1);
		if (cgo==1){
			fusiona(gid,cgo,vale,conviv);
			return false;
		}
	}
		window.opener.cvedef=document.regis.proccve.value;
		window.opener.vienedegid=''; //'P'+gid;
		window.opener.mcctipomza='4';
		window.opener.agregamz(1,cgo,vale,conviv);
		window.close();
}


</script>

</html>