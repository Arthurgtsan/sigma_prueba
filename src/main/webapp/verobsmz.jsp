<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
      <script language="javascrpt" type="text/javascript">
window.resizeTo(300,300);

 function abre(gid){

ventana = window.open('http://dc046068asdggma.inegi.gob.mx:8888/mnv/verificacion_sigma_silavac.php?id='+gid,'id','toolbar=no,Resizable=1,scrollbars=1, width=650,height=200');  
ventana.focus();
}

</script>
<style type="text/css">
table {
  border-collapse: collapse;
}
.t{font-size: 12pt; font-family: Arial; font-weight: bold; color: #000000;} 
.c{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: normal;}
.n{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: bold;}
.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}

</style>
 </head>
<body>
<%
  HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
String  obs = request.getParameter("obs"),
		gid = request.getParameter("gid"),
	    //cod = request.getParameter("cod"),
      fdg = request.getParameter("fdg"),
      user = request.getParameter("user"),
		img = request.getParameter("img");
String img1="";
if (img.equals("OR")) {
	img1="ORTOFOTO";
}else if (img.equals("S5")) {
	img1="SPOT 5";
}else if (img.equals("S6")) {
	img1="SPOT 6";
}else if (img.equals("GO")) {
  img1="GOOGLE";
}else if (img.equals("DG")) {
  img1="DIGITAL GLOBE";
}else if (img.equals("OA")) {
  img1="ONEATLAS";
}else if (img.equals("ES")) {
  img1="ESRI";
}else if (img.equals("MA")) {
  img1="MODIFICACION MANUAL";
}else if (img.equals("BI")) {
  img1="BING MAPS";
}else if (img.equals("D2")) {
  img1="SIDAISAR";
}else{
img1="SIN FUENTE";
}



String  consulta="",consulta2="",salida="",correo="",usuario="";
      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);

consulta="select nombre,correo from usuarios where cons="+user;
rs = str.executeQuery( consulta );
 while(rs.next()){
        user=rs.getString(1);
        correo=rs.getString(2);
    }

String bandera;


Integer indexado=obs.indexOf("SILAVAC:");
Integer psicion = obs.length();


	
out.println("<table border=1 align=center><tr><th class='n'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OBSERVACIONES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>");
if(indexado>0){
	indexado=indexado+8;
	bandera=obs.substring(indexado,psicion);
	out.println("<tr><td class='c'  onclick='abre("+bandera+")'><br><br>Id SILAVAC: <a href=''>"+bandera+"</a><br><br>");  
}else{
out.println("<tr><td class='c'>"+obs+"<br><br>");	
}


// out.println("<p onclick='abre("+gid+")'><a href=''>"+var+"</a>");   
out.println("<tr><td class='c'>FUENTE: "+img1+"");
if (img.equals("DG")) {
  out.println("<br>FECHA: "+fdg+"");
}
//if (correo==null){
  out.println("<br>USUARIO: "+user);
//}else{
//  out.println("<br>USUARIO: <a href='mailto:"+correo+"@inegi.org.mx'>"+user+"</a>");
//}

out.println("</table>");
%>
</body>
</html>