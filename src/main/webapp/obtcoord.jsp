<%@ page import="java.io.*" %>
<%
String  ent = request.getParameter("ent");
StringBuffer sb = new StringBuffer(); 
try {
    String nombre = "D:\\Sitio\\apps\\catalogos\\temp\\"+ent+"coord";
    File file = new File(nombre);
    String line = null;
    BufferedReader br = new BufferedReader(new FileReader(file));
    while ((line = br.readLine()) != null) {
         sb.append(line);
       }
    br.close();
    out.println(sb);
    }
    catch(Exception ex){
      out.println("1");
    }
%>