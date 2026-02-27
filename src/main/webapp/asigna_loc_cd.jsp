<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
String  gid = request.getParameter("gid");
String consulta="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
try {
    consulta = "update mcc_poblacion.cat_manz_modcar set proc=1,fresp=current_date,cgo_def='L' where gid="+gid+" and cve_ent||cve_mun||cve_loc not in (select distinct cve_ent||cve_mun||cve_loc from cat_manz where ban not in ('X','3','1','5','6','Y','E','D','H','G','M','I','N','O','K','R','T','C') union (select distinct cve_ent||cve_mun||cve_loc from cat_cd)) RETURNING gid";

     //consulta = "update mcc_poblacion.cat_manz_modcar set proc=1,fresp=current_date,cgo_def='L' where gid="+gid+"  RETURNING gid";

    //out.println (consulta);
    ResultSet rs = null;
    Statement str = null;
    Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    //str.executeUpdate( consulta );
    rs = str.executeQuery( consulta );
    String ban="1";
    while(rs.next()){
      ban="2";
    }
    out.print(ban);
    str.close();
    conexion.close();
    }
    catch (SQLException ex){
      out.print("0");
  }
      catch(Exception ex){
        out.print("0");
   }
%>

