
<%@page import="java.io.*" %>
<%@page import="java.net.*" %>
<%
String  x = request.getParameter("x");
String  y = request.getParameter("y");
//String req="http://mapserver.inegi.org.mx/GeoService/elevation?lon="+x+"&lat="+y+"&res=15";
String cmd="C:/OSGeo4W64/bin/gdallocationinfo -valonly -wgs84 D:/Nacional30_R15m.tif "+x+" "+y;

try {
/*       String recv;
       String recvbuff="";
       URL jsonpage = new URL(req);
       URLConnection urlcon = jsonpage.openConnection();
       BufferedReader buffread = new BufferedReader(new InputStreamReader(urlcon.getInputStream()));

       while ((recv = buffread.readLine()) != null)
        recvbuff += recv;
       buffread.close();
       out.println(recvbuff);

*/

Runtime r = Runtime.getRuntime();
Process p = r.exec(cmd);
InputStream is = p.getInputStream();
InputStreamReader isr = new InputStreamReader(is);
BufferedReader br = new BufferedReader(isr);
String line=br.readLine();
if (line.isEmpty() || line ==""){
  out.println("0");
}else{
  out.println(line);
}
    }
    catch(Exception ex){
      out.println("x");
    }

%>
