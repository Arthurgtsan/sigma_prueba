<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
String  id = request.getParameter("id");
String  cgo = request.getParameter("cgo");
String  clave = request.getParameter("clave");
String  val = request.getParameter("val");
String  tipote = request.getParameter("tipote");
String consulta="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
String cve="";
cve=clave.substring(14,17);
//out.println(cve);
try {
//if (tipote.equals("TEC")){
if (cve.equals("800")){
  if (val.equals("0")){  //referencia anterior
      consulta = "select ST_AsText(st_transform(the_geom,3857)) from cat_cd_base where cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza=replace('"+clave+"','-','') order by gid  limit 1 ";
    }else{  //referencia actual
      consulta = "select ST_AsText(st_transform(the_geom,3857)) from cat_cd where cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza='"+clave+"' order by gid desc limit 1 ";
    }
}else{
	if (cgo.length()==2){  //geometrico
		if (val.equals("0")){  //referencia anterior
			consulta = "select ST_AsText(st_transform(the_geom_ant,3857)) from te_mza_coord_fr where oid="+id;
		}else{	//referencia actual
			consulta = "select ST_AsText(st_transform(the_geom_act,3857)) from te_mza_coord_fr where oid="+id;
		}
	}else{   //nivel catalogo
		consulta = "select ST_AsText(st_transform(the_geom,3857)) from cat_manz where cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza='"+clave+"' order by gid desc limit 1 ";	
	}
}
      ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    rs = str.executeQuery( consulta );
	rs.next();
    out.print(rs.getObject(1).toString());
    str.close();
    conexion.close();
    }
    catch (SQLException ex){
      out.print("1");
  }
      catch(Exception ex){
        out.print("1");
   }
%>