<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*" %>

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
      <script language="javascrpt" type="text/javascript">
window.resizeTo(320,350);
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

String  gid = "",cons="",
    tipo = "",
    val = "",
    tabla = "",
    nivel = "",
    observaciones = "",
    ban = "";
    cons = request.getParameter("cons");
    gid = request.getParameter("gid");
    tipo = request.getParameter("tipo");   // tipo de la predigitalizacion Mz, poligono o punot (1,2,3)
    val = request.getParameter("val");      // val es para oc=1, reg=2, edo=3
    tabla = request.getParameter("tabla");   //tabla acu o pre
    nivel = request.getParameter("nivel");    //nivel edo=1, reg=2, oc=3
    observaciones = request.getParameter("observaciones");
    ban = request.getParameter("ban");

String  consulta="",consulta2="",salida="";
      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      String base="";
      String campo="";
      String titulo="";

    if (tabla.equals("acu")){    //en acu no hay tipo (esto solo para pre)
        base="act_cu.bcu_bd_manzana";
        switch(val){
          case "1":   //obsoc
                campo="obsoc";
                break;
           case "2":   // obsreg
                campo="obsreg";
                break;
            case "3":   // obsed
                campo="obsed";
                break;
          }
    }else if (tabla.equals("pre")){  // aqui hay tipo y val
        switch(tipo){
          case "1":   //manzana
                base="z_digmz";
                break;
          case "2":   // poligono
                base="z_digpe";
                break;
          case "3":   // punto
                base="z_digmp";
                break;
         }
         switch(val){   //es el campo de observaciones
          case "1":   //obsoc
                campo="obsoc";
                break;
           case "2":   // obsreg
                campo="obsreg";
                break;
            case "3":   // obsed
                campo="obsed";
                break;
          }
     }

String campoused="";
String campous="";
if (campo.equals("obsoc")){campoused="usoc";campous="(select nombre from usuarios where cons=usoc)";
}else if (campo.equals("obsreg")){campoused="usreg";campous="(select nombre from usuarios where cons=usreg)";
}else if (campo.equals("obsed") && tabla.equals("pre")){campoused="us";campous="(select nombre from usuarios where cons=us)";
}else if (campo.equals("obsed") && (!(tabla.equals("pre")))){campoused="usr_add";campous="(select nombre from usuarios where cons=to_number('0'||usr_add,'9999999'))";}


      if (ban!=null && observaciones!=null){
        if (ban.equals("1")){
              observaciones=observaciones.replace("'","");
              //consulta2="update "+base+" set "+campo+"='"+observaciones+"' where gid="+gid;
                 consulta2="update "+base+" set "+campo+"='"+observaciones+"',"+campoused+"="+cons+" where gid="+gid;
              out.println(consulta2);
              ////////////////////////////
                str.executeUpdate( consulta2 );
          salida="<script>window.close();</script>";
        }
      }
    //consulta ="select "+campo+" from "+base+" where gid="+gid;
    consulta ="select "+campo+","+campous+" from "+base+" where gid="+gid;

    String obs="",usuaobs="";

            //out.println(consulta);


    rs = str.executeQuery( consulta );
    while(rs.next()){
        if (rs.getString(1) != null){obs=rs.getString(1);}
        if (rs.getString(2) != null){usuaobs=rs.getString(2);}
    }

out.println("<table border=1 align=center><tr><th class='n'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OBSERVACIONES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>");

    out.println(titulo);


out.println("<tr><td class='c'>");
out.println ("<form action=\"verobsvalpre_acu.jsp\" method=\"post\" name=\"enviar\">");

 if (tabla.equals("acu")){
          if ((nivel.equals("3") && val.equals("1") ) || (nivel.equals("1") && val.equals("3") )){  //nivel oc y boton oc
            out.println ("<textarea name=observaciones rows='5'>");
            out.println(obs+"</textarea><br><center><input class=boton type=submit value=' Enviar '><input type='hidden' value=1 name=ban><input type='hidden' value="+nivel+" name=nivel><input type='hidden' value="+gid+" name=gid><input type='hidden' value="+tipo+" name=tipo><input type='hidden' value="+cons+" name=cons><input type='hidden' value="+val+" name=val><input type='hidden' value="+tabla+" name=tabla></form><br></center>");
          }else{
            out.println(obs+"<br><br>");
          }
 }else{
          if ((nivel.equals("3") && val.equals("1") ) || (nivel.equals("1") && val.equals("3") )){  //nivel oc y boton oc
            out.println ("<textarea name=observaciones rows='5'>");
            out.println(obs+"</textarea><br><center><input class=boton type=submit value=' Enviar '><input type='hidden' value=1 name=ban><input type='hidden' value="+nivel+" name=nivel><input type='hidden' value="+gid+" name=gid><input type='hidden' value="+tipo+" name=tipo><input type='hidden' value="+cons+" name=cons><input type='hidden' value="+val+" name=val><input type='hidden' value="+tabla+" name=tabla></form><br></center>");
          }else{
            out.println(obs+"<br><br>");
     }
}






out.println("</table>"+salida);
out.println("<br><font class=n><b>USUARIO:</b> "+usuaobs+"</font>");

//}//try

/*    catch (SQLException ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion de SQL: "+ex.getMessage()+" !\");");
      out.println("</script>");
    }

    catch(Exception ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion: "+ex.getMessage()+" !\");");
      out.println("</script>");
    }
*/
%>
</body>
</html>