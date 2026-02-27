<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%

String  id = request.getParameter("id");
String  val = request.getParameter("val");
String consulta="";

try {
    if (val.equals("N")){
        consulta = "Update te_loc_coord set vreg='N' where gid="+id;
    }else if (val.equals("S")){
        consulta = "Update te_loc_coord set vreg='S' where gid="+id;
    }else{
        consulta = "Update te_loc_coord set vreg='R' where gid="+id;
    }
      ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
       conexion = DriverManager.getConnection(
                                             "jdbc:postgresql://10.153.3.25:5434/actcargeo10",
                                             "actcar",
                                             "actcar"
                                            );
    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    str.executeUpdate( consulta );
    str.close();
    conexion.close();
    out.println("y");
    }
    catch (SQLException ex){
      out.println("x");
  }
      catch(Exception ex){
        out.println("x");
    }

%>
