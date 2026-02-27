<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
    <title>
SIGMA
</title>
<style>
.titulo{ font-family: Arial, Helvetica, sans-serif; font-size: 20px; font-style: normal; line-height: normal; font-weight: bold; font-variant: normal; text-transform: none; color: #000000; text-indent: 10pt; text-align: center; white-space: nowrap; height: 14px; border-style: none}
.titulo2{ color:#000000; font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-style: normal; line-height: normal; font-weight: bold; text-align: center; }
.n{font-family: Arial;  text-align: center; font-size: 7pt; line-height: 1.3;}
.n1{font-family: Arial;  text-align: left; font-size: 12px; line-height: 1.3; font-weight: bold;color: #000000;}
.n2{font-family: Arial;  text-align: center; font-size: 12px; line-height: 1.3; font-weight: bold;color: #000000;}
.n3{font-family: Arial;  font-size: 12px; line-height: 1.3; font-weight: bold;color: #000000; background-color: #D8D8D8;}
.n4{font-family: Arial;  text-align: center; font-size: 12px; line-height: 1.3; font-weight: bold; color: #999999;}
.error {font-weight: bold;font-size:12px;color:red;}

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
  <center><font class='titulo'>Avance de Inventario de Viviendas</font><br><br>
  <form method='POST' name=enviar><br>
      <font class=n>Usuario:</font> <input type=password name=pass>&nbsp;&nbsp;&nbsp;<input type=submit name=" Consultar "><br><br>
      <input type=hidden name=ban value=1>
  
<%
String pass = request.getParameter("pass");
String ban = request.getParameter("ban");
String nivel = request.getParameter("nivel");

if (ban != null){
 
 String cons="";
 String consulta = "select cons from usuarios where nivel=3 and upper(password) = upper('"+pass+"')";
 //out.println(consulta);
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
      int n2=0;
      rs = str.executeQuery( consulta );
      while(rs.next()){
                n2=1;
                cons=rs.getObject(1).toString();
      }
      if (n2==0){
        out.println("<br><font class='error'>-- USUARIO INCORRECTO --</font>");
    }else{
    String consulta1="";
   if (cons.equals("44") || pass.equals("ara") || pass.equals("ARA") ){
    consulta1 = "select inv_us, nombre, count(*) from v_cat_mza_inv t1, usuarios t2 where cons=inv_us and inv_us is not null ";
      if (nivel == null){
      consulta1+="group by inv_us,nombre order by nombre ";
    }else{
      consulta1+=" and nivel=3 group by inv_us,nombre order by nombre ";
  }
  }else{
    consulta1 = "select inv_us, (select nombre from usuarios where cons=inv_us), count(*) from v_cat_mza_inv where inv_us="+cons+" group by inv_us order by inv_us,nombre";
  }
      rs = str.executeQuery( consulta1 );
      out.println("<input type=hidden name=pass value="+pass+">");
      out.println("<input type=hidden name=ban value="+ban+">");
      out.println("<input type=checkbox name=nivel onclick='document.enviar.submit();'");
      if (nivel == null){
        out.println(">");
    }else{
      out.println(" checked>");
  }

      out.println("<font class=n2>Solo Oficinas Centrales</font><table border=1><tr class=titulo2><th>&nbsp;Nombre&nbsp;<th>&nbsp;Validadas&nbsp;");
      String nombre,fecha,t1,nom="";
      int sum1=0;
      int sum2=0;
      int n=0;
      while(rs.next()){
        nombre=rs.getObject(2).toString();
        //fecha=rs.getObject(3).toString();
        t1=rs.getObject(3).toString();
        if (nom.equals(nombre)){
            out.println("<tr class=n2><td align=left>&nbsp;<td align=right>&nbsp;"+t1+"&nbsp;");
            sum1+=Integer.parseInt(t1);
        }else{
          if (n==1){
            out.println("<tr><td class=n3 align=right>TOTAL<td class=n3 align=right>&nbsp;"+(sum1)+"&nbsp;");
            sum2+=sum1;
            sum1=0;
          }
          sum1+=Integer.parseInt(t1);
          n=1;
          out.println("<tr class=n2><td colspan=2><hr/>");
          out.println("<tr class=n2><td align=left>&nbsp;"+nombre+"&nbsp;<td align=right>&nbsp;"+t1+"&nbsp;");
          nom=nombre;
        }
      }
      sum2+=sum1;
      out.println("<tr><td class=n3 align=right>TOTAL<td class=n3 align=right>&nbsp;"+sum1+"&nbsp;");
      out.println("</table><br>");
      out.println("<table>");
      out.println("<tr><td class=n3 align=right>TOTAL<td class=n3 align=right>&nbsp;"+sum2+"&nbsp;");
      out.println("</table><br>");
      str.close();
    }
      conexion.close();
    }
%>
</form>
</body>
</html>
