<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
    <title>
SIGMA
</title>
<style>

.titulo{ font-family: Arial, Helvetica, sans-serif; font-size: 18px; font-style: normal; line-height: normal; font-weight: bold; font-variant: normal; text-transform: none; color: #000000; text-indent: 10pt; text-align: center; white-space: nowrap; height: 14px; border-style: none}
.titulo2{ color:#000000; font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-style: normal; line-height: normal; font-weight: bold; text-align: center; }
.n{font-family: Arial;  text-align: center; font-size: 10pt; line-height: 1.3;}
.n0{font-family: Arial;  text-align: center; font-size: 8pt; line-height: 1.3;}
.n1{font-family: Arial;  text-align: left; font-size: 12px; line-height: 1.3; font-weight: bold;color: #000000;}
.n2{font-family: Arial;  text-align: center; font-size: 14px; line-height: 1.3; font-weight: bold;color: #000000;}
.n3{font-family: Arial;  text-align: center; font-size: 12px; line-height: 1.3; font-weight: bold;color: #000000; background-color: #D8D8D8;}
.n4{font-family: Arial;  text-align: center; font-size: 12px; line-height: 1.3; font-weight: bold; color: #999999;}
.boton{font-family: Verdana,sans-serif;  text-align: center; font-size: 10px; line-height: 1.3; font-weight: normal;}

.t{font-family: Arial;  text-align: center; font-size: 18px; line-height: 1.3; font-weight: bold;color: #000000;}
a:link {color: black; }
a:visited {color: black;}
a:hover {color: #FFFFFF; background-color: #000000}
.aa{font-family: Arial; font-size: 12px; font-weight: bold;text-decoration:underline}
.aa1{font-family: Arial; font-size: 14px; font-weight: bold;text-decoration:underline}
.fecha{font-family: Arial; font-size: 14px; font-weight: bold;text-decoration:underline}


table {
  border-collapse: collapse;
}
table {
  font-size:100%;
  font-family:inherit;
  border-top:1.0pt solid ;
  border-right:1.0pt solid ;
  border-bottom:1.0pt solid ;
  border-left:1.0pt solid ;
  color:#00002
}
td{
  padding: 3px;
}

th{
  padding: 5px;
}
</style>
<body >
  <CENTER CLASS=T>Reporte de validacion regional de TE<br><br>
<CENTER><table BORDER=1>
<%
String  reg = request.getParameter("reg");
if (reg == null){
reg="00";
}
//out.println(reg);
%>
  <form>
    <center>
      <font class='n1'>Regional:</font>&nbsp;<select name='reg' class=n1 onChange='submit();'>
      <option value='00'>Seleccione...</option>
      <option value='01' <% if (reg.equals("01")){out.println(" selected");}%>>01</option>
      <option value='02' <% if (reg.equals("02")){out.println(" selected");}%>>02</option>
      <option value='03' <% if (reg.equals("03")){out.println(" selected");}%>>03</option>
      <option value='04' <% if (reg.equals("04")){out.println(" selected");}%>>04</option>
      <option value='05' <% if (reg.equals("05")){out.println(" selected");}%>>05</option>
      <option value='06' <% if (reg.equals("06")){out.println(" selected");}%>>06</option>
      <option value='07' <% if (reg.equals("07")){out.println(" selected");}%>>07</option>
      <option value='08' <% if (reg.equals("08")){out.println(" selected");}%>>08</option>
      <option value='09' <% if (reg.equals("09")){out.println(" selected");}%>>09</option>
      <option value='10' <% if (reg.equals("10")){out.println(" selected");}%>>10</option>
              </select>
    </center>
  </form><br>
<%
if (!(reg.equals("00"))){
String consulta1 = " select * from (select usre, (select nombre from usuarios where cons=usre),fvre,sum(count),(select regid from usuarios where cons=usre) as regi from (select usre,fvre,count(*) from respaldo_te_mza where usre is not null group by usre,fvre union all select usre,fvre,count(*) from respaldo_te_mza_coord where usre is not null group by usre,fvre union all select usre,fvre,count(*) from respaldo_te_mza_cd where usre is not null group by usre,fvre ) t2  group by usre,fvre order by usre,nombre,fvre ) tt where regi='"+reg+"'";


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
	  
	  
      //out.println("<center><font class='titulo'>Avance de validacion, regional "+reg+"</font><br><br>");
      out.println("<table border=1><tr class=titulo2><th>&nbsp;Nombre&nbsp;<th>&nbsp;Fecha&nbsp;<th>&nbsp;Validadas&nbsp;");
      String nombre,fecha,t1,nom="";
      int sum1=0;
      int sum2=0;
      int n=0;
      while(rs.next()){
        nombre=rs.getObject(2).toString();
        fecha=rs.getObject(3).toString();
        t1=rs.getObject(4).toString();
        if (nom.equals(nombre)){
            out.println("<tr class=n2><td align=left>&nbsp;<td>&nbsp;"+fecha+"&nbsp;<td align=right>&nbsp;"+t1+"&nbsp;");
            sum1+=Integer.parseInt(t1);
        }else{
          if (n==1){
            out.println("<tr><td class=n2>&nbsp;<td class=n3 align=right>TOTAL<td class=n3 align=right>&nbsp;"+(sum1)+"&nbsp;");
            sum2+=sum1;
            sum1=0;
          }
          sum1+=Integer.parseInt(t1);
          n=1;
          out.println("<tr class=n2><td colspan=3><hr/>");
          out.println("<tr class=n2><td align=left>&nbsp;"+nombre+"&nbsp;<td>&nbsp;"+fecha+"&nbsp;<td align=right>&nbsp;"+t1+"&nbsp;");
          nom=nombre;
        }
      }


	  String consulta9 = "insert into usuarios_reporte values (DEFAULT, '"+request.getRemoteAddr()+"',current_timestamp,'Rep_val_TE');";
	  str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
str.executeUpdate(consulta9);

      sum2+=sum1;
      out.println("<tr><td class=n2>&nbsp;<td class=n3 align=right>TOTAL<td class=n3 align=right>&nbsp;"+sum1+"&nbsp;");
      out.println("</table><br>");
      out.println("<table>");
      out.println("<tr><td class=n3 align=right>TOTAL<td class=n3 align=right>&nbsp;"+sum2+"&nbsp;");
      out.println("</table><br>");
      str.close();
      conexion.close();
    }
%>

</body>
</html>
