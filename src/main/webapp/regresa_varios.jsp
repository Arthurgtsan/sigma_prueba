<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
<script language="javascrpt" type="text/javascript">
window.resizeTo(600,400);

function callprogress(vValor){
 document.getElementById("getprogress").innerHTML = vValor;
 document.getElementById("getProgressBarFill").innerHTML = '<div class="ProgressBarFill" style="width: '+vValor+'%;">&nbsp;</div>';
}

</script>
<style type="text/css">
/* Ahora creo el estilo que hara que aparesca el porcentanje y relleno del mismoo*/
      .ProgressBar     { width: 16em; border: 1px solid black; background: #eef; height: 1.25em; display: block; }
      .ProgressBarText { position: absolute; font-size: 1em; width: 16em; text-align: center; font-weight: normal; }
      .ProgressBarFill { height: 100%; background: #aae; display: block; overflow: visible; }

    </style>
  </head>
<body>
<%
String  tipo = request.getParameter("tipo");
String  clave = request.getParameter("clave");
String  pass = request.getParameter("pass"),txt="",consulta0="",consulta = "";
String  consulta1="",consulta3="";
        consulta = "select nivel from usuarios where md5(password) = '"+pass+"';";
int nban=0;

//out.println( consulta );

out.println("<center><br>Completado:<br><br><div class='ProgressBar'>");
out.println("<div class='ProgressBarText'><span id='getprogress'>0</span>&nbsp;% completado</div>");
out.println("<div id='getProgressBarFill'></div>");
out.println("</div></center>");
try {
      ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      conexion = DriverManager.getConnection("jdbc:postgresql://10.153.3.25:5434/actcargeo10","actcar","actcar");
      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      rs = str.executeQuery( consulta );
      rs.next();
      String s1=rs.getObject(1).toString();
      //out.println("S1"+s1);
      if (s1.equals("3") || s1.equals("1")){
          clave = clave.replace("*", "''");
          clave = clave.replace("\"", "");
          clave = clave.replace("%", "");
          clave = clave.replace("$", "%");
          if (Integer.parseInt(tipo) == 1){
            consulta0="select * from a_regresa_coord('"+clave+"',"+tipo+");";
          }else{
            consulta0="select * from a_regresa_coord('"+clave+"',"+tipo+");";
          }
          //out.println ("<br>"+consulta0);

          ResultSet rs2 = null;
          rs2 = str.executeQuery( consulta0 );
          rs2.next();
          String s2=rs2.getObject(1).toString();
          out.println("<script>callprogress(100)</script>");
          out.flush();
          if (Integer.parseInt(tipo)==0){
             txt=" No hay cambios que realizar! ";
          }else{
             txt=" Se realizaron correctamente los cambios! (Total: "+s2+")";
          }
          rs2.close();

      }else{
          txt=" No tienes privilegios para realizar cambios en la base principal! ";
      }
      rs.close();
      str.close();
      conexion.close();
    }
    catch (SQLException ex){
      out.println("<script>");
      out.println("  alert(\'Se genero la expresion de SQL: "+ex+" !\');");
      //out.println("  alert(\'No hay cambios que realizar!\');");
      out.println("</script>");
    }

    catch(Exception ex){
      out.println("<script>");
      out.println("  alert(\'Se genero la expresion: "+ex+" !\');");
      out.println("</script>");
    }

    if (!(txt.isEmpty())){
           out.println("<br><br><center>"+txt+"</center>");
    }
%>
<script>
//setTimeout(function(){window.close()}, 20000);

</script>
</body>
</html>