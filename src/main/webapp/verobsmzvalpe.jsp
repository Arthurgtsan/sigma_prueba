<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.*" %>
<%@ page import="java.io.*" %>

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
      <script language="javascrpt" type="text/javascript">
window.resizeTo(320,320);
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
//try {
  HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();

String  gid = "",
    tipo = "",
    tipote = "",
    nivel = "",
    observaciones = "",
    ban = "";
        FileItemFactory file_factory = new DiskFileItemFactory();
        /*ServletFileUpload esta clase convierte los input file a FileItem*/
        ServletFileUpload servlet_up = new ServletFileUpload(file_factory);
        /*sacando los FileItem del ServletFileUpload en una lista */
        List items=new ArrayList<String>();

if (request.getMethod().equals("GET")){

    gid = request.getParameter("gid");
    tipo = request.getParameter("tipo");
    tipote = request.getParameter("tipote");
    nivel = request.getParameter("nivel");
    observaciones = request.getParameter("observaciones");
    ban = request.getParameter("ban");

}else{
        items = servlet_up.parseRequest(request);
        for(int i=0;i<items.size();i++){
            /*FileItem representa un archivo en memoria que puede ser pasado al disco duro*/
            FileItem item = (FileItem) items.get(i);
            /*item.isFormField() false=input file; true=text field*/
             if (item.isFormField()){
                switch (item.getFieldName()){

                case "gid": gid = item.getString();break;
                case "tipo": tipo = item.getString();break;
                case "tipote": tipote = item.getString();break;
                case "nivel": nivel = item.getString();break;
                case "observaciones": observaciones = item.getString();break;
                case "ban": ban = item.getString();break;
              }
        }
    }
}



String  consulta="",consulta2="",salida="";
      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      String tipte="";
      String campo="";
      String titulo="";
      if (tipote.equals("1")){tipte="edit_ploc.edit_agebu";}
      if (tipote.equals("2")){tipte="edit_ploc.edit_locr";}
      if (tipote.equals("3")){tipte="edit_ploc.edit_pe";}
      if (tipo.equals("O")){campo="obsoc";titulo="Oficinas Centrales";}
      if (tipo.equals("R")){campo="obsre";titulo="Regional";}
      if (tipo.equals("E")){campo="obsed";titulo="Estatal";}

      if (ban!=null && observaciones!=null){
        if (ban.equals("1")){
              observaciones=observaciones.replace("'","");
              consulta2="update "+tipte+" set "+campo+"='"+observaciones+"' where gid="+gid;
            //out.println(consulta2);
              /*
              if (nivel.equals("1") && tipo.equals("E")){  //estatal / sube archivo si agrego algo
                    for(int i=0;i<items.size();i++){
                        FileItem item = (FileItem) items.get(i);
                        if (! item.isFormField()){
                            if (!(FilenameUtils.getName(item.getName())).equals("")){
                                String nom= item.getName();
                                String ext= "."+FilenameUtils.getExtension(nom).toLowerCase();
                                nom = gid+ext;
                                File archivo_server = new File("D:/Sitio/Tomcat/webapps/openlayers/imageste/"+nom);
                                item.write(archivo_server);
                                consulta2="update "+tipte+" set "+campo+"='"+observaciones+"' where gid="+gid;
                            }
                        }
                    }
                }
                */
                str.executeUpdate( consulta2 );
          salida="<script>window.close();</script>";
        }
      }
    consulta ="select "+campo+" from "+tipte+" where gid="+gid;

    String obs="";
    String jpg="";
    rs = str.executeQuery( consulta );
    while(rs.next()){
        if (rs.getString(1) != null){obs=rs.getString(1);}
    }
out.println("<table border=1 align=center><tr><th class='n'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OBSERVACIONES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>");

          out.println(titulo);


out.println("<tr><td class='c'>");
out.println ("<form enctype='multipart/form-data' action=\"verobsmzvalpe.jsp\" method=\"post\" name=\"enviar\">");
  if (nivel.equals("2") && tipo.equals("R")){  //regional
    out.println ("<textarea name=observaciones rows='5'>");
    out.println(obs+"</textarea><br><center><input class=boton type=submit value=' Enviar '><input type='hidden' value=1 name=ban><input type='hidden' value="+nivel+" name=nivel><input type='hidden' value="+gid+" name=gid><input type='hidden' value="+tipo+" name=tipo><input type='hidden' value="+tipote+" name=tipote></form><br></center>");
  }else if (nivel.equals("3") && tipo.equals("O")){  //oc
    out.println ("<textarea name=observaciones rows='5'>");
    out.println(obs+"</textarea><br><center><input class=boton type=submit value=' Enviar '><input type='hidden' value=1 name=ban><input type='hidden' value="+nivel+" name=nivel><input type='hidden' value="+gid+" name=gid><input type='hidden' value="+tipo+" name=tipo><input type='hidden' value="+tipote+" name=tipote></form><br></center>");
}else if (nivel.equals("1") && tipo.equals("E")){  //estatal
    out.println ("<textarea name=observaciones rows='5'>");
    out.println(obs+"</textarea><br><center><input class=boton type=submit value=' Enviar '><input type='hidden' value=1 name=ban><input type='hidden' value="+nivel+" name=nivel><input type='hidden' value="+gid+" name=gid><input type='hidden' value="+tipo+" name=tipo><input type='hidden' value="+tipote+" name=tipote><br></center>");
    out.println("</table><br><center><font class='n'>Testigo:</font><br><input name='uploadedfile' type='file' class='boton' value='imagen'></form></center>");
  }else{
    out.println(obs+"<br><br>");
  }

out.println("</table>"+salida);
%>
</body>
</html>