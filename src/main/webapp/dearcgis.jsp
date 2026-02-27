<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.security.MessageDigest" %>

<%
float c1 = Float.parseFloat(request.getParameter("c1")),
        c2 = Float.parseFloat(request.getParameter("c2")),
        c3 = Float.parseFloat(request.getParameter("c3")),
        c4 = Float.parseFloat(request.getParameter("c4"));
String consulta= "",url="",
        punto="",
        punto1="",
        punto2="",
        punto3="",
        punto4="";
int pos=0;
try {
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
      consulta = "select ST_AsText(ST_Transform(ST_GeomFromText('POINT("+c1+" "+c2+")',32800),3857)) as punto1,"
              + "ST_AsText(ST_Transform(ST_GeomFromText('POINT("+c3+" "+c4+")',32800),3857)) as punto2";
      rs = str.executeQuery( consulta );
  while(rs.next()){

    String original = "DEARCGIS";
    MessageDigest md = MessageDigest.getInstance("MD5");
    md.update(original.getBytes());
    byte[] digest = md.digest();
    StringBuffer sb = new StringBuffer();
    for (byte b : digest) {
      sb.append(String.format("%02x", b & 0xff));
    }
            String s1=rs.getObject(1).toString();
            String s2=rs.getObject(2).toString();
            punto = s1.replace("POINT(", "");
            punto = punto.replace(")", "");
            pos = punto.indexOf(" ", -1);
            punto1 = punto.trim().substring(0, pos);
            punto2 = punto.trim().substring(pos,punto.length());
            punto = s2.replace("POINT(", "");
            punto = punto.replace(")", "");
            pos = punto.indexOf(" ", -1);
            punto3 = punto.trim().substring(0, pos);
            punto4 = punto.trim().substring(pos,punto.length());
            url = "http://"+request.getServerName()+":8070/openlayers/index.jsp?sts=1&ban=1&st=AMBAS&capa=99&c1="+punto1+"&c2="+punto2+"&c3="+punto3+"&c4="+punto4+"&password="+sb.toString()+"&cat=X";
            out.println ("<meta HTTP-EQUIV='Refresh' CONTENT='0; URL="+url+"'>");
        }
    }
   catch (SQLException ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion de SQL: "+ex.getMessage().substring(0, ex.getMessage().length()-1)+" !\");");
      out.println("</script>");
    }

    catch(Exception ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion: "+ex.getMessage().substring(0, ex.getMessage().length()-1)+" !\");");
      out.println("</script>");
    }
 
%>

 