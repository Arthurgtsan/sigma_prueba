<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%
float c1 = Float.parseFloat(request.getParameter("c1")),
        c2 = Float.parseFloat(request.getParameter("c2")),
        c3 = Float.parseFloat(request.getParameter("c3")),
        c4 = Float.parseFloat(request.getParameter("c4"));
String consulta= "",
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
      consulta = "select ST_AsText(ST_Transform(ST_GeomFromText('POINT("+c1+" "+c2+")',3857),4326)) as punto1,"
              + "ST_AsText(ST_Transform(ST_GeomFromText('POINT("+c3+" "+c4+")',3857),4326)) as punto2";
      rs = str.executeQuery( consulta );
	while(rs.next()){
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
            out.println ("<meta HTTP-EQUIV='Refresh' CONTENT='0; URL=http://gaia.inegi.org.mx/mdm5/viewer.html?tema=catentmunloc&clon="+punto1+"&clat="+punto2+"&clon2="+punto3+"&clat2="+punto4+"'>");
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

 