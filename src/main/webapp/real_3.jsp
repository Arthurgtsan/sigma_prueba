
<%@ page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
<script>
window.resizeTo(400,200);
window.moveTo(window.opener.screenX, window.opener.screenY);
</script>
<body>
<%
try {
out.flush();
      ResultSet rs = null;
      Class.forName("org.postgresql.Driver");
      Connection conexion = DriverManager.getConnection("jdbc:postgresql://10.152.11.44:5433/bdgeoestadistico","mgn2k","internet");
      Statement str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      String consulta0 = "select * from a_cambiar_coord()";
      out.print ("<br><table align=center><tr><td>Procesando cambios en Mapa Digital...");out.flush();
      rs = str.executeQuery( consulta0 );
      out.print ("<td>Ok!</table>");
      rs.close();
      str.close();
      conexion.close();
    }
   catch (SQLException ex){
    out.println (ex);
    }

    catch(Exception ex){
    out.println (ex);
    }


 out.print ("<script>window.opener.document.getElementById('real3').innerHTML = 'Ok!';");
 out.print ("window.close();</script>");


%>
</body>
</html>