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
if (tipote.equals("TEC")){
  tabla=" te_mza_cd ";
  funcion=" a_mz_modificadatos_cd ";
}else{
  tabla=" te_mza ";
  funcion=" a_mz_modificadatos ";
}

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


out.println( "<form action=\"tem_cambia.jsp\" method=\"post\" name=\"enviar\"><center><font class=t>Modificacion de tabla equivalencia de manzana</font><br>");
out.println("<br><input class='boton' name='solo' type='checkbox' checked><b class=n>Modificar solo este registro de tabla de equivalencia</b><br><br>");
out.println("<table border=1><tr class=n bgcolor=#BBBBBB>");
out.println("<th rowspan=2>&nbsp;&nbsp;CGO&nbsp;&nbsp;<th rowspan=2>&nbsp;&nbsp;&nbsp;<th colspan=7>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Anterior&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th rowspan=2>&nbsp;&nbsp;&nbsp;<th colspan=7>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Actual&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
out.println( "<tr class=n bgcolor=#BBBBBB><th>&nbsp;&nbsp;TIPO&nbsp;&nbsp;<th>&nbsp;ENT&nbsp;<th>&nbsp;MUN&nbsp;<th>&nbsp;LOC&nbsp;<th>&nbsp;AGEB&nbsp;<th>&nbsp;MZA&nbsp;<th>&nbsp;&nbsp;MOV&nbsp;&nbsp;");
out.println( "<th>&nbsp;&nbsp;TIPO&nbsp;&nbsp;<th>&nbsp;ENT&nbsp;<th>&nbsp;MUN&nbsp;<th>&nbsp;LOC&nbsp;<th>&nbsp;AGEB&nbsp;<th>&nbsp;MZA&nbsp;<th>&nbsp;&nbsp;MOV&nbsp;&nbsp;");

out.println("<tr>");
out.println("<td><select class=boton name=cgo_act>");
  out.println("<option value='1'");if (s1.equals("1")){out.println("selected");};out.println(">1</option>");
  out.println("<option value='2'");if (s1.equals("2")){out.println("selected");};out.println(">2</option>");
  out.println("<option value='3'");if (s1.equals("3")){out.println("selected");};out.println(">3</option>");
  out.println("<option value='4'");if (s1.equals("4")){out.println("selected");};out.println(">4</option>");
  out.println("<option value='5'");if (s1.equals("5")){out.println("selected");};out.println(">5</option>");
  out.println("<option value='6'");if (s1.equals("6")){out.println("selected");};out.println(">6</option>");
  out.println("<option value='A'");if (s1.equals("A")){out.println("selected");};out.println(">A</option>");
  out.println("<option value='B'");if (s1.equals("B")){out.println("selected");};out.println(">B</option>");
  out.println("<option value='C'");if (s1.equals("C")){out.println("selected");};out.println(">C</option>");
  out.println("<option value='D'");if (s1.equals("D")){out.println("selected");};out.println(">D</option>");
  out.println("<option value='E'");if (s1.equals("E")){out.println("selected");};out.println(">E</option>");
  out.println("<option value='F'");if (s1.equals("F")){out.println("selected");};out.println(">F</option>");
  out.println("<option value='G'");if (s1.equals("G")){out.println("selected");};out.println(">G</option>");
  out.println("<option value='H'");if (s1.equals("H")){out.println("selected");};out.println(">H</option>");
  out.println("<option value='I'");if (s1.equals("I")){out.println("selected");};out.println(">I</option>");
  out.println("<option value='K'");if (s1.equals("K")){out.println("selected");};out.println(">K</option>");
  out.println("<option value='M'");if (s1.equals("M")){out.println("selected");};out.println(">M</option>");
  out.println("<option value='N'");if (s1.equals("N")){out.println("selected");};out.println(">N</option>");
  out.println("<option value='O'");if (s1.equals("O")){out.println("selected");};out.println(">O</option>");
  out.println("<option value='R'");if (s1.equals("R")){out.println("selected");};out.println(">R</option>");
  out.println("<option value='S'");if (s1.equals("S")){out.println("selected");};out.println(">S</option>");
  out.println("<option value='T'");if (s1.equals("T")){out.println("selected");};out.println(">T</option>");
  out.println("<option value='Y'");if (s1.equals("Y")){out.println("selected");};out.println(">Y</option>");
out.println("</select>");
out.println("<td>&nbsp;&nbsp;&nbsp;");
out.println("<td><select class=boton name=tipo_ant>");
  out.println("<option value='0'");if (s2.equals("0")){out.println("selected");};out.println(">0</option>");
  out.println("<option value='R'");if (s2.equals("R")){out.println("selected");};out.println(">R</option>");
  out.println("<option value='U'");if (s2.equals("U")){out.println("selected");};out.println(">U</option>");
out.println("</select>");
out.println("<td align=center><input class=boton type=text size=1 maxlength=2 name=ent_ant value='"+s3+"'>");
out.println("<td align=center><input class=boton type=text size=1 maxlength=3 name=mun_ant value='"+s4+"'>");
out.println("<td align=center><input class=boton type=text size=2 maxlength=4 name=loc_ant value='"+s5+"'>");
out.println("<td align=center><input class=boton type=text size=3 maxlength=5 name=ageb_ant value='"+s6+"'>");
out.println("<td align=center><input class=boton type=text size=2 maxlength=3 name=mza_ant value='"+s7+"'>");
out.println("<td><select class=boton name=mov_ant>");
  out.println("<option value='0'");if (s8.equals("0")){out.println("selected");};out.println(">0</option>");
  //out.println("<option value='A'");if (s8.equals("A")){out.println("selected");};out.println(">A</option>");
  out.println("<option value='B'");if (s8.equals("B")){out.println("selected");};out.println(">B</option>");
  out.println("<option value='C'");if (s8.equals("C")){out.println("selected");};out.println(">C</option>");
out.println("</select>");
out.println("<td>&nbsp;&nbsp;&nbsp;");
out.println("<td><select class=boton name=tipo_act>");
  out.println("<option value='0'");if (s9.equals("0")){out.println("selected");};out.println(">0</option>");
  out.println("<option value='R'");if (s9.equals("R")){out.println("selected");};out.println(">R</option>");
  out.println("<option value='U'");if (s9.equals("U")){out.println("selected");};out.println(">U</option>");
out.println("</select>");

out.println("<td align=center><input class=boton type=text size=1 maxlength=2 name=ent_act value='"+s10+"'>");
out.println("<td align=center><input class=boton type=text size=1 maxlength=3 name=mun_act value='"+s11+"'>");
out.println("<td align=center><input class=boton type=text size=2 maxlength=4 name=loc_act value='"+s12+"'>");
out.println("<td align=center><input class=boton type=text size=3 maxlength=5 name=ageb_act value='"+s13+"'>");
out.println( "<td align=center><input class=boton type=text size=2 maxlength=3 name=mza_act value='"+s14+"'>");
out.println("<td><select class=boton name=mov_act>");
  out.println("<option value='0'");if (s15.equals("0")){out.println("selected");};out.println(">0</option>");
  out.println("<option value='A'");if (s15.equals("A")){out.println("selected");};out.println(">A</option>");
  //out.println("<option value='B'");if (s15.equals("B")){out.println("selected");};out.println(">B</option>");
  out.println("<option value='C'");if (s15.equals("C")){out.println("selected");};out.println(">C</option>");
out.println("</select>");

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