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
			String cve_mza="";
			int proc=0;
			String f_registro="";
			String cve_def="";
			String fresp="";
			int cgo_def=0,status=0;

HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();

//try {
	//if (capa==1){ //MCC
		//consulta = "select gid,tip_act,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(geom,3857)),ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,a_sinacentos(tipo),'','',cgo_def,status,mal from act_cu.bcu_bd_manzana where st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) order by proc,status,mal,st_Area(geom),cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza desc limit 1";


consulta = "select * from (select gid,tip_act,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(geom,3857)) as geom,ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,a_sinacentos(tipo),'','',cgo_def,status,mal,1 as ord from act_cu.bcu_bd_manzana where  f_registro>(select fecha from vista_fecha_corte where tipo='inicia') and st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) ";

// aqui el proc!=1,, es por que se podia agregar lo enterior pero ya nel.
//from act_cu.bcu_bd_manzana where  (proc !=1 or f_registro>(select fecha from vista_fecha_corte where tipo='inicia')) and st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) ";


consulta = consulta + " ) tt order by ord,case proc when 0 then 1 when 1 then 2 else 1 end,status,mal,st_Area(geom),cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza desc limit 1";



//consulta = "select gid,tip_act,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(geom,3857)),ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,a_sinacentos(tipo),'','',cgo_def,status,mal from act_cu.bcu_bd_manzana where st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) order by proc,status,mal,st_Area(geom),cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza desc limit 1";


	//}
	//out.println(consulta);


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
 	switch(tipomzan){
              case "Sin tipo":tipomza="0";break;
              case "Contenedora":tipomza="1";break;
              case "Contenida":tipomza="2";break;
              case "Edificio-Manzana":tipomza="3";break;
              case "Tipica":tipomza="4";break;
              case "Parque o Jardin":tipomza="5";break;
              case "Glorieta":tipomza="6";break;
              case "Camellon":tipomza="7";break;
              case "Bajo Puente":tipomza="8";break;
              case "Caserio Disperso":tipomza="9";break;
              case "Proyectada":tipomza="10";break;
              case "Atipica":tipomza="11";break;
              case "Economica":tipomza="12";break;
    }

      switch(tipomza){
              case "0":tipotxt="Sin tipo";break;
              case "1":tipotxt="Contenedora";break;
              case "2":tipotxt="Contenida";break;
              case "3":tipotxt="Edificio-Manzana";break;
              case "4":tipotxt="Tipica";break;
              case "5":tipotxt="Parque o Jardin";break;
              case "6":tipotxt="Glorieta";break;
              case "7":tipotxt="Camellon";break;
              case "8":tipotxt="Bajo Puente";break;
              case "9":tipotxt="Caserio Disperso";break;
              case "10":tipotxt="Proyectada";break;
              case "11":tipotxt="Atipica";break;
              case "12":tipotxt="Economica";break;
    }
	//if (n==0 || mal==9){
    if (n==0){
		out.println("<script>window.resizeTo(400,200);</script><body>");
		if (n==0){
			out.println("<br><center><table><tr><td class=n>No existe manzana que graficar");
		}
		out.println("<tr><td align=center><br><input type=button class=boton value=' Cerrar ' onclick='window.close();'></center>");
	}else{
			if (mal==9){
				out.println("<center><table><tr><td class=n bgcolor=#FFF300>MANZANA FRENTES INCOMPLETOS DESCARGARLA A ARCGIS Y COMPLETARLOS</table><br>");
			}
			if (mal==9){
				out.println("<script>window.resizeTo(800,390);</script><body><form name='regis'>");
			}else{
				out.println("<script>window.resizeTo(800,350);</script><body><form name='regis'>");
			}
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


		out.println("<br><center class=c><table><tr><td bgcolor='#f5a9e1' class=c>Manzana viene desde <u><b>* CUR *</b></u></table></center>");



		//if (Integer.parseInt(cve_mza)==800 || status==7){
			out.println("<br><center class=n><b>--> SI LA MANZANA ES CASERIO, AGREGARLOS DESDE LA HERRAMIENTA DE CASERIOS <--</b></center>");
     	//}
		out.println("<br><table align=center border=1>");
		if (proc==1){
			out.println("<tr class=n><td colspan=10 align=center><font color=red>Esta actualizacion ya se agrego el "+fresp+"</font>");
		}else{
				out.println("<tr class=n><td colspan=10 align=center><font color=red>Creacion - nuevas manzanas o cambios de forma con la manzana que sobreponga (se puede cambiar el codigo)</font>");
				out.println("<tr class=n><td colspan=10 align=center>* <font color=red>En la fusion primero se fusiona la(s) manzana(s) a desaparecer y al final cambia de forma la clave que permanece</font>");
				out.println("<br>* <font color=red>En la subdivision primero subdivide las manzanas y al final cambia de forma la clave original</font>");
				out.println("<br>* <font color=red>Los CAMBIOS DE FORMA deben ser sobre manzanas con la misma clave</font>");
		}
		out.println("<tr class=n><th>&nbsp;&nbsp;Clave&nbsp;&nbsp;<th>&nbsp;Codigo&nbsp;<th>&nbsp;Fecha&nbsp;<!--<th>SI<br>&nbsp;Procede&nbsp;<th>NO<br>&nbsp;Procede&nbsp;--><th>&nbsp;Codigo&nbsp;<br>&nbsp;definitivo&nbsp;<th>&nbsp;Clave&nbsp;<br>&nbsp;definitiva&nbsp;<th>&nbsp;Ingresar&nbsp;");
		if (cgo.equals("4") || cgo.equals("2") || cgo.equals("1") || cgo.equals("5") || cgo.equals("F") || cgo.equals("6") || cgo.equals("0")){
			out.println("<th>&nbsp;Cambio&nbsp;");
		}
		out.println( "<tr class=c>");
        out.println("<td align=center nowrap>&nbsp;"+cve_ent+"&nbsp;"+cve_mun+"&nbsp;"+cve_loc+"&nbsp;"+cve_ageb+"&nbsp;"+cve_mza+"&nbsp;");
        out.println("<td align=center nowrap title='"+cgotxt+"'>&nbsp;&nbsp;"+cgo+"&nbsp;&nbsp;");
        out.println("<td align=center nowrap>&nbsp;&nbsp;"+f_registro+"&nbsp;&nbsp;");
        
    	String esc1="";
    	String esc2="";
    	String esc3="";
    	String esc4="";
    	if (cgo.equals("3")){
    		if (cgo.equals("3")){esc3=" selected ";}
    		out.println("<td align=center nowrap>&nbsp;<select name=codef class='boton'>");
    		out.println("<option value='3' "+esc3+">3-Baja</option>");
    		out.println("</select>");
		    out.println("<td align=center nowrap>&nbsp;<input class='boton' type='text' size='18' name='proccve' disabled maxlength='17' value=''>");
    	}else{
    		if (cgo.equals("1")){esc1=" selected ";}
    		if (cgo.equals("2")){esc2=" selected ";}
    		if (cgo.equals("4") || cgo.equals("6") || cgo.equals("5") || cgo.equals("F")){esc4=" selected ";}
    		out.println("<td align=center nowrap>&nbsp;<select name=codef class='boton'>");
    		//out.println("<option value='1' "+esc1+">1-Fusion</option>");
    		out.println("<option value='2' "+esc2+">2-Subdivision</option>");
    		out.println("<option value='4' "+esc4+">4-Nueva</option>");
    		out.println("</select>");
	        out.println("<td align=center nowrap>&nbsp;<input class='boton' type='text' size='18' name='proccve' disabled maxlength='17' ");
	        //if (proc==0){
				out.println(" value='"+cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza+"'>&nbsp;");
	    	//}else{
	    	//	out.println(" value='"+cve_def+"'>&nbsp;");
	    	//}
    	}

//if (proc==1 || Integer.parseInt(cve_mza)==800 || status==7){ // si ya esta atendido no pongo los botones
if (proc==1 || Integer.parseInt(cve_mza)==800){
	if (cgo.equals("3")){
		out.println("<td align=center nowrap colspan=1>&nbsp;-----&nbsp;");
	}else{
		out.println("<td align=center nowrap colspan=2>&nbsp;-----&nbsp;");
	}
}else{
 		if (Integer.parseInt(cve_mza)<900){ //si son menores de 900 debe ser puro cambio de FORMA EN TEORIA.
 			if (cgo.equals("3")){
    			out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton1 onclick='elimina("+gid+","+cgo+",\""+cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza+"\")' value=' Eliminar ' class='boton'>&nbsp;");
    		}else{

 				cgo="5";
        		out.println("<td align=center nowrap>&nbsp;-&nbsp;");
        		out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton2 onclick='cambiageom(5,"+gid+",\""+vale+"\",\""+punto+"\",\""+cve_mza+"\",\""+cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza+"\")' value=' Forma ' class='boton'>&nbsp;");
        	}
        			/////REVISAR LOS CAMBIOS DE FORMA DEBEN SER MENORES A 900 Y LAS NUEVAS DEBEN SER MAYORES A 900
        }else if (cgo.equals("F")){      //AQUI COMIENZA A ENTRAR SI ES MAYOR A 900 SERIAN LAS NUEVAS CAMBIOS DE FORMA O SUBDIVISION O FUSION
        	cgo="5";
        	out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton1 onclick='agrega("+gid+","+cgo+",\""+vale+"\")' value=' Agregar ' class='boton'>&nbsp;");
        	out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton2 onclick='cambiageom("+cgo+","+gid+",\""+vale+"\",\""+punto+"\",\""+cve_mza+"\",\""+cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza+"\")' value=' Forma ' class='boton'>&nbsp;");
        }else if (cgo.equals("4") || cgo.equals("5") || cgo.equals("6")   ){
        	out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton1 onclick='agrega("+gid+","+cgo+",\""+vale+"\")' value=' Agregar ' class='boton'>&nbsp;");
        	out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton2 onclick='cambiageom("+cgo+","+gid+",\""+vale+"\",\""+punto+"\",\""+cve_mza+"\",\""+cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza+"\")' value=' Forma ' class='boton'>&nbsp;");
        }else if (cgo.equals("2")){
			out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton1 onclick='agrega("+gid+","+cgo+",\""+vale+"\")' value=' Agregar ' class='boton'>&nbsp;");
        	out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton2 onclick='cambiageom("+cgo+","+gid+",\""+vale+"\",\""+punto+"\",\""+cve_mza+"\",\""+cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza+"\")' value=' Forma ' class='boton'>&nbsp;");
        }else if (cgo.equals("1")){
			out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton1 onclick='fusiona("+gid+","+cgo+",\""+vale+"\")' value=' Agregar ' class='boton'>&nbsp;");
        	out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton2 onclick='cambiageom("+cgo+","+gid+",\""+vale+"\",\""+punto+"\",\""+cve_mza+"\",\""+cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza+"\")' value=' Forma ' class='boton'>&nbsp;");
    	}else if (cgo.equals("3")){
    		out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton1 onclick='elimina("+gid+","+cgo+",\""+cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza+"\")' value=' Eliminar ' class='boton'>&nbsp;");
    	}
    	/*if (cgo.equals("3")){
    		out.println("<tr><td align=center nowrap colspan=10 class=n height='40'><font color=red>Para actualizaciones ya realizadas se asigna la relacion MCC-SIGMA con la manzana que sobreponga</font><br><input type=button name=procboton3 onclick='casigna_baja("+gid+")' value=' Asigna Relacion - BAJA (3)-' class='boton'>");
    	}else{
    		out.println("<tr><td align=center nowrap colspan=10 class=n height='40'><font color=red>Para actualizaciones ya realizadas se asigna la relacion MCC-SIGMA con la manzana que sobreponga</font><br> <input type=button name=procboton3 onclick='casigna("+cgo+","+gid+",\""+punto+"\")' value=' Asigna Relacion ' class='boton'>");
    		}*/
}


    	out.println("</table><br><center class=n>Tipo de Manzana:&nbsp;&nbsp;</font>"+tipomzan+"("+tipomza+")");
 
    	String addsap="";
    	String txtrel="";
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
var value='<% out.print (cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza);%>';
var cgo='<% out.print (cgo);%>';
var tipomza='<% out.print (tipomza);%>';
var figura='<% out.print (figura);%>';
var tipofigura='';

function proc(){
	if (document.regis.procede.checked){
		if (cgo=='3'){
			document.regis.proccve.value='';
			document.regis.proccve.disabled=true;
		}else{
			document.regis.proccve.value=value;
			document.regis.proccve.disabled=false;
		}
		document.regis.procboton1.disabled=false;
		if (cgo!='3'){
			document.regis.procboton2.disabled=false;
		}
		//document.regis.noprocede.checked=false;
		document.getElementById('rad1').checked = false;
		document.getElementById('rad2').checked = false;
		document.getElementById('rad3').checked = false;
	}else{
		document.regis.proccve.value='';
		document.regis.proccve.disabled=true;
		document.regis.procboton1.disabled=true;
		if (cgo!='3'){
			document.regis.procboton2.disabled=true;
		}
		}
}

function noproc(){
		if (document.getElementById('rad1').checked == true ||	document.getElementById('rad2').checked == true || document.getElementById('rad3').checked== true){
		//if (document.regis.noprocede.checked){
		document.regis.proccve.value='';
		document.regis.proccve.disabled=true;
		document.regis.procboton1.disabled=false;
		if (cgo!='3'){
			document.regis.procboton2.disabled=true;
		}
		document.regis.procede.checked=false;
	}else{
		document.regis.procboton1.disabled=true;
		if (cgo!='3'){
			document.regis.procboton2.disabled=true;
		}
		if (cgo=='3'){
			document.regis.proccve.value='';
			document.regis.proccve.disabled=true;
		}else{
			document.regis.proccve.disabled=true;
		}
	}
}

function cambiageom(cgo,gid,vale,punto,cvemza,clave){
	//if (document.regis.procede.checked){
		window.opener.vienedegid=tipofigura+gid;
		window.opener.mcctipomza=tipomza;
		window.opener.obtProy=16;
		window.opener.cambiageom(cgo,vale,punto,cvemza,clave);
		window.close();
	//}
}

function casigna(cgo,gid,punto){
	//if (document.regis.procede.checked){
		window.opener.vienedegid=tipofigura+gid;
		window.opener.mcctipomza=tipomza;
		window.opener.obtProy=16;
		window.opener.casigna(cgo,punto);
		window.close();
	//}
}


function casigna_baja(gid){
    var ajax=nuevoAjax();
    ajax.open("GET",'asigna_loc_baja.jsp?gid='+gid, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==0){
                window.opener.alertmsg ("Se relaciono la actualizacion");
            }else{
            	window.opener.alertmsg ("No se pudo asignar la baja");
            }
            window.close();
        }
    }
    ajax.send(null);
}


function elimina(gid,cgo,vale){
	//if (document.regis.procede.checked){
		window.opener.vienedegid=tipofigura+gid;
		window.opener.mcctipomza=tipomza;
		window.opener.obtProy=16;
		window.opener.eliminamz(vale);
		window.close();
	/*}else{
		var ajax=nuevoAjax();
        ajax.open("GET",'obtmza_no.jsp?tip=0&clave=&cgo=3&gid='+gid, true);
        ajax.onreadystatechange=function()
        {
            if(ajax.readyState==4)  {
                 var vale=ajax.responseText;
                if (parseInt(vale)==1){
                    window.close();
                }else{
                	window.opener.alertmsg ("No se registro el cambio");
                }
            }
        }
        ajax.send(null);
	}
	*/
}

function fusiona(gid,cgo,vale){
	var cgo1=document.regis.codef.value;
	if (cgo1!=cgo){
		cgo=parseInt(cgo1);
		if (cgo==2 || cgo==4){
			agrega(gid,cgo,vale);
			return false;
		}
	}
	var cve=document.regis.proccve.value;
	//if (document.regis.procede.checked){
		window.opener.vienedegid=tipofigura+gid;
		window.opener.mcctipomza=tipomza;
		window.opener.obtProy=16;
		window.opener.fusionamz(cve,vale);
		window.close();
	/*}else{
		var ajax=nuevoAjax();
        ajax.open("GET",'obtmza_no.jsp?tip=0&clave=&cgo=1&gid='+gid, true);
        ajax.onreadystatechange=function()
        {
            if(ajax.readyState==4)  {
                 var vale=ajax.responseText;
                if (parseInt(vale)==1){
                    window.close();
                }else{
                	window.opener.alertmsg ("No se registro el cambio");
                }
            }
        }
        ajax.send(null);
	}*/
}

function agrega(gid,cgo,vale){
	var cgo1=document.regis.codef.value;
	if (cgo1!=cgo){
		cgo=parseInt(cgo1);
		if (cgo==1){
			fusiona(gid,cgo,vale);
			return false;
		}
	}
	//if (document.regis.procede.checked){
		window.opener.cvedef=document.regis.proccve.value;
		window.opener.vienedegid=tipofigura+gid;
		window.opener.mcctipomza=tipomza;
		window.opener.obtProy=16;
		window.opener.agregamz(1,cgo,vale);
		window.close();
	/*}else{
		var ajax=nuevoAjax();
        ajax.open("GET",'obtmza_no.jsp?tip=0&clave=&cgo=4&gid='+gid+'&proc='+document.regis.noprocede.value, true);
        ajax.onreadystatechange=function()
        {
            if(ajax.readyState==4)  {
                 var vale=ajax.responseText;
                if (parseInt(vale)==1){
                    window.close();
                }else{
                	window.opener.alertmsg ("No se registro el cambio");
                }
            }
        }
        ajax.send(null);
	}*/
}

function proy(gid,cgo){
var clave=document.regis.proycve.value;
if (clave.length!=17){
	alert("Debes de proporcionar la clave completa!");
	return false;
}
/*var ajax=nuevoAjax();
        ajax.open("GET",'obtmza_no.jsp?tip=3&clave='+clave+'&cgo='+cgo+'&gid='+gid, true);
        ajax.onreadystatechange=function()
        {
            if(ajax.readyState==4)  {
                 var vale=ajax.responseText;
                if (parseInt(vale)==1){
                    window.close();
                }else{
                	window.opener.alertmsg ("No se registro el cambio");
                }
            }
        }
        ajax.send(null);
*/
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