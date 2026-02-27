<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
      <script language="javascrpt" type="text/javascript">
window.resizeTo(800,300);
</script>
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
.liga {font-size: 9pt;color: red;text-decoration: none;font-family: Arial;}
a.liga2:link {  text-decoration: none;}
a.liga2:visited { text-decoration: none;}
a.liga2:hover { text-decoration: none;}

</style>
<%
String  gid = request.getParameter("i"),ban = request.getParameter("ban");
String  tipote = request.getParameter("tipote");
String tabla="";
String funcion="";

  tabla=" te_mza_j ";
  funcion=" a_mz_modificadatosJ ";

HttpSession sesion = request.getSession(true);
String remotehost  = session.getAttribute("remotehost").toString();
String regionalid  = session.getAttribute("regionalid").toString();
String consulta="";
String resultado="";
String claves="";
try {
      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);

      if (ban.equals("1")){
          String  cgo_act = request.getParameter("cgo_act"),
          tipo_ant = request.getParameter("tipo_ant"),
          ent_ant = request.getParameter("ent_ant"),
          mun_ant = request.getParameter("mun_ant"),
          loc_ant = request.getParameter("loc_ant"),
          ageb_ant = request.getParameter("ageb_ant"),
          mza_ant = request.getParameter("mza_ant"),
          mov_ant = request.getParameter("mov_ant"),
          tipo_act = request.getParameter("tipo_act"),
          ent_act = request.getParameter("ent_act"),
          mun_act = request.getParameter("mun_act"),
          loc_act = request.getParameter("loc_act"),
          ageb_act = request.getParameter("ageb_act"),
          mza_act = request.getParameter("mza_act"),
          mov_act = request.getParameter("mov_act"),
          solo = request.getParameter("solo");
          consulta="select "+funcion+"('"+solo+"',"+gid+",'"+cgo_act+"','"+tipo_ant+"','"+ent_ant+"','"+mun_ant+"','"+loc_ant+"','"+ageb_ant+"','"+mza_ant+"','"+mov_ant+"','"+tipo_act+"','"+ent_act+"','"+mun_act+"','"+loc_act+"','"+ageb_act+"','"+mza_act+"','"+mov_act+"')";
          //out.print (consulta);
          try {
            rs = str.executeQuery( consulta );
            rs.next();
            resultado=rs.getObject(1).toString();
          } catch (SQLException ex){
              resultado="La clave de la manzana ya esta en uso!!";
    }

    }

consulta = "select cgo_act,tipo_ant,ent_ant,mun_ant,loc_ant,ageb_ant,mza_ant,mov_ant,tipo_act,ent_act,mun_act,loc_act,ageb_act,mza_act,mov_act from "+tabla+" where oid="+gid+"";
//out.print (consulta);
      rs = str.executeQuery( consulta );
      rs.next();

      String s1=rs.getObject(1).toString();
      String s2=rs.getObject(2).toString();
      String s3=rs.getObject(3).toString();
      String s4=rs.getObject(4).toString();
      String s5=rs.getObject(5).toString();
      String s6=rs.getObject(6).toString();
      String s7=rs.getObject(7).toString();
      String s8=rs.getObject(8).toString();
      String s9=rs.getObject(9).toString();
      String s10=rs.getObject(10).toString();
      String s11=rs.getObject(11).toString();
      String s12=rs.getObject(12).toString();
      String s13=rs.getObject(13).toString();
      String s14=rs.getObject(14).toString();
      String s15=rs.getObject(15).toString();

      claves=s2+s3+s4+s5+s6+s7+s9+s10+s11+s12+s13+s14;

%>
<script>
function carga(){
  ban='<% out.print(ban); %>';
  if (ban==1){
    setTimeout(function(){ document.getElementById('letrero').innerHTML = "" }, 5000);
  }


}
function envia(){
  clave1='<% out.print(claves); %>';
  ent1='<% out.print(s2+s3+s4+s5+s6+s7+s8); %>';
  ent2='<% out.print(s9+s10+s11+s12+s13+s14+s15); %>';
  clave2=document.enviar.tipo_ant.value+document.enviar.ent_ant.value+document.enviar.mun_ant.value+document.enviar.loc_ant.value+document.enviar.ageb_ant.value+document.enviar.mza_ant.value+document.enviar.tipo_act.value+document.enviar.ent_act.value+document.enviar.mun_act.value+document.enviar.loc_act.value+document.enviar.ageb_act.value+document.enviar.mza_act.value;
  //alert(ent1);alert(ent2);
  entloc1=document.enviar.tipo_ant.value+document.enviar.ent_ant.value+document.enviar.mun_ant.value+document.enviar.loc_ant.value+document.enviar.ageb_ant.value+document.enviar.mza_ant.value+document.enviar.mov_ant.value;
  entloc2=document.enviar.tipo_act.value+document.enviar.ent_act.value+document.enviar.mun_act.value+document.enviar.loc_act.value+document.enviar.ageb_act.value+document.enviar.mza_act.value+document.enviar.mov_act.value;
  if (document.enviar.solo.checked==false){
    if ((ent1=='0000000000000-00000' && ent1!=entloc1) || (ent2=='0000000000000-00000' && ent2!=entloc2)){
      alert ('OJO, NO puedes afectar catalogo cambiando clave en CEROS!');
      return false;
    }
  }
    if (clave1!=clave2){
    var mensaje='';
    if (document.enviar.solo.checked){
      mensaje='Solo cambiaras este registro de la tabla de equivalencia, sin afectar catalogo!';
    }else{
      mensaje='OJO, estas seleccionando afectar a catalogo y tablas de equivalencia!';
    }
      var r = confirm(mensaje);
        if (r == true) {
                document.enviar.submit();
        } else {
            return false;
        }
  }
  document.enviar.submit();
}

</script>
 </head>
<body onload="carga();">
<%


out.println( "<form action=\"tem_cambiaJ.jsp\" method=\"post\" name=\"enviar\"><center><font class=t>Modificacion de tabla equivalencia de manzana</font><br>");
out.println("<br><input class='boton' name='solo' type='checkbox' checked><b class=n>Modificar solo este registro de tabla de equivalencia</b><br><br>");
out.println("<table border=1><tr class=n bgcolor=#BBBBBB>");
out.println("<th rowspan=2>&nbsp;&nbsp;CGO&nbsp;&nbsp;<th rowspan=2>&nbsp;&nbsp;&nbsp;<th colspan=7>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Anterior&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th rowspan=2>&nbsp;&nbsp;&nbsp;<th colspan=7>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Actual&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
out.println( "<tr class=n bgcolor=#BBBBBB><th>&nbsp;&nbsp;TIPO&nbsp;&nbsp;<th>&nbsp;ENT&nbsp;<th>&nbsp;MUN&nbsp;<th>&nbsp;LOC&nbsp;<th>&nbsp;AGEB&nbsp;<th>&nbsp;MZA&nbsp;<th>&nbsp;&nbsp;MOV&nbsp;&nbsp;");
out.println( "<th>&nbsp;&nbsp;TIPO&nbsp;&nbsp;<th>&nbsp;ENT&nbsp;<th>&nbsp;MUN&nbsp;<th>&nbsp;LOC&nbsp;<th>&nbsp;AGEB&nbsp;<th>&nbsp;MZA&nbsp;<th>&nbsp;&nbsp;MOV&nbsp;&nbsp;");

out.println("<tr>");
out.println("<td align=center class=boton>"+s1);
      out.println("<td>&nbsp;&nbsp;&nbsp;");

  out.println("<td align=center class=boton>"+s2);
out.println("<td align=center class=boton>"+s3);
out.println("<td align=center class=boton>"+s4);
out.println("<td align=center class=boton>"+s5);
out.println("<td align=center class=boton>"+s6);
out.println("<td align=center class=boton>"+s7);
out.println("<td align=center class=boton>"+s8);
      out.println("<td>&nbsp;&nbsp;&nbsp;");

  out.println("<td align=center class=boton>"+s9);

  out.println("<td align=center class=boton>"+s10);
  out.println("<td align=center class=boton>"+s11);
  out.println("<td align=center class=boton>"+s12);

out.println("<td align=center><input class=boton type=text size=3 maxlength=5 name=ageb_act value='"+s13+"'>");
out.println( "<td align=center><input class=boton type=text size=2 maxlength=3 name=mza_act value='"+s14+"'>");
  out.println("<td align=center class=boton>"+s15);

out.println("<input type=hidden name=cgo_act value='"+s1+"'>");
out.println("<input type=hidden name=tipo_ant value='"+s2+"'>");
out.println("<input type=hidden name=ent_ant value='"+s3+"'>");
out.println("<input type=hidden name=mun_ant value='"+s4+"'>");
out.println("<input type=hidden name=loc_ant value='"+s5+"'>");
out.println("<input type=hidden name=ageb_ant value='"+s6+"'>");
out.println("<input type=hidden name=mza_ant value='"+s7+"'>");
out.println("<input type=hidden name=mov_ant value='"+s8+"'>");
out.println("<input type=hidden name=tipo_act value='"+s9+"'>");
out.println("<input type=hidden name=ent_act value='"+s10+"'>");
out.println("<input type=hidden name=mun_act value='"+s11+"'>");
out.println("<input type=hidden name=loc_act value='"+s12+"'>");
out.println("<input type=hidden name=mov_act value='"+s15+"'>");


out.println("</table></center><input type=hidden name=ban value=1><input type=hidden name=i value="+gid+"><input type=hidden name=tipote value="+tipote+"><br><br>");
out.println ("<center><input class='boton' type='button' onClick='envia();' value=' Actualizar tabla de equivalencia '></center><form>");

if (ban.equals("1")){
  if (resultado.equals("1")){
    out.println("<div align='center' id='letrero' style='relative:absolute;visibility:visible;'><font color=blue class=n><b>Actualizado</b></font></div>");
  }else{
    out.println("<div align='center' id='letrero' style='relative:absolute;visibility:visible;'><font color=red class=n><b>"+resultado+"</b></font></div>");
}
}

}//try

    catch (SQLException ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion de SQL: "+ex.getMessage()+" !\");");
      out.println("</script>");
    }

    catch(Exception ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion: "+ex.getMessage()+" !\");");
      out.println("</script>");
    }


%>
</body>
</html>