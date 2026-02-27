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
.n2{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: bold;;color: red;}
.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}
a.liga1:link { font-size: 9pt; color: black;text-decoration: none;font-family: Arial;}
a.liga1:visited {font-size: 9pt;color: black;text-decoration: none;font-family: Arial;}
a.liga1:hover {font-size: 9pt;color: black;text-decoration: none;font-family: Arial;}
.liga {font-size: 9pt;color: red;text-decoration: none;font-family: Arial;}
a.liga2:link {  text-decoration: none;}
a.liga2:visited { text-decoration: none;}
a.liga2:hover { text-decoration: none;}

</style>

<script>
window.resizeTo(600,500);
</script>
<%
String  x = request.getParameter("x");
String  y = request.getParameter("y");
String  ca = request.getParameter("capa");
String consulta="";
int capa = Integer.parseInt(ca);
String cgo="";
	Integer gid=0;
	String cve_ent="";
	String cve_mun="";
	String cve_ageb="";
	String cve_loc="";
	String nomgeo="";
	String codigoAct="0";
	Integer usado=0;
	String cve_mza="";
	String nota="";
	String concaCod="";
	int status=0;
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();

try {
	//if (capa==1){ //MCC
		//consulta = "select gid,cveoper,cve_ent,cve_mun,cve_loc,cve_ageb,nomgeo,plano,codigoact::integer,replace(replace(b_decgra(st_x(st_transform(geom,4326)),st_y(st_transform(geom,4326)))::character varying,'{',''),'}','') as coord,geom,status,nota,'1' as actu,usado,cve_mza,st_distance(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) from (select gid,cveoper,cve_ent,cve_mun,cve_loc,cve_ageb,nomgeo,plano,codigoact,geom,status,nota,'1' as actu,usado,cve_mza from mcc_poblacion.loc_rur union select gid,cveoper,cve_ent,cve_mun,cve_loc,cve_ageb,'' as nomgeo,'' as plano,'8' as codigoact,(select the_geom from cat_loc_val_arcgis where clave=t2.cve_ent||t2.cve_mun||t2.cve_loc),status,nota,'2' as actu,usado,cve_mza from mcc_poblacion.loc_rur_baja t2 ) t1 WHERE st_intersects(geom,st_buffer(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800),500))   order by st_distance(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800))   limit 1";
		
		//esta consulta es solo para el mcc
		/*consulta="select gid,cveoper,cve_ent,cve_mun,cve_loc,cve_ageb,nomgeo,plano,codigoact::integer,replace(replace(b_decgra(st_x(st_transform(geom,4326)),st_y(st_transform(geom,4326)))::character varying,'{',''),'}','') as coord,geom,status,nota,'1' as actu,st_distance(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)),proc,cgo_def::integer,cve_def from mcc_poblacion.loc_rur WHERE st_intersects(geom,st_buffer(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800),50))  order by st_distance(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)),proc  limit 1;";*/






		//esta consult ees para el MCC +CUR
consulta = "select * from ( ";
	consulta += "	(select gid,cveoper,cve_ent,cve_mun,cve_loc,cve_ageb,nomgeo,plano,codigoact::varchar,replace(replace(b_decgra(st_x(st_transform(geom,4326)),st_y(st_transform(geom,4326)))::character varying,'{',''),'}','') as coord,geom,status,nota,1 as actu,st_distance(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)),proc,cgo_def::integer,cve_def from mcc_poblacion.loc_rur WHERE st_intersects(geom,st_buffer(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800),100)) order by st_distance(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)),proc limit 1)" ;
	consulta += " union ";
	consulta += "(select gid,'0' as cveoper,cve_ent,cve_mun,cve_loc,cve_ageb,nom_loc||'  - Conocido: '||nomloc_co||' -' as nomgeo,distribuc as plano,tipo_act as codigoact,replace(replace(b_decgra(st_x(st_transform(geom,4326)),st_y(st_transform(geom,4326)))::character varying,'{',''),'}','') as coord,geom,status::integer,observ as nota,2 as actu,st_distance(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)),proc,cgo_def::integer,cve_def from act_cu.bcu_bd_loc_rur WHERE f_registro > (select fecha from vista_fecha_corte where tipo='inicia') AND upper(left(bcu_bd_loc_rur.tipo_act::text, 3)) <> 'SIN'::text and st_intersects(geom,st_buffer(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800),100)) order by st_distance(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)),proc limit 1) ) tt2 order by proc,actu limit 1";

	//}
	//out.println(consulta);
	//out.println(ca);
	  ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
	  Integer contador=0;
	  conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    rs = str.executeQuery( consulta );
	int n=0;
	int cgo_def=0;
	String cve_def="";
	int proc=0;
	String sttxt="";
	int tipoact=0;
	//----------------------------------------------------------------------------------------------------------------------------------------------------------------
	while(rs.next()) {
					 tipoact=(Integer)(rs.getObject("actu"));
					 if (tipoact==1){  //MCC
										gid=(Integer)(rs.getObject("gid"));
										cve_ent=(String)(rs.getObject("cve_ent"));
										cve_mun=(String)(rs.getObject("cve_mun"));
										cve_loc=(String)(rs.getObject("cve_loc"));
										cve_ageb=(String)(rs.getObject("cve_ageb"));
										nomgeo="-----------";
										if (rs.getObject("nomgeo") != null){
								        nomgeo=(String)(rs.getObject("nomgeo"));
								      }
										status=(int)(rs.getObject("status"));
										if (rs.getObject("cgo_def") != null){
								        	cgo_def=(int)(rs.getObject("cgo_def"));
								      	}

										cve_def=(String)(rs.getObject("cve_def"));
										proc=(int)(rs.getObject("proc"));
										codigoAct=(String)(rs.getObject("codigoact"));
										if(codigoAct.equals("7")){
											concaCod=codigoAct+ "-Alta";
										}else if(codigoAct.equals("8")){
											concaCod=codigoAct+ "-Baja";
										}else if(codigoAct.equals("81")){
											concaCod=codigoAct+ "-Baja (Inexistente)";
										}else if(codigoAct.equals("82")){
											concaCod=codigoAct+ "-Baja (Conurbacion)";
										}else if(codigoAct.equals("83")){
											concaCod=codigoAct+ "-Baja (Fusion)";
										}else if(codigoAct.equals("9")){
											concaCod=codigoAct+ "-Cambio Nombre";
										}
								      switch(status){
								             case 1:sttxt="Aceptada";break;
								             case 2:sttxt="C/cambios";break;
								             case 3:
								             case 4:
								             case 5:
								             case 6:
								             case 7:
								             case 8:
								             case 9:
								                    sttxt="Rechazada";break;
								      }
										//usado=(Integer)(rs.getObject("usado"));
										//cve_mza=(String)(rs.getObject("cve_mza"));

										if (rs.getObject("nota") != null){
								        nota=(String)(rs.getObject("nota"));
												if (nota.equals("")){
													nota="Sin nota";
												}
								      }

							}else{ //CUR   ///////////////////////////////////////////////////////////////////////////////////////////////////
										gid=(Integer)(rs.getObject("gid"));
										cve_ent=(String)(rs.getObject("cve_ent"));
										cve_mun=(String)(rs.getObject("cve_mun"));
										cve_loc=(String)(rs.getObject("cve_loc"));
										cve_ageb=(String)(rs.getObject("cve_ageb"));
										nomgeo="-----------";
										if (rs.getObject("nomgeo") != null){
								        nomgeo=(String)(rs.getObject("nomgeo"));
								      }
										status=(int)(rs.getObject("status"));
										if (rs.getObject("cgo_def") != null){
								        	cgo_def=(int)(rs.getObject("cgo_def"));
								      	}

										cve_def=(String)(rs.getObject("cve_def"));
										proc=(int)(rs.getObject("proc"));
										codigoAct=(String)(rs.getObject("codigoact"));
										concaCod=codigoAct;
										sttxt=(String)(rs.getObject("plano"));;

										//usado=(Integer)(rs.getObject("usado"));
										//cve_mza=(String)(rs.getObject("cve_mza"));
										if (rs.getObject("nota") == null){
												nota="Sin nota";
											}else{
												nota=(String)(rs.getObject("nota"));
												if (nota.equals("")){
										  		nota="Sin nota";
											}
										}
							}
						contador=contador+1;
	}   /// while
	str.close();
    conexion.close();


  if (contador==0){
  		out.println("<script>opener.alertmsg('No hay Localidad cercana del punto seleccionado');window.close();</script>");
  }else{

				 if (tipoact==1){  //MCC
								out.println ("<body><br><form name='captura'  action='http://"+request.getServerName()+":8888/catalogos2/loc_sigma/loc-cap.php' method='post'>");
								%>
								<input type="hidden" name="gid" value='<%=gid%>'>
								<input type="hidden" name="cve_ent" value='<%=cve_ent%>'>
								<input type="hidden" name="cve_mun" value='<%=cve_mun%>'>
								<input type="hidden" name="cve_loc" value='<%=cve_loc%>'>
								<input type="hidden" name="cve_ageb" value='<%=cve_ageb%>'>
								<input type="hidden" name="nomgeo" value='<%=nomgeo%>'>
								<input type="hidden" name="status" value='<%=status%>'>
								<input type="hidden" name="codigo" value='<%=codigoAct%>'>

								<input type="hidden" name="lat_x" value='<%=x%>'>
								<input type="hidden" name="lon_y" value='<%=y%>'>
								<input type="hidden" name="codact" value='<%=concaCod%>'>
								<input type="hidden" name="conta" value='<%=contador%>'>
								<input type="hidden" name="nota" value='<%=nota%>'>

								<input type="hidden" name="actu" value='<%=tipoact%>'>

								<%
								out.println("<center>");
								String addsap="";

     						 out.println( "<center class='t'><b  style='background-color: #F5A560;' >&nbsp;&nbsp;Modulo Cartografico EIC2025 (LOCALIDADES)&nbsp;&nbsp;</b><br><br>");


								if (proc==1){
										out.println("<font class=n2>Localidad agregada a SAP");addsap="disabled";
								}else if (proc==2){
									switch (cgo_def){
											case 1:
										out.println("<font class=n2>Localidad relacionada a manzana: "+cve_def);break;
											case 2:
										out.println("<font class=n2>Localidad relacionada a caserio: "+cve_def);break;
											case 3:
										out.println("<font class=n2>Localidad relacionada a localidad: "+cve_def);break;
										}
								}else{
									out.println("<font class=n>Localidad no relacionada ");
								}
								out.println("</font></center>");

								%>
								<br>
								<table border=1 align=center width="90%"><tr class=n bgcolor=#BBBBBB>
								<td  class=c align="center"><b>&nbsp;GidMcc&nbsp;</b>
								<td  class=c align="center"><b>&nbsp;CveEnt&nbsp;</b>
								<td  class=c align="center"><b>&nbsp;CveMun&nbsp;</b>
								<td  class=c align="center"><b>&nbsp;CveLoc&nbsp;</b>
								<td  class=c align="center"><b>&nbsp;CveAgeb&nbsp;</b>
								<td  class=c align="center"><b>&nbsp;CodigoAct&nbsp;</b>
								<tr>
								<td  class=c align="center">&nbsp;<%=gid%>&nbsp;
								<td  class=c align="center">&nbsp;<%=cve_ent%>&nbsp;
								<td  class=c align="center">&nbsp;<%=cve_mun%>&nbsp;
								<td  class=c align="center">&nbsp;<%=cve_loc%>&nbsp;
								<td  class=c align="center">&nbsp;<%=cve_ageb%>&nbsp;
								<td  class=c align="center">&nbsp;<%=concaCod%>&nbsp;
								<tr>
								</table>
								<br>
								<table border=1 align=center width="90%">
									<tr><td  class=n bgcolor=#BBBBBB width="8%"><b>&nbsp;Nombre:&nbsp;</b><td  class=n ><%=nomgeo%>
									<tr><td  class=n bgcolor=#BBBBBB width="8%"><b>&nbsp;Nota:&nbsp;</b><td  class=n ><%=nota%>
									<tr><td  class=n bgcolor=#BBBBBB width="8%"><b>&nbsp;Status:&nbsp;</b><td  class=n ><%=status%> - <%=sttxt%>

								</table>
								<table align="center" border="0">
								<center>
								<tr><br>
								<% 

									if (!(( codigoAct.equals("8") || codigoAct.equals("81") || codigoAct.equals("82") || codigoAct.equals("83")) && status!=1)){
									    %>
												<tr>
												<td colspan=3 class=c align="center"><b>1.-Captura de Localidades SAP</b>
												<tr>
												<td colspan=3 align="center"><input <%=addsap%>  style="font-weight:bold" type="button" class="boton" id="cap_sap" value="Capturar" onclick="captura_sap(<%=contador%>,'captura')" >
													<!--//hay que agregar esto en el boton <%=addsap%>-->
												<tr>
												<td><br>
								<% 
									}
								if (codigoAct.equals("7")){
									out.println("<tr><td colspan=3 class=c align='center'><b>2.-Relacionar a:</b><tr>"
									+"<td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_mza' value='Manzana' onclick='opener.regaddrelloc("+gid+",1)' >&nbsp;&nbsp;&nbsp;"
									+"<td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_cas' value='Caserio' onclick='opener.regaddrelloc("+gid+",2)' >&nbsp;&nbsp;&nbsp;"
									+"<td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_loc' value='Localidad' onclick='opener.regaddrelloc("+gid+",3)' >");
								}else if (codigoAct.equals("9")){
									out.println("<tr><td colspan=3 class=c align='center'><b>2.-Relacionar a:</b><tr>"
									+"<td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_loc' value='Localidad' onclick='opener.regaddrelloc("+gid+",3)' >");
								}else	if (( codigoAct.equals("8") || codigoAct.equals("81") || codigoAct.equals("82") || codigoAct.equals("83")) && status==1){
									out.println("<tr><td colspan=3 class=c align='center'><b>2.-Relacionar a una localidad ya dada de baja en SAP:</b><tr>"
									+"<td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_loc' value='Localidad' onclick='opener.regaddrelloc("+gid+",8)' >");
								}else{
									out.println("<tr><td colspan=3 class=c align='center'><br><b> -- Baja rechazada no se relaciona -- </b><tr>");
								}

								%>
									<!--//hay que agregar esto en los boton <%=addsap%>-->
								<tr>
								<td><br>
								<tr>
								</table></table>
								</form>
								</body>
								<script language="javascript">
								var valor=0;
								function captura_sap (valor,opcion) {
								if(valor==1){
									ventana = window.open('http://'+location.host.substr(0,(location.host.length-5))+':8888/catalogos2/loc_sigma/loc-cap.php','AgregarMz','toolbar=no,Resizable=1,scrollbars=1');
									document.captura.submit();
								} else{
									//alertmsg("No hay Localidad cercana del punto seleccionado");
								}
								}

								var	lati=document.captura.lat_x.value;
								var	longi=document.captura.lon_y.value;
								var	codig=document.captura.codact.value;
								var val=document.captura.conta.value;

								/*window.onload=function(){
								if(val==1){
									if(codig==9){    //cambio de nombre se va directo 
									ventana = window.open('http://'+location.host.substr(0,(location.host.length-5))+':8888/catalogos2/loc_sigma/loc-cap.php','AgregarMz','toolbar=no,Resizable=1,scrollbars=1');
									document.captura.submit();
										}
								}
								}*/

								</script>
								</html>
								<%
				}else{     ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// aqui empiesa de la CUR
					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
								out.println ("<body><br><form name='captura'  action='http://"+request.getServerName()+":8888/catalogos2/loc_sigma/loc-cap.php' method='post'>");
								%>


								<input type="hidden" name="gid" value='<%=gid%>'>
								<input type="hidden" name="cve_ent" value='<%=cve_ent%>'>
								<input type="hidden" name="cve_mun" value='<%=cve_mun%>'>
								<input type="hidden" name="cve_loc" value='<%=cve_loc%>'>
								<input type="hidden" name="cve_ageb" value='<%=cve_ageb%>'>
								<input type="hidden" name="nomgeo" value='<%=nomgeo%>'>
								<input type="hidden" name="status" value='<%=status%>'>
								<input type="hidden" name="codigo" value='<%=codigoAct%>'>

								<input type="hidden" name="lat_x" value='<%=x%>'>
								<input type="hidden" name="lon_y" value='<%=y%>'>
								<input type="hidden" name="codact" value='<%=concaCod%>'>
								<input type="hidden" name="conta" value='<%=contador%>'>
								<input type="hidden" name="nota" value='<%=nota%>'>

								<input type="hidden" name="actu" value='<%=tipoact%>'>


								<%
								out.println("<center>");
								String addsap="";

     					 out.println( "<center class='t'><b class='t' style='background-color: #E7A4F9;'>&nbsp;&nbsp;AC Integral&nbsp;&nbsp;(LOCALIDADES)</b><br><br>");


								if (proc==1){
										out.println("<font class=n2>Localidad agregada a SAP");addsap="disabled";
								}else if (proc==2){
									switch (cgo_def){
											case 1:
										out.println("<font class=n2>Localidad relacionada a manzana: "+cve_def);break;
											case 2:
										out.println("<font class=n2>Localidad relacionada a caserio: "+cve_def);break;
											case 3:
										out.println("<font class=n2>Localidad relacionada a localidad: "+cve_def);break;
										}
								}else{
									out.println("<font class=n>Localidad no relacionada ");
								}
								out.println("</font></center>");

								%>
								<br>
								<table border=1 align=center width="90%"><tr class=n bgcolor=#BBBBBB>
								<td  class=c align="center"><b>&nbsp;GidMcc&nbsp;</b>
								<td  class=c align="center"><b>&nbsp;CveEnt&nbsp;</b>
								<td  class=c align="center"><b>&nbsp;CveMun&nbsp;</b>
								<td  class=c align="center"><b>&nbsp;CveLoc&nbsp;</b>
								<td  class=c align="center"><b>&nbsp;CveAgeb&nbsp;</b>
								<td  class=c align="center"><b>&nbsp;CodigoAct&nbsp;</b>
								<tr>
								<td  class=c align="center">&nbsp;<%=gid%>&nbsp;
								<td  class=c align="center">&nbsp;<%=cve_ent%>&nbsp;
								<td  class=c align="center">&nbsp;<%=cve_mun%>&nbsp;
								<td  class=c align="center">&nbsp;<%=cve_loc%>&nbsp;
								<td  class=c align="center">&nbsp;<%=cve_ageb%>&nbsp;
								<td  class=c align="center">&nbsp;<%=concaCod%>&nbsp;
								<tr>
								</table>
								<br>
								<table border=1 align=center width="90%">
									<tr><td  class=n bgcolor=#BBBBBB width="8%"><b>&nbsp;Nombre:&nbsp;</b><td  class=n ><%=nomgeo%>
									<tr><td  class=n bgcolor=#BBBBBB width="8%"><b>&nbsp;Nota:&nbsp;</b><td  class=n ><%=nota%>
									<tr><td  class=n bgcolor=#BBBBBB width="8%"><b>&nbsp;Tipo:&nbsp;</b><td  class=n ><%=sttxt%>

								</table>
								<table align="center" border="0">
								<center>
								<tr><br>
								<td><br>
								<%


									/*
									1 Alta
									2 Alta Desconurbación
									3 Alta Desfusión
									4 Baja Conurbación
									5 Baja Fusión
									6 Baja Inexistente
									7 Baja Tapias o Ruinas
									8 Baja Uso No Habitacional
									9 Cambio Entidad
									10 Cambio Municipio
									11 Cambio Municipio Nuevo
									12 Cambio Reubicada
									13 Cambio de Nombre
									14 Reactivada
									15 Sin Cambios
									16 Otro
									*/
								switch (codigoAct.substring(0,3)){
									case "Alt":
									case "Rea":
											out.println("<tr><td colspan=3 class=c align='center'><b>1.-Captura de Localidades SAP</b><tr>"
											+"<td colspan=3 align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='cap_sap' value='Capturar' onclick='captura_sap("+contador+",\"captura\")' >");
											%>
												<!--//hay que agregar esto en el boton <%=addsap%>-->
											<%
											out.println ("<tr><td><br>");
											out.println("<tr><td colspan=3 class=c align='center'><b>2.-Relacionar a:</b><tr>"
											+"<td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_mza' value='Manzana' onclick='opener.regaddrelloc("+gid+",11)' >&nbsp;&nbsp;&nbsp;"
											+"<td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_cas' value='Caserio' onclick='opener.regaddrelloc("+gid+",21)' >&nbsp;&nbsp;&nbsp;"
											+"<td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_loc' value='Localidad' onclick='opener.regaddrelloc("+gid+",31)' >");
											break;
									case "Baj":
											out.println("<tr><td colspan=3 class=c align='center'><b>1.-Captura de Localidades SAP</b><tr>"
											+"<td colspan=3 align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='cap_sap' value='Capturar' onclick='captura_sap("+contador+",\"captura\")' >");
											%>
												<!--//hay que agregar esto en el boton <%=addsap%>-->
											<%
											out.println ("<tr><td><br>");
											out.println("<tr><td colspan=3 class=c align='center'><b>2.-Relacionar a una localidad ya dada de baja en SAP:</b><tr>"
											+"<td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_loc' value='Localidad' onclick='opener.regaddrelloc("+gid+",81)' >");
											break;
									case "Cam":
											switch (codigoAct){
												case "Cambio Reubicada":
															out.println("<tr><td colspan=3 class=c align='center'><b>(Este tipo de registro ser&aacute; modificado con la herramienta en SIGMA)</b><tr>");
															break;
												case "Cambio de Nombre":
															out.println("<tr><td colspan=3 class=c align='center'><b>1.-Captura de Localidades SAP</b><tr>"
															+"<td colspan=3 align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='cap_sap' value='Capturar' onclick='captura_sap("+contador+",\"captura\")' >");
															%>
																<!--//hay que agregar esto en el boton <%=addsap%>-->
															<%
															out.println ("<tr><td><br>");
															out.println("<tr><td colspan=3 class=c align='center'><b>2.-Relacionar a:</b><tr>"
															+"<td align='center'><input "+addsap+" style='font-weight:bold' type='button' class='boton' id='rel_loc' value='Localidad' onclick='opener.regaddrelloc("+gid+",31)' >");
															break;
											}
									case "Sin":
									case "Otr":
											//--
											break;
								}

								%>
									<!--//hay que agregar esto en los boton <%=addsap%>-->
								<tr>
								<td><br>
								<tr>
								</table></table>
								</form>
								</body>
								<script language="javascript">
								valor=0;
								function captura_sap (valor,opcion) {
								if(valor==1){
									ventana = window.open('http://'+location.host.substr(0,(location.host.length-5))+':8888/catalogos2/loc_sigma/loc-cap.php','AgregarMz','toolbar=no,Resizable=1,scrollbars=1');
									document.captura.submit();
								} else{
									//alertmsg("No hay Localidad cercana del punto seleccionado");
								}
								}

								var	lati=document.captura.lat_x.value;
								var	longi=document.captura.lon_y.value;
								var	codig=document.captura.codact.value;
								var val=document.captura.conta.value;

								/*window.onload=function(){
								if(val==1){
									if(codig==9){    //cambio de nombre se va directo 
									ventana = window.open('http://'+location.host.substr(0,(location.host.length-5))+':8888/catalogos2/loc_sigma/loc-cap.php','AgregarMz','toolbar=no,Resizable=1,scrollbars=1');
									document.captura.submit();
										}
								}
								}*/

								</script>
								</html>
								<%

				}  //else del tipo MCC/ACU

				} //else del contador =0
}catch (SQLException ex){
      out.print(ex);
  }
%>