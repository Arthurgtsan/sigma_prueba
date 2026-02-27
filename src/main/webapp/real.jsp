
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@page import="java.io.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
<script language="javascrpt" type="text/javascript">
window.resizeTo(600,400);

function callprogress(vValor){
 document.getElementById("getprogress").innerHTML = vValor;
 document.getElementById("getProgressBarFill").innerHTML = vValor+'%';
}
function callprogress1(vValor){
 document.getElementById("getprogress1").innerHTML = vValor;
 document.getElementById("getProgressBarFill1").innerHTML = vValor+'%';
}

</script>
  </head>
<body>
<%
String  tipo = request.getParameter("tipo");
String  clave = request.getParameter("clave");
String  pass = request.getParameter("pass"),txt="",consulta0="",consulta = "";
String  consulta1="",consulta3="";
        consulta = "select nivel from usuarios where md5(password) = '"+pass+"';";
int nban=0;

//out.println( consulta );
   out.println ("<br>");
try {
long time_start, time_end;
time_start = System.currentTimeMillis();
      ResultSet rs = null;
      ResultSet rs1 = null;
      Statement str = null;
      Statement str1 = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      conexion = DriverManager.getConnection("jdbc:postgresql://10.153.3.25:5434/actcargeo10","actcar","actcar");
      str =  conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      str1 = conexion.createStatement(rs1.TYPE_SCROLL_SENSITIVE, rs1.CONCUR_UPDATABLE);
      rs = str.executeQuery( consulta );
      rs.next();
      String s1=rs.getObject(1).toString();
      //out.println("S1"+s1);
      if (s1.equals("3")){
          int numero_registros=0;
          int i=1;
          int ncall=1;
          float porcentaje=0;
          clave = clave.replace("*", "''");
          clave = clave.replace("\"", "");
          clave = clave.replace("%", "");
          clave = clave.replace("$", "%");
          consulta0="select * from a_actual_coord('"+clave+"',"+tipo+");";
          //out.println ("<br>"+consulta0);
          out.flush();
          out.print ("<table><tr><td nowrap>Generando tabla de cambios...<td>");
          rs = str.executeQuery( consulta0 );
          out.flush();
          while(rs.next()){
            numero_registros= Integer.parseInt(rs.getObject(1).toString());
          }
          out.println (numero_registros+" registros!");
          out.flush();
          consulta0="select clave,lon_dec,lat_dec from temp_act_loc1 order by clave";
          out.print ("<tr><td>Generando altitud para la tabla de cambios...");
          rs = str.executeQuery( consulta0 );
          out.flush();
          String cmd="";
          out.print("<td nowrap><div><span id='getprogress'>0</span>&nbsp;%</div>");
            Runtime r ;
            Process p ;
            InputStream is ;
            InputStreamReader isr ;
            BufferedReader br ;
            String line;
            int a;
            out.flush();
            String alti="";
            String alts="";
            String ceros="";
          while(rs.next()){
            nban=1;
            cmd="C:/OSGeo4W64/bin/gdallocationinfo -valonly -wgs84 D:/Nacional30_R15m.tif "+rs.getObject(2).toString()+" "+rs.getObject(3).toString();
            r = Runtime.getRuntime();
            p = r.exec(cmd);
            is = p.getInputStream();
            isr = new InputStreamReader(is);
            br = new BufferedReader(isr);
            alts = br.readLine();
            if (alts.length()>4 || alts.equals("0") || alts.isEmpty()){
                alti="0000";
            }else if (alts.substring(0,1).equals("-")){
               alti = alts.substring(1,alts.length());
               if (alti.length()==1){
                  ceros="-00";
               }else if (alti.length()==2){
                  ceros="-0";
               }else if (alti.length()==3){
                  ceros="-";
               }
               alti = ceros + alti;
            }else{
              alti = "0000".substring(alts.length()) + alts;
            }
            consulta1="update temp_act_loc1 set altitud='"+alti+"'  where clave='"+rs.getObject(1).toString()+"';";
            str1.executeUpdate( consulta1 );
            porcentaje = i * 100 / numero_registros; //saco mi valor en porcentaje
              //if (porcentaje==100){ncall=100;}
              //if (ncall==Math.round(porcentaje)){    //para efecto que pase solo 100 veces
                  out.print("<script>callprogress("+Math.round(porcentaje)+")</script>");
                  out.flush();
                  ncall++;
              //}

              i++;
          }
          //rs = null;

          consulta0="select clave, longitud,  latitud,  altitud,  cve_carta,the_geom_g from temp_act_loc1";
          out.print ("<tr><td>Generando tablas de cambios en servers...");
          rs = str.executeQuery( consulta0 );
          out.flush();
          out.print("<td nowrap><div><span id='getprogress1'>0</span>&nbsp;%</div>");
          rs1 = null;
          ResultSet rs2 = null;
          ResultSet rs3 = null;
          str1 = null;
          Statement str2 = null;
          Statement str3 = null;
          Connection conexion1 = null;
          Connection conexion2 = null;
          Connection conexion3 = null;
          conexion1 = DriverManager.getConnection("jdbc:postgresql://10.106.12.123:5432/mgn2k","mgn2k","internet");
          conexion2 = DriverManager.getConnection("jdbc:postgresql://10.153.3.21:5433/mgn2k","mgn2k","internet");
          //conexion3 = DriverManager.getConnection("jdbc:postgresql://10.152.11.44:5433/bdgeoestadistico","mgn2k","internet");
          str1 = conexion1.createStatement(rs1.TYPE_SCROLL_SENSITIVE, rs1.CONCUR_UPDATABLE);
          str2 = conexion2.createStatement(rs1.TYPE_SCROLL_SENSITIVE, rs1.CONCUR_UPDATABLE);
          //str3 = conexion3.createStatement(rs1.TYPE_SCROLL_SENSITIVE, rs1.CONCUR_UPDATABLE);
          porcentaje=0;
          i=1;
          while(rs.next()){
              String r1=rs.getObject(1).toString();
              String r2=rs.getObject(2).toString();
              String r3=rs.getObject(3).toString();
              String r4=rs.getObject(4).toString();
              String r5=rs.getObject(5).toString();
              String r6=rs.getObject(6).toString();
              consulta1= "insert into temp_act_loc1 (clave,longitud,latitud,altitud,cve_carta) values ('"+r1+"','"+r2+"','"+r3+"','"+r4+"','"+r5+"')";
              //out.println(consulta1);
              str1.executeUpdate(consulta1);
              //str2.executeUpdate(consulta1);
              //str3.executeUpdate("insert into temp_act_loc1 (clave,longitud,latitud,altitud,cve_carta,the_geom) values ('"+r1+"','"+r2+"','"+r3+"','"+r4+"','"+r5+"','"+r6+"')");
              porcentaje = i * 100 / numero_registros; //saco mi valor en porcentaje
              //if (porcentaje==100){ncall=100;}
              //if (ncall==Math.round(porcentaje)){    //para efecto que pase solo 100 veces
                  out.print("<script>callprogress1("+Math.round(porcentaje)+")</script>");
                  out.flush();
                  ncall++;
              //}

              i++;
          }

if (nban==1){

          consulta0="select * from a_cambiar_coord()";
          out.print ("<tr><td>Procesando cambios en tablas locales...");
          out.flush();
          rs = str.executeQuery( consulta0 );
          out.print ("<td>Ok!");


          out.print ("<tr><td>Procesando cambios en mgn2k remoto...");
          out.flush();
          //rs = str2.executeQuery( consulta0 );
          out.println("<script>");
          out.println("ventana = window.open('real_2.jsp','Real2','scrollbars=no,toolbar=no');");
          out.println("ventana.focus();");
          out.println("</script>");
          out.print ("<td><div id='real2'></div>");


/*
          out.print ("<tr><td>Procesando cambios en Mapa Digital...");
          out.flush();
         //rs = str3.executeQuery( consulta0 );
          out.println("<script>");
          out.println("ventana = window.open('real_3.jsp','Real3','scrollbars=no,toolbar=no');");
          out.println("ventana.focus();");
          out.println("</script>");
          out.print ("<td><div id='real3'></div>");
*/

          out.print ("<tr><td>Procesando cambios en mgn2k local...");
          out.flush();
          rs = str1.executeQuery( consulta0 );
          out.print ("<td>Ok!");

}
          rs.close();
          str1.close();
          str2.close();
          //str3.close();
          conexion1.close();
          conexion2.close();
          //conexion3.close();





          out.println("</table>");
    			if (nban==0){
    			   txt=" No hay cambios que realizar! ";
    			}else{
             time_end = System.currentTimeMillis();
    			   txt=" Se realizaron correctamente los cambios! (Total: "+numero_registros+")";
             txt+="<br><font size='2' color='blue'>Tiempo de proceso: "+ (( time_end - time_start )/1000) +" segundos</font>";
             txt+="<br><font size='1' color='blue'>"+(( time_end - time_start )/numero_registros) +" milisegundos por registro</font>";

    			}

      }else{
          txt=" No tienes privilegios para realizar cambios en la base principal! ";
      }
      rs.close();
      str.close();
      conexion.close();
    }
   catch (SQLException ex){
        out.println (ex);
    }

    catch(Exception ex){
        out.println (ex);
    }

    if (!(txt.isEmpty())){
           out.println("<br><br><center>"+txt+"</center>");
    }
%>
</body>
</html>