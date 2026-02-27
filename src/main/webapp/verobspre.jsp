<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
      <script language="javascrpt" type="text/javascript">
window.resizeTo(300,300);
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
String  gid = request.getParameter("gid"),
    tipo = request.getParameter("tipo"),
    nivel = request.getParameter("nivel"),
    observaciones = request.getParameter("observaciones"),
    ban = request.getParameter("ban"),
    consulta="",consulta2="",salida="";
      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
       conexion = DriverManager.getConnection(
                                             "jdbc:postgresql://10.153.3.25:5434/actcargeo10",
                                             "actcar",
                                             "actcar"
                                            );
      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      if (ban!=null && observaciones!=null){
        if (ban.equals("1")){
          if (tipo.equals("R")){
              consulta2="update a_rep_cardig set reobs='"+observaciones+"' where gid="+gid;
          }else{
              consulta2="update a_rep_cardig set ocobs='"+observaciones+"' where gid="+gid;
          }
          str.executeUpdate( consulta2 );
          salida="<script>window.close();</script>";
        }
      }


      if (tipo.equals("R")){
          consulta ="select reobs,carta from a_rep_cardig where gid="+gid;
    }else{
          consulta ="select ocobs,carta from a_rep_cardig where gid="+gid;
  }
    rs = str.executeQuery( consulta );
    rs.next();
    String obs="";if (rs.getString(1) != null){obs=rs.getString(1);}
    String carta=rs.getString(2);
out.println("<table border=1 align=center><tr><th class='n'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OBSERVACIONES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>Carta: "+carta);
out.println("<tr><td class='c'>");
  if (nivel.equals("2") && tipo.equals("R")){  //regional
    out.println ("<form action=\"verobspre.jsp\" method=\"post\" name=\"enviar\">");
    out.println ("<textarea name=observaciones rows='5'>");
    out.println(obs+"</textarea><br><center><input class=boton type=submit value=' Enviar '><input type='hidden' value=1 name=ban><input type='hidden' value="+nivel+" name=nivel><input type='hidden' value="+gid+" name=gid><input type='hidden' value="+tipo+" name=tipo></form><br></center>");
  }else if (nivel.equals("3") && tipo.equals("O")){  //oc
    out.println ("<form action=\"verobspre.jsp\" method=\"post\" name=\"enviar\">");
    out.println ("<textarea name=observaciones rows='5'>");
    out.println(obs+"</textarea><br><center><input class=boton type=submit value=' Enviar '><input type='hidden' value=1 name=ban><input type='hidden' value="+nivel+" name=nivel><input type='hidden' value="+gid+" name=gid><input type='hidden' value="+tipo+" name=tipo></form><br></center>");

  }else{
    out.println(obs+"<br><br>");
  }

out.println("</table>"+salida);
%>
</body>
</html>