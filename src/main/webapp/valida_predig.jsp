<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
//int  id = Integer.parseInt(request.getParameter("id"));
//String  filterid = request.getParameter("filterid");
//HttpSession sesion = request.getSession(false);
//String remotehost  = session.getAttribute("remotehost").toString();
//try {
      String consulta1="";
      /*consulta1 = "select a_dig_numfr("+id+",'"+filterid+"')";
      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      rs = str.executeQuery( consulta1 );
      str.close();
      conexion.close();*/
      out.println("0");
/*    }
   catch (SQLException ex){
     out.println("1");
    }

    catch(Exception ex){
     out.println("1");
    }*/

%>