<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-Q856GDCQ02"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-Q856GDCQ02');
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

  </head>
<body>

<%
int n=0;
int n1=0;
String  ent = "",regid = "",
        loc = request.getParameter("loc"),
    pass = request.getParameter("pass"),
    ban = request.getParameter("ban"),
         consulta = "",
     consultapas = "",
         salida1 = "",
         salida2 = "",
         salida3 = "",
         salida4 = "",
         salida5 = "",
        salida6 = "",
         select="",
         select1="",select2="",
         st = "",
         filent="",
         filtipo="",
         filcgo="",
         filfe1="",
         filfe2="",filerr="",filerr1="",filerr2="", filerrq="",
         where="",
         obs="",observa="",lobs="",obs1="";
HttpSession sesion = request.getSession(true);
if ((sesion != null && !sesion.isNew())) {
        //out.println("LA SESION SIGUE ACTIVA");


String remotehost  = session.getAttribute("remotehost").toString();
String regionalid  = session.getAttribute("regionalid").toString();


String  id = request.getParameter("id");
consulta="select oid,cgo_act,fact,tipo_ant,clave1,mov_ant,tipo_act,clave2,mov_act,obs,vreg,voc,motivo,0,0,img,usuario,fdg,correo,tipte,obsoc,obsre,obsed,jpg from v_te_mza where fact=(select max(fact) from v_te_mza where usuario='"+id+"') and usuario='"+id+"'";
// hacer la consulta con el max hr y que todos se parezcan del mismo usuario

      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      rs = str.executeQuery( consulta );
  out.println( "<center><br><font class=t>Registros generados en Tabla de Equivalencia<br><br></font><table border=1><tr class=n bgcolor=#BBBBBB>");
  out.println("<th rowspan=2>&nbsp;&nbsp;CGO&nbsp;&nbsp;<th rowspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fecha/Hora&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th rowspan=2>&nbsp;Obs&nbsp;<!--<th rowspan=2>&nbsp;Motivo&nbsp;--><th colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Anterior&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th colspan=3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Actual&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        out.println( "<tr class=n bgcolor=#BBBBBB><th>&nbsp;&nbsp;TIPO&nbsp;&nbsp;<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CLAVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        out.println( "<th>&nbsp;&nbsp;MOV&nbsp;&nbsp;");
        out.println( "<th>&nbsp;&nbsp;TIPO&nbsp;&nbsp;<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CLAVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        out.println( "<th>&nbsp;&nbsp;MOV&nbsp;&nbsp;");
//out.println(consulta);
    String col="";
    String reobs="";
    String ocobs="";
    String edobs="";
    String jpg="";

int count1=0;
int count2=0;
    while(rs.next()){
      String gid=rs.getObject(1).toString();
      String cgo="";
      if (rs.getString(2) != null){
        cgo=rs.getString(2);
      }
      String cgotxt="";
      String fact=rs.getObject(3).toString().substring(0,19);
      String tipo1="";
     if (rs.getString(4) != null){
        tipo1=rs.getString(4);
      }

      String clave1=rs.getObject(5).toString();
      String mov1=rs.getObject(6).toString();
      String tipo2="";
     if (rs.getString(7) != null){
        tipo2=rs.getString(7);
      }

      String clave2=rs.getObject(8).toString();
      String mov2=rs.getObject(9).toString();
      String img="";
      if (rs.getString(16) != null){
        img=rs.getString(16);
      }else{
        img="";
      }
      String user="";
      if (rs.getString(17) != null){
        user=rs.getString(17);
      }else{
        user="";
      }
      String fdg="";
      if (rs.getString(18) != null){
        fdg=rs.getString(18);
      }else{
        fdg="";
      }
      String correo="";
      if (rs.getString(19) != null){
        correo=rs.getString(19);
      }else{
        correo="";
      }
      String tipte=rs.getString(20);
      obs="";
      lobs="";
      if (rs.getString(10) != null){
        obs=rs.getString(10);
        if (obs.length()>0){
          lobs=obs.substring(0, 1);
        }
      }
      String val=rs.getString(11);
      String valof=rs.getString(12);
      int motivo = Integer.parseInt(rs.getObject(13).toString());


   String color="";
   out.println( "<tr class=c bgcolor="+color+">");



     col="";

obs="";
      lobs="";
      if (rs.getString(10) != null){
        obs=rs.getString(10);
        if (obs.length()>0){
          lobs=obs.substring(0, 1);
        }
      }
 if (lobs.equals("X")){
        count1++;
        obs=obs.substring(1,obs.length());
        obs1=obs.replace("<br>","");
        observa="<td align=center nowrap title='FUENTE: "+img+" "+obs1+"' bgcolor=red><div id=c3"+gid+">&nbsp;&nbsp;" +
                     "<input type=button onclick='observa(\""+user+"\",\""+fdg+"\",\""+lobs+"\","+gid+",\""+obs+"\",\""+img+"\",\""+correo+"\");' value=' Ver ' class='boton' disabled>" +
                     "&nbsp;&nbsp;</div>";
       }else if (cgo.equals("F2") || cgo.equals("F3")){
        //obs=obs.substring(1,obs.length());
        obs1=obs.replace("<br>","");
        observa="<td align=center nowrap title='FUENTE: "+img+" "+obs1+"' bgcolor=yellow><div id=c3"+gid+">&nbsp;&nbsp;" +
                     "<input type=button onclick='observa(\""+user+"\",\""+fdg+"\",\""+lobs+"\","+gid+",\""+obs+"\",\""+img+"\",\""+correo+"\");' value=' Ver ' class='boton' disabled>" +
                     "&nbsp;&nbsp;</div>";
       }else{
        obs1=obs.replace("<br>","");
        observa="<td align=center nowrap title='FUENTE: "+img+" "+obs1+"'><div id=c3"+gid+">&nbsp;&nbsp;" +
                     "<input type=button onclick='observa(\""+user+"\",\""+fdg+"\",\"\","+gid+",\""+obs+"\",\""+img+"\",\""+correo+"\");' value=' Ver ' class='boton' disabled>" +
                     "&nbsp;&nbsp;</div>";
        }



            out.println("<td align=center nowrap title='"+cgotxt+"'><div id=c1"+gid+">"+cgo+"</div>");
          out.println("<td align=center nowrap><div id=c2"+gid+">"+fact+"</div>");
            out.println(observa);
          out.println("<td align=center nowrap><div id=c4"+gid+">&nbsp;&nbsp;"+tipo1+"&nbsp;&nbsp;</div>"
              + "<td align=center nowrap><div id=c5"+gid+">&nbsp;&nbsp;"+clave1+"&nbsp;&nbsp;</div>"
              + "<td align=center nowrap><div id=c6"+gid+">&nbsp;&nbsp;"+mov1+"&nbsp;&nbsp;</div>");
            out.println("<td align=center nowrap><div id=c8"+gid+">&nbsp;&nbsp;"+tipo2+"&nbsp;&nbsp;</div>"
            + "<td align=center nowrap><div id=c9"+gid+">&nbsp;&nbsp;"+clave2+"&nbsp;&nbsp;</div>"
            + "<td align=center nowrap><div id=c10"+gid+">&nbsp;&nbsp;"+mov2+"&nbsp;&nbsp;</div>");
            n++;
      }
      out.println("</table><font class=n><br>Total de Registros: "+n);
      if (count1>0){
        out.println("<br>Registros con observaciones/errores: "+n+"<br><u>Revisar en la Tabla de Equivalencia</u></font>");
      }


    rs.close();

    }else{
          out.println("<script>opener.cerrarSesion();window.close();</script>");
    }


%>
</table>
</body>
</html>
