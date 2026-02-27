<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%String directorio = request.getSession().getServletContext().getRealPath("/bitacora_mcc/");
 File fichero = new File(directorio); 
String[] ficheros = fichero.list(); // sacamos cada uno de los archivos dentro del directorio
for (int i = 0; i < ficheros.length; i++) { //los recorremos
 /*cortamos el nombre del archivo por el punto para conocer la extension del archivo (xls, o xlsx) */
String elementos[] = ficheros[i].split("\\.");
String extension = elementos[elementos.length-1];
if(extension.equals("html")){
out.println(i+".- <a href='"+ficheros[i]+"' target='_blank'>"+ficheros[i]+"</a><br>");

}
}
%>
