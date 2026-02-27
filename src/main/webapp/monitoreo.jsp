<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>

<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="refresh" content="10">
    <title>
SIGMA
</title>
</head>
<script>
function nuevoAjax()
{
    /* Crea el objeto AJAX. Esta funcion es generica para cualquier utilidad de este tipo, por
    lo que se puede copiar tal como esta aqui */
    var xmlhttp=false;
    try {
        // Creacion del objeto AJAX para navegadores no IE
        xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch(e){
        try {
            // Creacion del objet AJAX para IE
            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }catch(E){
            if (!xmlhttp && typeof XMLHttpRequest!=undefined) xmlhttp=new XMLHttpRequest();
        }
    }return xmlhttp;
}


function cancel(host,pid,bd,usuario){
        var ajax=nuevoAjax();
        ajax.open("GET",'monitoreo_cancel.jsp?host='+host+'&pid='+pid+'&bd='+bd+'&usuario='+usuario, true);
         ajax.onreadystatechange=function()
        {
            if(ajax.readyState==4)  {
                /*var val=ajax.responseText;
                console.log(val)
                if (val==1){
                    console.log ("SI");
                }else{
                    console.log ("NO");
                }*/
            }
            //window.location.replace("/openlayers2/monitoreo.jsp");
            //location.reload();
        }
        ajax.send(null);
}



</script>

<link rel="stylesheet" href="menu_reporte.css" type="text/css">
<%
  out.println("<body>");
try {

/*
String consulta1 = "select * from (select 'Neatil' as serv,'Nacional' as tipo, datname,usename,query_start,state,application_name,query,pid,client_addr::text,client_hostname,'localhost' as host from pg_stat_activity";
consulta1 += " where query_start is not null and query is not null ";
consulta1 += " and state='active' ";
consulta1 += " and substring(query,1,30)!='select * from (select ''Neatil'''";
consulta1+=" union ";
*/
String consulta1 = "select distinct * from (SELECT 'BD' as serv,'TODOS' as tipo,*,'l-appwebmd1' as host FROM dblink('dbname=actcargeo1 host=l-appwebmd1 port=5434  user=actcar password=actcar', 'select datname,usename,query_start,state,application_name,query,pid,client_addr,client_hostname from pg_stat_activity  where state=''active'' and substring(query,1,14)!=''select datname''') ";
  consulta1+="t1(datname text,usename text,query_start timestamp,state text, application_name text, query text, pid integer,client_addr text,client_hostname text) ";
  consulta1+="union  SELECT 'BD' as serv,'TODOS' as tipo,*,'l-appwebmd1' as host FROM dblink('dbname=actcargeo1 host=l-appwebmd1 port=5434 user=arcgis password=arcgis',  'select datname,usename,query_start,state,application_name,query,pid,client_addr,client_hostname from pg_stat_activity where state=''active'' and substring(query,1,14)!=''select datname''') t1(datname text,usename text,query_start timestamp,state text, application_name text, query text, pid integer,client_addr text,client_hostname text))tt where query not like '%TODOS%' and client_addr is not null order by query_start asc";
 

    //out.println(consulta1);

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
      rs = str.executeQuery( consulta1 );

      out.println("<center><font class='titulo'>Monitoreo de actividad de consultas</font><br><br>");


       out.println(" <table border=1 class=table><tr class=titulo2><th>&nbsp;Servidor&nbsp;<th>&nbsp;Contiene&nbsp;<th>&nbsp;BD&nbsp;<th>&nbsp;Usuario&nbsp;<th>&nbsp;Cliente&nbsp;<th>&nbsp;Inicio de consulta&nbsp;<th>&nbsp;Segundos&nbsp;<br>&nbsp;transcurridos&nbsp;<th>&nbsp;Cancelar&nbsp;<th>&nbsp;Consulta&nbsp;");

      String t0="0",t1="0",t2="0",t3="0",t4="0",t5="0",t6="0",t7="0",t8="0",t9="0",t10="0",t11="0";
      String trans="Algo";

          Calendar calendar1 = Calendar.getInstance();
          Calendar calendar2 = Calendar.getInstance();
           int v1;
          int v2;
          int v3;
          int v4;
          int v5;
          int v6;
          long milliseconds1,milliseconds2,diff,diffSeconds;






      while(rs.next()){
        t0=rs.getObject(1).toString();
        t1=rs.getObject(2).toString();
        t2=rs.getObject(3).toString();
        t3=rs.getObject(4).toString();
        t4=rs.getObject(5).toString();
        t4=t4.substring(0,19);
        t7=rs.getObject(8).toString();
        t8=rs.getObject(9).toString();
        t9=rs.getObject(12).toString();
         if (rs.getString(10) != null){
                t10=rs.getObject(10).toString();
      }  if (rs.getString(11) != null){
                t11=rs.getObject(11).toString();
      }

          v1=Integer.parseInt(t4.substring(0,4));
          v2=Integer.parseInt(t4.substring(5,7));
          v3=Integer.parseInt(t4.substring(8,10));
          v4=Integer.parseInt(t4.substring(11,13));
          v5=Integer.parseInt(t4.substring(14,16));
          v6=Integer.parseInt(t4.substring(17,19));
          calendar1.set(v1,v2-1,v3,v4,v5,v6);
          //out.println("<br>1: "+calendar1.getTime());
          //out.println("<br>2: "+calendar2.getTime());
          milliseconds1 = calendar1.getTimeInMillis();
          milliseconds2 = calendar2.getTimeInMillis();
          diff = (milliseconds2) - (milliseconds1);
          diffSeconds = (diff / 1000);  //-3600;    //le puse -3600 porque no se porque esta mal el horario de 1 hr del server
          if (diffSeconds>20){
            out.println("<tr class=n2 bgcolor='#F78181'><td nowrap>"+t0+"<td nowrap>"+t1+"<td nowrap>"+t2+"<td nowrap>"+t3+"<td nowrap>"+t11+"<br>("+t10+")<td nowrap>"+t4+"<td nowrap>"+diffSeconds+"<td nowrap align=center>");
            out.println("<input type='Button' onClick='cancel(\""+t9+"\","+t8+",\""+t2+"\",\""+t3+"\");' value=' Cancel ("+t8+") '/><td>"+t7);
            //if (t7.length()>28){
            if (t7.length()>289){
              if ((t7.replace("\"","").substring(0,27)).equals("INSERT INTO public.cat_manz")){
                out.println("<script>");
                out.println("   setTimeout('cancel(\""+t9+"\","+t8+",\""+t2+"\")', 2000);");
                out.println("</script>");
              }
            }
          }else if (diffSeconds>10){
            out.println("<tr class=n2 bgcolor='#F3F781'><td nowrap>"+t0+"<td nowrap>"+t1+"<td nowrap>"+t2+"<td nowrap>"+t3+"<td nowrap>"+t11+"<br>("+t10+")<td nowrap>"+t4+"<td nowrap>"+diffSeconds+"<td nowrap align=center>");
            out.println("<input type='Button' onClick='cancel(\""+t9+"\","+t8+",\""+t2+"\",\""+t3+"\");' value=' Cancel ("+t8+") '/><td>"+t7);
            //if (t7.length()>28){
            if (t7.length()>289){
              if ((t7.replace("\"","").substring(0,27)).equals("INSERT INTO public.cat_manz")){
                out.println("<script>");
                out.println("   setTimeout('cancel(\""+t9+"\","+t8+",\""+t2+"\")', 2000);");
                out.println("</script>");
              }
            }
          }else{
            out.println("<tr class=n2 bgcolor='#81F79F'><td nowrap>"+t0+"<td nowrap>"+t1+"<td nowrap>"+t2+"<td nowrap>"+t3+"<td nowrap>"+t11+"<br>("+t10+")<td nowrap>"+t4+"<td nowrap>"+diffSeconds+"<td nowrap align=center>");
            out.println("<input type='Button' onClick='cancel(\""+t9+"\","+t8+",\""+t2+"\",\""+t3+"\");' value=' Cancel ("+t8+") ' disabled/><td>"+t7);
        }
      }
  out.println("</table><br><br></body>");
      str.close();
      conexion.close();

}//try

    catch (SQLException ex){
      out.println("<center>ERROR de Consulta!!</center></body><script>");
      out.println("   setTimeout('location.reload();', 5000);");
      out.println("</script>");
    }

    catch(Exception ex){
      out.println("</table><br><br><center>ERROR de Excepcion!!</center></body><script>");
      //out.println("   setTimeout('location.reload()', 5000);");
      out.println("</script>");
      out.println(ex);
    }


%>
</html>
