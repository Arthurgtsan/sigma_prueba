<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
try{
String  x = request.getParameter("x");
String  y = request.getParameter("y");
String  ent = request.getParameter("id");
String  gid = request.getParameter("gid");
String  us = request.getParameter("us");
String  c1 = request.getParameter("c1");
String  c2 = request.getParameter("c2");
String  c3 = request.getParameter("c3");
String  c4 = request.getParameter("c4");

String consulta="";
String cve_ent="";
String cve_mun="";
String bloque="";
//    select _frente_mas_cercano(3125230,'1523348.34,2107876.10');
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();

      consulta = "select _frente_mas_cercano("+gid+",'"+x+","+y+"','"+ent+"','"+c1+"','"+c2+"','"+c3+"','"+c4+"','"+us+"')";
      ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);

    //out.println(consulta);
    rs = str.executeQuery( consulta );
    rs.next();
    String fin=rs.getObject(1).toString();

    out.print(fin);
        str.close();
        conexion.close();
    }
    catch (SQLException ex){
      out.print("x");
  }
      catch(Exception ex){
        out.print("x");
   }
%>