
<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%@page import="java.io.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
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

<%

String cmd="";
String expor1="";
String c="";
String t="";

try {
c = request.getParameter("c");
t = request.getParameter("t");
int nban=0;
int ran=0;
//out.println( c );
c = c.replace("*", "'");
c = c.replace("$", "%");
c = c.replace("corchete1","[");
c = c.replace("corchete2","]");


Random num = new Random();

ran = num.nextInt(100000);
String nom="exp"+ran+".dbf";
String nom1="exp"+ran+".prj";
String nom2="exp"+ran+".shx";
String nom3="exp"+ran+".shp";
HttpSession sesion = request.getSession(true);
String regionalid  = session.getAttribute("regionalid").toString();
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();

cmd="";
expor1="";

//out.println(c);

if (t!=null){
  if (t.equals("shape")){
      out.println("<script>window.resizeTo(400,300);</script><body>");
      cmd ="D:\\Sitio\\PostgreSQL\\9.2\\bin\\pgsql2shp -f D:\\Sitio\\apps\\catalogos\\temp\\"+nom+" -h 10.153.3.25 -p 5434 -P actcar -u actcar actcargeo10 \""+c+"\"";
     expor1 = "<br><br><a href='http://"+request.getServerName()+":8888/catalogos/temp/"+nom+"'>Descargar DBF</a>";
     expor1 += "<br><a href='http://"+request.getServerName()+":8888/catalogos/temp/"+nom1+"'>Descargar PRJ</a>";
     expor1 += "<br><a href='http://"+request.getServerName()+":8888/catalogos/temp/"+nom2+"'>Descargar SHX</a>";
     expor1 += "<br><a href='http://"+request.getServerName()+":8888/catalogos/temp/"+nom3+"'>Descargar SHP</a>";
  }else{
      out.println("<script>window.resizeTo(400,200);</script><body>");
    //cmd="D:\\Sitio\\PostgreSQL\\9.2\\bin\\psql -h 10.153.3.25 -p 5434 -U actcar -d actcargeo10 -p 5432 -c \"\\Copy ("+c+") To 'D:/Sitio/apps/catalogos/temp/"+nom+"' With CSV header force quote *\"";
    cmd ="D:\\Sitio\\PostgreSQL\\9.2\\bin\\pgsql2shp -f D:\\Sitio\\apps\\catalogos\\temp\\"+nom+" -h 10.153.3.25 -p 5434 -P actcar -u actcar actcargeo10 \""+c+"\"";
    expor1 = "<br><br><a href='http://"+request.getServerName()+":8888/catalogos/temp/"+nom+"'>Descargar DBF</a>";
  }
}else{
    out.println("<script>window.resizeTo(400,200);</script><body>");
  //cmd="D:\\Sitio\\PostgreSQL\\9.2\\bin\\psql -h l-appwebmd1 -U arcgis -d "+hostbd+" -p 5434 -c \"\\Copy ("+c+") To 'D:/Sitio/apps/catalogos/temp/"+nom+"' With CSV header force quote *\"";
  cmd ="D:\\Sitio\\PostgreSQL\\9.2\\bin\\pgsql2shp -f D:\\Sitio\\apps\\catalogos\\temp\\"+nom+" -h "+remotehostbd+" -p 5434 -P actcar -u actcar "+hostbd+" \""+c+"\"";
  expor1 = "<br><br><a href='http://"+request.getServerName()+":8888/catalogos/temp/"+nom+"'>Descargar DBF</a>";
}
  expor1 += "<br><br>*Boton derecho \"Guardar enlace como...\"";



out.print("<br><center><font class=c>Exportando...</font>");
//out.flush();
//out.println(cmd);

    String sFichero="";
    //out.println(f1);
    //out.println(sexec);
    Runtime runtime = Runtime.getRuntime();
    Process exec = runtime.exec(cmd);
    int i = exec.waitFor();
    sFichero = "D:\\Sitio\\apps\\catalogos\\temp\\"+nom;
    File fichero = new File(sFichero);
    File file=new File(sFichero);
    if (file.exists()){
      out.println ("<font class=c>"+expor1+"</font>");
    }else{
      out.println ("<br><br><font class=c>Falta informacion</font>");
    }
  }
    catch(Exception ex){
        out.println (ex);
        out.println(cmd);
    }
finally{
//out.println(expor1);
}

%>
</body></html>