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
		//consulta = "select gid,cgo,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(ST_PointOnSurface(geom),3857)),ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,tipomza,tipo,figura,cgo_def,status from (select *,(ST_Dump(sometable.the_geom)).geom AS geomdump from mcc_poblacion.cat_manz_modcar) where ((figura='CENSOR' and status!=2) or (figura='TCAR')) and status in (1,2,7) and mal=0 and st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) order by tipo desc,proc,st_Area(geom),cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza desc limit 1";
		//consulta = "select gid,cgo,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(ST_PointOnSurface(geomdump),3857)),ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,tipomza,tipo,figura,cgo_def,status from (select *,(ST_Dump(geom)).geom AS geomdump  from mcc_poblacion.cat_manz_modcar) tt where (((cve_mza='800' and cgo in ('44','45','46'))) or ((figura='CENSOR' and status!=2) or (figura='TCAR')) and status in (1,2,7))  and mal=0 and st_intersects(geomdump,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) order by tipo desc,proc,st_Area(geomdump),cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza desc limit 1";
//consulta = "select gid,cgo,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(ST_PointOnSurface(geomdump),3857)),ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,tipomza,tipo,figura,cgo_def,status from (select *,(ST_Dump(geom)).geom AS geomdump  from mcc_poblacion.cat_manz_modcar) tt where ((((cve_mza='800' and cgo in ('3','4','5'))) and ((figura='CENSOR' and status!=2) or (figura='TCAR')) and status in (0,1,2,3,4,5,6,7,8,9)) or status='7') and st_intersects(geomdump,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) and (not (cgo='3' and status>=3)) order by tipo desc,proc,st_Area(geomdump),cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza desc limit 1";




consulta = "select * from (";

	consulta +=" select gid,cgo,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(ST_PointOnSurface(geomdump),3857)),ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,tipomza::varchar,tipo,figura,cgo_def,status::varchar,mal,'1MCC' as tipoproy from (select *,(ST_Dump(geom)).geom AS geomdump  from mcc_poblacion.cat_manz_modcar) tt where ((((cve_mza='800' and cgo in ('44','45','46'))) and ((figura='CENSOR' and status!=2) or (figura='TCAR')) and status in (0,1,2,3,4,5,6,7,8,9)) or status='7') and st_intersects(geomdump,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) and (not (cgo='3' and status>=3)) ";
consulta += "union	";
consulta += "select gid,tip_act,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(ST_PointOnSurface(geomdump),3857)),ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,tipo,'','',cgo_def,status::varchar,mal,'2ACU' as tipoproy from (select *,(ST_Dump(geom)).geom AS geomdump  from act_cu.bcu_bd_manzana where f_registro> (select fecha from vista_fecha_corte where tipo='inicia')) tt where (cve_mza::integer>900 or cve_mza::integer=800) and st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) ) t2 ";
consulta += "order by tipoproy,proc,mal,cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza desc limit 1";


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
	String tipo2="";
	String figura="";
	int tip=0;
	int gid=0;

	while(rs.next()){
	String tipoproyecto = rs.getObject(20).toString();
		if (!(tipoproyecto.equals("1MCC"))){  //si no es MCC lo mando al otro 
			String site = "obtmza_acu_cd.jsp?capa="+capa+"&x="+x+"&y="+y;
				response.setStatus(response.SC_MOVED_TEMPORARILY);
				response.setHeader("Location", site);
		}




		gid = (Integer)(rs.getObject(1));
		cgo = rs.getObject(2).toString();
		cve_ent = rs.getObject(3).toString();
		cve_mun = rs.getObject(4).toString();
		cve_loc = rs.getObject(5).toString();
		cve_ageb = rs.getObject(6).toString();
		cve_mza = rs.getObject(7).toString();
		f_registro = rs.getObject(8).toString().substring(0,10);
		if (rs.getObject(9) != null){
			fresp = rs.getObject(9).toString().substring(0,10);
		}else{
			fresp  = "";
		}
		proc = (Integer)(rs.getObject(10));
		cve_def="";
		if (rs.getObject(11) != null){
			cve_def = rs.getObject(11).toString();
		}
		vale = rs.getObject(12).toString();
		punto = rs.getObject(13).toString();
		tipomza="";
		if (rs.getObject(14) != null){
			tipomza=rs.getObject(14).toString();
		}
		tipo2=rs.getObject(15).toString();
		figura=rs.getObject(16).toString();
		if (rs.getObject(17) != null){
			cgo_def=Integer.parseInt(rs.getObject(17).toString());
		}
		if (rs.getObject(18) != null){
			status=Integer.parseInt(rs.getObject(18).toString());
		}
		if (status==7){
			cgo="44";
		}
		n++;
	}
	 String tipotxt="";
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
	if (n==0){
		out.println("<script>window.resizeTo(400,200);</script><body>");
		out.println("<br><center><table><tr><td class=n>No existe caserio que graficar");
		out.println("<tr><td align=center><br><input type=button class=boton value=' Cerrar ' onclick='window.close();'></center>");
	}else{
		out.println("<script>window.resizeTo(800,350);</script><body><form name='regis'>");
		String cgotxt="";
		switch(cgo){
			//case "0":cgotxt="Manzanan pre-digitalizada";break;
		    case "1":cgotxt="Fusion de mza";break;
		    case "2":cgotxt="Subdivision de mza";break;
		    case "3":cgotxt="Baja de mza/cd";break;
		    case "4":cgotxt="Creacion de mza/cd";break;
		    //case "5":cgotxt="Cambio mza de ageb";break;
		    //case "6":cgotxt="Cabmio mza de loc";break;
		    case "5":cgotxt="Cambio de forma de mza/cd";break;
		    case "6":cgotxt="Apertura de vialidad";break;
		    case "44":cgotxt="Creacion de Caserio";break;
		    case "45":cgotxt="Baja de Caserio";break;
		    case "46":cgotxt="Modificacion de Caserio";break;
		    /*case "E":cgotxt="Conurba loc";break;
	 		case "D":cgotxt="Fusiona loc";break;
          	case "N":cgotxt="Desconurba loc";break;
          	case "O":cgotxt="Desfusiona loc";break;
          	case "H":cgotxt="Cambio de mun";break;
          	case "G":cgotxt="Cambio de ageb";break;
			case "I":cgotxt="Cambio de ent";break;
			case "M":cgotxt="Creacion de mun";break;
			case "Y":cgotxt="Consolidacion de ageb";break;*/
		}

		out.println("<br><center class=c><table><tr><td bgcolor='#ff7e19' class=c>Caserio desde <u><b>* "+tipo2+" "+figura+" *</b></u></table></center>");


		if (Integer.parseInt(cve_mza)!=800 && status!=7){
			out.println("<br><center class=n><b>--> LAS MANZANAS AGREGARLAS DESDE LA HERRAMIENTA DE MANZANAS <--</b></center>");
     	}
     	out.println("<br><table align=center border=1>");
		if (proc==1){
			out.println("<tr class=n><td colspan=10 align=center><font color=red>Esta actualizacion ya se agrego el "+fresp+"</font>");
		}else{
			switch (cgo){
				case "44":
					if (status==7){
						out.println("<tr class=n><td colspan=10 align=center><font color=red>Creacion de caserio, desde manzana rechazada del MCC (se agrega un solo caserio)</font>");
					}else{
						out.println("<tr class=n><td colspan=10 align=center><font color=red>Creacion de caserio, desde caserio del MCC (se agrega un solo caserio)</font>");
				}
					break;
				case "46":
						out.println("<tr class=n><td colspan=10 align=center><font color=red>Edicion de caserio, desde caserio del MCC (analizar crear/elimar caserios sin generar TE)</font>");
					break;
				case "45":
					out.println("<tr class=n><td colspan=10 align=center><font color=red>Baja de caserio, desde manzana del MCC (se dara de baja todos los caserios con la misma clave)</font>");
					break;
			}
		}
		out.println("<tr class=n><th>&nbsp;&nbsp;Clave&nbsp;&nbsp;<th>&nbsp;Codigo&nbsp;<th>&nbsp;Fecha&nbsp;<!--<th>SI<br>&nbsp;Procede&nbsp;<th>NO<br>&nbsp;Procede&nbsp;<th>&nbsp;Codigo&nbsp;<br>&nbsp;definitivo&nbsp;--><th>&nbsp;Clave&nbsp;<br>&nbsp;definitiva&nbsp;<th>&nbsp;Ingresar&nbsp;");
		out.println( "<tr class=c>");
        out.println("<td align=center nowrap>&nbsp;"+cve_ent+"&nbsp;"+cve_mun+"&nbsp;"+cve_loc+"&nbsp;"+cve_ageb+"&nbsp;"+cve_mza+"&nbsp;");
        out.println("<td align=center nowrap title='"+cgotxt+"'>&nbsp;&nbsp;"+cgo+"&nbsp;&nbsp;");
        out.println("<td align=center nowrap>&nbsp;&nbsp;"+f_registro+"&nbsp;&nbsp;");
    	String esc1="";
    	String esc2="";
    	String esc3="";
    	String esc4="";
	        out.println("<td align=center nowrap>&nbsp;<input class='boton' type='text' size='18' name='proccve' disabled maxlength='17' ");
	        if (proc==0){
				out.println(" value='"+cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza+"'>&nbsp;");
	    	}else{
	    		out.println(" value='"+cve_def+"'>&nbsp;");
	    	}


if (proc==1 || (Integer.parseInt(cve_mza)!=800 && status!=7)){ // si ya esta atendido no pongo los botones
		out.println("<td align=center nowrap colspan=2>&nbsp;-----&nbsp;");
}else if (status>2 && status!=7){
		out.println("<td align=center nowrap colspan=2>&nbsp;NO PROCEDE&nbsp;");
}else{
	if (cgo.equals("45")){
	    	out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton1 onclick='eliminacd("+gid+","+cgo+",\""+cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza+"\")' value=' Eliminar ' class='boton'>&nbsp;");
  }else if (cgo.equals("46")){
				out.println("<td align=center nowrap colspan=2>&nbsp;-----&nbsp;");
				out.println("</table><br><center class=n>Codigo 46: se aumenta/disminuye el numero de caserios (no afecta registro) revisar y editar el # de caserios");

	}else if (cgo.equals("44")){
			out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton1 onclick='agrega("+gid+","+cgo+",\""+vale+"\")' value=' Agregar ' class='boton'>&nbsp;");


   }

/*out.println("<tr><td colspan=5><table border=1><tr><td align=center colspan=2 class=n height='40' ><font color=red>&nbsp;&nbsp;Para actualizaciones ya realizadas se asigna&nbsp;&nbsp;<br>&nbsp;&nbsp; la relacion MCC-SIGMA con el caserio  que sobreponga&nbsp;&nbsp;</font><br><br> <input type=button name=procboton3 onclick='casigna_cd1("+cgo+","+gid+",\""+punto+"\")' value=' Asigna Relacion ' class='boton'>&nbsp;");
	out.println("<td align=center colspan=2 class=n height='40'><font color=red><br>&nbsp;&nbsp;Para relacionar el caserio disperso MCC-900&nbsp;&nbsp;<br>a una localidad PUNTUAL<br>que no tenga MANZANAS ni CASERIO</font><br><br> <input type=button name=procboton3 onclick='casigna_cd2("+gid+")' value=' Relacionar a Localidad PUNTUAL ' class='boton'>&nbsp;</table>");
    	out.println("</table><br><center class=n>Tipo de Manzana:&nbsp;&nbsp;</font>"+tipotxt);
    		*/
}

	String addsap="";
    	String txtrel="";
    	if (proc==1 || (Integer.parseInt(cve_mza)!=800 && status!=7)){
    		addsap="disabled";
    	}else{
    		if (cgo_def==1){
    			txtrel="<br><center class=n>(Caserio ya relacionado a manzana: "+cve_def+")</center>";
    		}else if (cgo_def==2){
    			txtrel="<br><center class=n>(Caserio ya relacionado a caserio: "+cve_def+")</center>";
    		}else if (cgo_def==3){
    			txtrel="<br><center class=n>(Caserio ya relacionado a localidad: "+cve_def+")</center>";
    		}
    		if (!(cgo.equals("45"))){
    			if (cgo.equals("44")){
					out.println("</table>"+txtrel+"<table align=center><tr><td><br><tr><td colspan=5 class=c align='center'><b>2.-Relacionar a:</b> "
					+ "<tr><td align='center'><input "+addsap+" style='font-weight:bold'  type='button' class='boton' id='rel_mza' value='Manzana' onclick='opener.regaddrelcd("+gid+",\""+figura+"\",1)' >&nbsp;&nbsp;&nbsp;"
					+ "<td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_cas' value='Caserio' onclick='opener.regaddrelcd("+gid+",\""+figura+"\",2)' >&nbsp;&nbsp;&nbsp;"
					+ "<td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_loc' value='Localidad' onclick='opener.regaddrelcd("+gid+",\""+figura+"\",3)' >");
				}
				if (cgo.equals("46")){
					out.println("</table>"+txtrel+"<table align=center><tr><td><br><tr><td colspan=5 class=c align='center'><b>2.-Relacionar para registrar su revision:</b> "
					+ "<tr><td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_cas' value='Caserio' onclick='opener.regaddrelcd("+gid+",\""+figura+"\",2)' >&nbsp;&nbsp;&nbsp;");
				}
				/*    --- NO HAGO NADA CON LOS 46 ASI LOS DEJAMOS
				else if (cgo.equals("46")){ //46
				out.println("</table>"+txtrel+"<table align=center><tr><td><br><tr><td colspan=3 class=c align='center'><b>2.-Relacionar a:</b> "
					//+ "<tr><td align='center'><input "+addsap+" style='font-weight:bold'  type='button' class='boton' id='rel_mza' value='Manzana' onclick='opener.regaddrelcd("+gid+",1)' >&nbsp;&nbsp;&nbsp;"
					+ "<tr><td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_cas' value='Caserio' onclick='opener.regaddrelcd("+gid+",\""+figura+"\",2)' >&nbsp;&nbsp;&nbsp;");
					//+ "<td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_loc' value='Localidad' onclick='opener.regaddrelcd("+gid+",\""+figura+"\",3)' >");
				}
			   */
			}
		}



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
if (figura=='CENSOR'){
	tipofigura='C';
}else{
	tipofigura='T';
}


function agrega(gid,cgo,vale){
		window.opener.cvedef=document.regis.proccve.value;
		window.opener.vienedegid=tipofigura+gid;
		window.opener.mcctipomza=tipomza;
		window.opener.obtProy=1;
		window.opener.agregacd(1,cgo,vale);
		window.close();
}


function eliminacd(gid,cgo,vale){
	//if (document.regis.procede.checked){
		window.opener.vienedegid=tipofigura+gid;
		window.opener.mcctipomza=tipomza;
		window.opener.obtProy=1;
		window.opener.eliminacd(vale);
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

function casigna_cd1(cgo,gid,punto){
	//if (document.regis.procede.checked){
		window.opener.vienedegid=tipofigura+gid;
		window.opener.mcctipomza=tipomza;
		window.opener.obtProy=1;
		window.opener.casigna_cd1(cgo,punto);
		window.close();
	//}
}

function casigna_cd2(gid){
    var ajax=nuevoAjax();
    ajax.open("GET",'asigna_loc_cd.jsp?gid='+gid, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==0){
                window.opener.alertmsg ("No se pudo asignar la Localidad");
                window.close();
            }else if (parseInt(vale)==1){
            	window.opener.alertmsg ("Solo se puede relacionar a Localidades Rurales Puntuales");
            }else{
            	window.opener.alertmsg ("Se relaciono el caserio a la Localidad");
            	window.close();
        	}
        }
    }
    ajax.send(null);
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