
<%@ page import="java.io.*" %>
<%
String  ent = request.getParameter("ent");
String  x = request.getParameter("x");
String  y = request.getParameter("y");

try {
    String nombre = "D:\\Sitio\\apps\\catalogos\\temp\\"+ent+"coord";
    FileOutputStream fos = new FileOutputStream(nombre);
    PrintWriter pw = new PrintWriter(fos);
    pw.println(x+","+y);
    pw.close();
    fos.close();
    out.println("0");
    }
    catch(Exception ex){
      out.println("1");
    }

%>
