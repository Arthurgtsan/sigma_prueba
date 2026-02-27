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
String  ca1 = request.getParameter("capa1");
String  ca2 = request.getParameter("capa2");
String  ca3 = request.getParameter("capa3");
String  ca4 = request.getParameter("capa4");
//int  iduser = Integer.parseInt(request.getParameter("c"));
String consulta="";
int capa1 = Integer.parseInt(ca1);
int capa2 = Integer.parseInt(ca2);
int capa3 = Integer.parseInt(ca3);
int capa4 = Integer.parseInt(ca4);
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
		//consulta = "select gid,cgo,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(geom,3857)),ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,tipomza,tipo,figura,cgo_def,status,mal,cveoper from mcc_poblacion.cat_manz_modcar where ((figura='CENSOR' and status in (1,7)) or figura='TCAR') and st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) order by tipo desc,proc,mal,st_Area(geom),cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza desc limit 1";
 //consulta = "select gid,cgo,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(geom,3857)),ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,tipomza,tipo,figura,cgo_def,status,mal,cveoper from mcc_poblacion.cat_manz_modcar where ((figura='CENSOR' and status!='2') or figura='TCAR') and st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) order by baja,tipo desc,proc,mal,st_Area(geom),cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza desc limit 1";


//--VAMOS A ACTIVAR SOLO DEL MCC DURANTE LA EIC

consulta = "select * from ( ";
//	consulta += " select gid,cgo,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(geom,3857)) as geom, ";
//	consulta += " ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,tipomza::varchar,tipo,figura,cgo_def,status::varchar,mal,cveoper as ord,'1MCC' as tipocm ";
//	consulta += " from mcc_poblacion.cat_manz_modcar where  ((figura='CENSOR' and status!='2') or figura='TCAR')  ";
//	consulta += " and st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) and mal!='9' and 1="+capa1;       //LAS MAL=9 NO LAS PUEDEN METER HASTA QUE SE CORRIJAN
//	consulta += " union  ";
	consulta += " select gid,tip_act,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,f_registro,fresp,proc,cve_def,ST_AsText(st_transform(geom,3857)) as geom, ";
	consulta += " ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,a_sinacentos(tipo),'','',cgo_def,status,mal,'1' as ord, '2ACU' as tipocm";
	//consulta += " from act_cu.bcu_bd_manzana where (proc !=1 or f_registro>(select fecha from vista_fecha_corte where tipo='inicia')) and st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) and 1="+capa2;
	consulta += " from act_cu.bcu_bd_manzana where f_registro>(select fecha from vista_fecha_corte where tipo='inicia') and st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) and 1="+capa2;
//	consulta += " union ";
//	consulta += " select gid,'P',cve_ent,substring(cvegeo,3,3),'0000',substring(cvegeo,6,5),'000',fact,fact,'0','0',ST_AsText(st_transform(st_multi(the_geom),3857)),";
//	consulta += " ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto,'0','0','0','0','1',0,'2' as ord, '3PRE' as tipocm";
//	consulta += " from z_digmz where st_intersects(the_geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) and 1="+capa3;
	consulta += " union ";
	consulta += " select gid,tip_act,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,fecha_mod,fecha_mod,0,'',ST_AsText(st_transform(geom,3857)) as geom, ST_AsText(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) as punto, a_sinacentos(tipo),'','',NULL,status,0,'1' as ord, '4ACU' as tipocm from manzanabcu_res where st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),3857)) and 1="+capa4;

consulta += " ) tt  order by tipocm,st_Area(geom),proc,status,mal,st_Area(geom),cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza desc limit 1 ";




	//}
	//out.println(consulta);
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
	String tipo2="";
	String figura="";
	int tip=0;
	int gid=0;
	int mal=0;
	String ft1=" - ";
	String ft2=" - ";
		String cveoper="";

	while(rs.next()){
		String tipoproyecto = rs.getObject(21).toString();
		if ((tipoproyecto.equals("2ACU"))){  //si es ACU
			String site = "obtmza_acu.jsp?capa="+capa2+"&x="+x+"&y="+y;
				response.setStatus(response.SC_MOVED_TEMPORARILY);
				response.setHeader("Location", site);
		}else if ((tipoproyecto.equals("3PRE"))){  //si es PRE
			String site = "obtmza_pre.jsp?capa="+capa3+"&x="+x+"&y="+y;
				response.setStatus(response.SC_MOVED_TEMPORARILY);
				response.setHeader("Location", site);
		}else if ((tipoproyecto.equals("4ACU"))){  //si es ACU recuperada
			String site = "obtmza_acu_rec.jsp?capa="+capa4+"&x="+x+"&y="+y;
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
		mal=Integer.parseInt(rs.getObject(19).toString());
		cveoper= rs.getObject(20).toString();

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
	//if (n==0 || mal==9){
    if (n==0){
		out.println("<script>window.resizeTo(400,200);</script><body>");
		if (n==0){
			out.println("<br><center><table><tr><td class=n>No existe manzana que graficar");
		}else{
			out.println("<br><center><table><tr class=c>");
			out.println("<td align=center nowrap>&nbsp;"+cve_ent+"&nbsp;"+cve_mun+"&nbsp;"+cve_loc+"&nbsp;"+cve_ageb+"&nbsp;"+cve_mza+"&nbsp;<br>");
			out.println("<br><center><table><tr><td class=n>Manzana error en su numero de frentes, no se puede agregar");
		}
		out.println("<tr><td align=center><br><input type=button class=boton value=' Cerrar ' onclick='window.close();'></center>");
	}else{
			if (mal==9){
				out.println("<center><table><tr><td class=n bgcolor=#FFF300>MANZANA FRENTES INCOMPLETOS DESCARGARLA A ARCGIS Y COMPLETARLOS</table>");
			}
			/*
				String consulta1 = "select cveoper, cvegeo, si_en_inm, si_en_entorno, ftes_inmuebles,ftes_entorno from mcc_poblacion.seg_geo_compara_primera where cveoper_corte||cvegeo='"+cveoper+cve_ent+cve_mun+cve_loc+cve_ageb.replace("-","")+cve_mza+"'";
				str1 = conexion.createStatement(rs1.TYPE_SCROLL_SENSITIVE, rs1.CONCUR_UPDATABLE);
    			rs1 = str1.executeQuery( consulta1 );
    			//out.println(consulta1);
    			while(rs1.next()){
					if (rs1.getObject(5) != null){ft1=rs1.getObject(5).toString();}
					if (rs1.getObject(6) != null){ft2=rs1.getObject(6).toString();}
					out.println("<center><table><tr><td align=center class=c>"+rs1.getObject(1).toString()+"&nbsp;&nbsp;&nbsp;<b>Frentes inmuebles: "+ft1+"</b>&nbsp;&nbsp;&nbsp;&nbsp;Frentes entorno: "+ft2);
    			}
				out.println("</center></table>");
				*/
			if (mal==9){
				out.println("<script>window.resizeTo(800,400);</script><body><form name='regis'>");
			}else{
				out.println("<script>window.resizeTo(800,400);</script><body><form name='regis'>");
			}
		String cgotxt="";
		switch(cgo){
			//case "0":cgotxt="Manzanan pre-digitalizada";break;
		    case "1":cgotxt="Fusion de mza";break;
		    case "2":cgotxt="Subdivision de mza";break;
		    case "3":cgotxt="Baja de mza/cd";break;
		    case "4":cgotxt="Creacion de mza/cd";break;
		    //case "5":cgotxt="Cambio mza de ageb";break;
		    //case "6":cgotxt="Cabmio mza de loc";break;
		    case "5":cgotxt="Cambio de forma de mza";break;
		    case "6":cgotxt="Apertura de vialidad";break;
		    case "44":cgotxt="Creacion de Caserio";break;
		    case "45":cgotxt="Baja de Caserio";break;
		    case "46":cgotxt="Modificacion de Caserio";break;
   		    case "FR":cgotxt="Cambio de frentes";break;

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
		out.println("<br><center class=c><table><tr><td bgcolor='#ff7e19' class=c>Manzana desde <u><b>* "+tipo2+" "+figura+" *</b></u></table></center>");


		if (Integer.parseInt(cve_mza)==800 || status==7){
			out.println("<br><center class=n><b>--> LOS CASERIOS AGREGARLOS DESDE LA HERRAMIENTA DE CASERIOS <--</b></center>");
     	}

//filtro los botones solo para los que si proceden
if (((figura.equals("CENSOR") && (status==1 || status==7)) || figura.equals("TCAR"))){

		out.println("<br><table align=center border=1>");
		if (proc==1){
			out.println("<tr class=n><td colspan=10 align=center><font color=red>Esta actualizacion ya se agrego el "+fresp+"</font>");
		}else{
			/*
			if (cgo.equals("1")){  //FUSIONA
				out.println("<tr class=n><td colspan=10 align=center><font color=red>Fusion - primero fusiona las manzanas traslapadas, posteriormente solo cambia de forma la manzana a permanecer</font>");
				out.println("<tr class=n><td colspan=10 align=center>* <font color=red>En la subdivision primero subdivide las manzanas y al final cambia de forma la clave original</font>");
			}else if (cgo.equals("2")){  //SUBDIVIDE
				out.println("<tr class=n><td colspan=10 align=center><font color=red>Subdivision - primero subdivide las manzanas y al final cambia de forma la clave origen (se puede cambiar el codigo)</font>");
				out.println("<tr class=n><td colspan=10 align=center>* <font color=red>En la fusion primero se fusiona la(s) manzana(s) a desaparecer y al final cambia de forma la clave que permanece</font>");
				out.println("<br>* <font color=red>En la subdivision primero subdivide las manzanas y al final cambia de forma la clave original</font>");
			}else if (cgo.equals("3")){  //BAJA
				out.println("<tr class=n><td colspan=10 align=center><font color=red>Baja - baja de manzana o no procede el movimiento</font>");
			}else if (cgo.equals("4")){  //CREACION
			*/
				out.println("<tr class=n><td colspan=10 align=center><font color=red>Creacion - nuevas manzanas o cambios de forma con la manzana que sobreponga (se puede cambiar el codigo)</font>");
				out.println("<tr class=n><td colspan=10 align=center>* <font color=red>En la fusion primero se fusiona la(s) manzana(s) a desaparecer y al final cambia de forma la clave que permanece</font>");
				out.println("<br>* <font color=red>En la subdivision primero subdivide las manzanas y al final cambia de forma la clave original</font>");
				out.println("<br>* <font color=red>Los CAMBIOS DE FORMA deben ser sobre manzanas con la misma clave</font>");
			/*}else if (cgo.equals("5")){  //CAMBIO DE FORMA
				out.println("<tr class=n><td colspan=10 align=center><font color=red>Cambio de forma con la manzana que sobreponga (se puede cambiar el codigo)</font>");
				out.println("<tr class=n><td colspan=10 align=center>* <font color=red>En la fusion primero se fusiona la(s) manzana(s) a desaparecer y al final cambia de forma la clave que permanece</font>");
				out.println("<br>* <font color=red>En la subdivision primero subdivide las manzanas y al final cambia de forma la clave original</font>");
			}else if (cgo.equals("6")){  //CAMBIO DE FORMA
				out.println("<tr class=n><td colspan=10 align=center><font color=red>Cambio de forma con la manzana que sobreponga (se puede cambiar el codigo)</font>");
				out.println("<tr class=n><td colspan=10 align=center>* <font color=red>En la fusion primero se fusiona la(s) manzana(s) a desaparecer y al final cambia de forma la clave que permanece</font>");
				out.println("<br>* <font color=red>En la subdivision primero subdivide las manzanas y al final cambia de forma la clave original</font>");
			}else{
				out.println("<tr class=n><td colspan=10 align=center><font color=red>Pre-digitalizada - nuevas manzanas o cambios de forma con la manzana que sobreponga (se puede cambiar el codigo)</font>");
				out.println("<tr class=n><td colspan=10 align=center>* <font color=red>En la fusion primero se fusiona la(s) manzana(s) a desaparecer y al final cambia de forma la clave que permanece</font>");
				out.println("<br>* <font color=red>En la subdivision primero subdivide las manzanas y al final cambia de forma la clave original</font>");
			}*/
		}
		out.println("<tr class=n><th>&nbsp;&nbsp;Clave&nbsp;&nbsp;<th>&nbsp;Codigo&nbsp;<th>&nbsp;Fecha&nbsp;<!--<th>SI<br>&nbsp;Procede&nbsp;<th>NO<br>&nbsp;Procede&nbsp;--><th>&nbsp;Codigo&nbsp;<br>&nbsp;definitivo&nbsp;<th>&nbsp;Clave&nbsp;<br>&nbsp;definitiva&nbsp;<th>&nbsp;Ingresar&nbsp;");
		if (cgo.equals("4") || cgo.equals("2") || cgo.equals("1") || cgo.equals("5") || cgo.equals("FR") || cgo.equals("6") || cgo.equals("0")){
			out.println("<th>&nbsp;Cambio&nbsp;");
		}
		out.println( "<tr class=c>");
        out.println("<td align=center nowrap>&nbsp;"+cve_ent+"&nbsp;"+cve_mun+"&nbsp;"+cve_loc+"&nbsp;"+cve_ageb+"&nbsp;"+cve_mza+"&nbsp;");
        out.println("<td align=center nowrap title='"+cgotxt+"'>&nbsp;&nbsp;"+cgo+"&nbsp;&nbsp;");
        out.println("<td align=center nowrap>&nbsp;&nbsp;"+f_registro+"&nbsp;&nbsp;");
        /*
        out.println("<td align=center nowrap>&nbsp;&nbsp;<input type='checkbox' ");
        if (cgo.equals("5") || cgo.equals("6") || cgo.equals("0") || cgo.equals("1") ){
			cgo="4";
		}
        if (proc!=0){
        	if (proc==1){
        		out.println(" disabled checked ");
        	}else{
        		out.println(" disabled ");
        	}
    	}
        out.println("name='procede' onClick='proc() selected'>&nbsp;&nbsp;");
        /*
        //---------------NO PROCEDE RADIO ----------------------------
        /*out.println("<td nowrap>");
        if (proc!=0){
        	if (proc==2){
        	    out.println("<input type='radio' id='rad1' disabled name='noprocede' value='2' checked> Por criterios MG <br>");
        	    out.println("<input type='radio' id='rad2' disabled name='noprocede' value='3'> Por ser caserio<br>");
        	    out.println("<input type='radio' id='rad3' disabled name='noprocede' value='4'> # de Mzs < 3");
        	}else if (proc==3){
				out.println("<input type='radio' id='rad1' disabled name='noprocede' value='2'> Por criterios MG <br>");
        	    out.println("<input type='radio' id='rad2' disabled name='noprocede' value='3' checked> Por ser caserio <br>");
        	    out.println("<input type='radio' id='rad3' disabled name='noprocede' value='4'> # de Mzs < 3");
        	}else if (proc==4){
				out.println("<input type='radio' id='rad1' disabled name='noprocede' value='2'> Por criterios MG <br>");
        	    out.println("<input type='radio' id='rad2' disabled name='noprocede' value='3'> Por ser caserio <br>");
        	    out.println("<input type='radio' id='rad3' disabled name='noprocede' value='4' checked> # de Mzs < 3");
        	}else{
        		out.println("<input type='radio' id='rad1' disabled name='noprocede' value='2'> Por criterios MG <br>");
        	    out.println("<input type='radio' id='rad2' disabled name='noprocede' value='3'> Por ser caserio<br>");
        	    out.println("<input type='radio' id='rad3' disabled name='noprocede' value='4'> # de Mzs < 3");
        	}
    	}else{
				out.println("<input type='radio' id='rad1' onClick='noproc()' name='noprocede' value='2'> Por criterios MG <br>");
        	    out.println("<input type='radio' id='rad2' onClick='noproc()' name='noprocede' value='3'> Por ser caserio <br>");
        	    out.println("<input type='radio' id='rad3' onClick='noproc()' name='noprocede' value='4'> # de Mzs < 3");
    	}*/
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
    		if (cgo.equals("4") || cgo.equals("6") || cgo.equals("5") || cgo.equals("FR")){esc4=" selected ";}
    		out.println("<td align=center nowrap>&nbsp;<select name=codef class='boton'>");
    		//out.println("<option value='1' "+esc1+">1-Fusion</option>");
    		out.println("<option value='2' "+esc2+">2-Subdivision</option>");
    		out.println("<option value='4' "+esc4+">4-Nueva</option>");
    		out.println("</select>");
	        out.println("<td align=center nowrap>&nbsp;<input class='boton' type='text' size='18' name='proccve' disabled maxlength='17' ");
	        if (proc==0){
				out.println(" value='"+cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza+"'>&nbsp;");
	    	}else{
	    		out.println(" value='"+cve_def+"'>&nbsp;");
	    	}
    	}

if (proc==1 || Integer.parseInt(cve_mza)==800 || status==7){ // si ya esta atendido no pongo los botones
	if (cgo.equals("3")){
		out.println("<td align=center nowrap colspan=1>&nbsp;-----&nbsp;");
	}else{
		out.println("<td align=center nowrap colspan=2>&nbsp;-----&nbsp;");
	}
}else{
 		if (cgo.equals("FR")){
        	out.println("<td align=center nowrap>&nbsp;-&nbsp;");
        	out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton2 onclick='cambiageom(5,"+gid+",\""+vale+"\",\""+punto+"\",\""+cve_mza+"\",\""+cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza+"\")' value=' Forma ' class='boton'>&nbsp;");
        }else if (cgo.equals("4") || cgo.equals("5") || cgo.equals("6")  ){
        	if (Integer.parseInt(cve_mza)>900){
								out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton1 onclick='agrega("+gid+","+cgo+",\""+vale+"\")' value=' Agregar ' class='boton'>&nbsp;");
        	}else{
   		        	out.println("<td align=center nowrap>&nbsp;-&nbsp;");

        	}
        	out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton2 onclick='cambiageom("+cgo+","+gid+",\""+vale+"\",\""+punto+"\",\""+cve_mza+"\",\""+cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza+"\")' value=' Forma ' class='boton'>&nbsp;");
        }else if (cgo.equals("2")){
        	 if (Integer.parseInt(cve_mza)>900){
									out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton1 onclick='agrega("+gid+","+cgo+",\""+vale+"\")' value=' Agregar ' class='boton'>&nbsp;");
						}else{
   		        	out.println("<td align=center nowrap>&nbsp;-&nbsp;");
						}
        	out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton2 onclick='cambiageom("+cgo+","+gid+",\""+vale+"\",\""+punto+"\",\""+cve_mza+"\",\""+cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza+"\")' value=' Forma ' class='boton'>&nbsp;");
        }else if (cgo.equals("1")){
        	if (Integer.parseInt(cve_mza)>900){
									out.println("<td align=center nowrap>&nbsp;<input type=button name=procboton1 onclick='fusiona("+gid+","+cgo+",\""+vale+"\")' value=' Agregar ' class='boton'>&nbsp;");
					}else{
	   		        	out.println("<td align=center nowrap>&nbsp;-&nbsp;");
					}
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


    	//out.println("</table><br><center class=n>Tipo de Manzana:&nbsp;&nbsp;</font>"+tipotxt);
    	/*if (proc!=0){
    		if (proc==3){
    			out.println("</table><center class=n><br><br>&nbsp;Manzana Proyectada:&nbsp;&nbsp;<input class='boton' type='text' size='18' name='proycve' maxlength='17' value='"+cve_def+"' disabled>");
    		}else{
    			out.println("</table><center class=n><br><br>&nbsp;Manzana Proyectada:&nbsp;&nbsp;<input class='boton' type='text' size='18' name='proycve' maxlength='17' value='' disabled>");
    	}
        }else{
	        out.println("</table><center class=n><br><br>&nbsp;Manzana Proyectada?&nbsp;&nbsp;<input class='boton' type='text' size='18' name='proycve' maxlength='17' value='"+cve_ent+cve_mun+"0000'>&nbsp;&nbsp;<input type=button name=proyectada onclick='proy("+gid+","+cgo+")' value=' Proyectada ' class='boton' >&nbsp;");
    	}*/

 }else{
			///deshabilite el iduser inicial
		/*if (iduser==44 || iduser==477){    //SOLO A MARLEN O YO 477
				out.println("<br><table align=center border=1><br><br><br>");
				out.println("<tr class=n><td colspan=10 align=center><font color=red>&nbsp;&nbsp;Esta manzana es rechazada, solo puede relacionarla MARLEN a caserio disperso&nbsp;&nbsp;</font>");

		 			String addsap="";
			    	String txtrel="";
			    	if (proc==1 || Integer.parseInt(cve_mza)==800 || status==7 || Integer.parseInt(cve_mza)<900){
			    		//addsap="disabled";
			    		out.println("</table><table align=center><tr><td><br><tr><td colspan=3 class=c align='center'><br><b>NO SE PUEDE RELACIONAR ESTA MANZANA</b> ");
			    	}else{
			    		if (cgo_def==1){
			    			txtrel="<br><center class=n>(Manzana ya relacionada a manzana: "+cve_def+")</center>";
			    		}else if (cgo_def==2){
			    			txtrel="<br><center class=n>(Manzana ya relacionada a caserio: "+cve_def+")</center>";
			    		}else if (cgo_def==3){
			    			txtrel="<br><center class=n>(Manzana ya relacionada a localidad: "+cve_def+")</center>";
			    		}
			    		if (!(cgo.equals("3") || cgo.equals("FR") ) && (figura.equals("CENSOR") || figura.equals("TCAR"))){
							out.println("</table>"+txtrel+"<table align=center><tr><td><br><tr><td colspan=10 class=c align='center'><b>2.-Relacionar a:</b> <tr>"
							//+ "<td align='center'><input "+addsap+" style='font-weight:bold'  type='button' class='boton' id='rel_mza' value='Manzana' onclick='opener.regaddrelmza("+gid+",\""+figura+"\",1)' >&nbsp;&nbsp;&nbsp;"
							+ "<td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_cas' value='Caserio' onclick='opener.regaddrelmza("+gid+",\""+figura+"\",2)' >&nbsp;&nbsp;&nbsp;"
							+ "<td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_loc' value='Localidad' onclick='opener.regaddrelmza("+gid+",\""+figura+"\",3)' >"
							);
						}else{
									out.println("</table><table align=center><tr><td><br><tr><td colspan=3 class=c align='center'><br><b>NO SE PUEDE RELACIONAR ESTA MANZANA</b> ");
						}
					}
		}else{
			// aqui pongo una tablita si la manzna es rechazada
				out.println("<br><table align=center border=1><br><br><br>");
			//out.println("<tr class=n><td colspan=10 align=center><font color=red>&nbsp;&nbsp;Esta manzana es rechazada, solo se debe relacionar&nbsp;&nbsp;</font>");
				out.println("<tr class=n><td colspan=10 align=center><font color=red>&nbsp;&nbsp;Esta manzana es rechazada, se debe relacionar los frentes&nbsp;&nbsp;</font>");
		}
		*/

}
/*
///aqui empuieza la relacionada

    	String addsap="";
    	String txtrel="";
    	if (proc==1 || Integer.parseInt(cve_mza)==800 || status==7){
    		addsap="disabled";
    	}else{
    		if (cgo_def==1){
    			txtrel="<br><center class=n>(Manzana ya relacionada a manzana: "+cve_def+")</center>";
    		}else if (cgo_def==2){
    			txtrel="<br><center class=n>(Manzana ya relacionada a caserio: "+cve_def+")</center>";
    		}else if (cgo_def==3){
    			txtrel="<br><center class=n>(Manzana ya relacionada a localidad: "+cve_def+")</center>";
    		}
    		if (!(cgo.equals("3") || cgo.equals("FR") ) && (figura.equals("CENSOR") || figura.equals("TCAR"))){
				out.println("</table>"+txtrel+"<table align=center><tr><td><br><tr><td colspan=10 class=c align='center'><b>2.-Relacionar a:</b> "
				+ "<tr><td align='center'><input "+addsap+" style='font-weight:bold'  type='button' class='boton' id='rel_mza' value='Manzana' onclick='opener.regaddrelmza("+gid+",\""+figura+"\",1)' >&nbsp;&nbsp;&nbsp;"
				+ "<td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_cas' value='Caserio' onclick='opener.regaddrelmza("+gid+",\""+figura+"\",2)' >&nbsp;&nbsp;&nbsp;"
				+ "<td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_loc' value='Localidad' onclick='opener.regaddrelmza("+gid+",\""+figura+"\",3)' >");
			}else{
				if ((cgo.equals("3"))){
					if ((status==1)){
							out.println("</table>"+txtrel+"<table align=center><tr><td><br><tr><td colspan=10 class=c align='center'><b>2.-Relacionar a:</b> "
							+ "<tr><td align='center'><input "+addsap+" style='font-weight:bold'  type='button' class='boton' id='rel_mza' value='Manzana' onclick='window.opener.cvedef=\""+cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza+"\";opener.regaddrelmza("+gid+",\""+figura+"\",4)' >&nbsp;&nbsp;&nbsp;");
									//out.println("</table>"+txtrel+"<table align=center><tr><td><br><tr><td colspan=3 class=c align='center'><b>NO SE PUEDEN RELACIONAR MANZANAS DE BAJA O DEL TCAR</b> ");
								out.println("</table><table align=center><tr><td><br><tr><td colspan=3 class=c align='center'><b>SOLO SE PUEDE RELACIONAR A MANZANA ELIMINADA (ROJO) Y MISMA CLAVE</b> ");
					}else{
								out.println("</table><table align=center><tr><td><br><tr><td colspan=3 class=c align='center'><br><b>NO SE PUEDE RELACIONAR UNA MANZANA DE BAJA QUE NO PROCEDE</b> ");
					}
				}
			}
		}
		*/
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
		window.opener.obtProy=1;
		window.opener.cambiageom(cgo,vale,punto,cvemza,clave);
		window.close();
	//}
}

function casigna(cgo,gid,punto){
	//if (document.regis.procede.checked){
		window.opener.vienedegid=tipofigura+gid;
		window.opener.mcctipomza=tipomza;
		window.opener.obtProy=1;
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
		window.opener.obtProy=1;
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
	if (document.regis.procede.checked){
		window.opener.vienedegid=tipofigura+gid;
		window.opener.mcctipomza=tipomza;
		window.opener.obtProy=1;
		window.opener.fusionamz(cve,vale);
		window.close();
	}else{
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
	}
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
		window.opener.obtProy=1;
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
	window.opener.alertmsg("Debes de proporcionar la clave completa!");
	return false;
}
var ajax=nuevoAjax();
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