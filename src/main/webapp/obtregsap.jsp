<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
String  x = request.getParameter("x");
String  y = request.getParameter("y");
String  tipo = request.getParameter("tipo");
String  gid = request.getParameter("gid");
String  figura = request.getParameter("figura");
String  clas = request.getParameter("clas"); //1=manzana y caserio (modacr) 3-localidad (locrur)
String  clavebaja = request.getParameter("clave"); //la uso para cuando relacionan una de baja debe ser la misma (se pudiera usar para los cambios de forma)
String consulta="";
String consulta2="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();

switch (tipo){
    case "1":
    case "11":
    consulta = "select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza from cat_manz where st_intersects(the_geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) and ban not in ('X','3','1','5','6','Y','E','D','H','G','M','I','N','O','K','R','T','C') order by st_Area(the_geom) limit 1";
    break;
    case "4":    //relacionar a una baja de manzana
    consulta = "select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza from cat_manz where cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza='"+clavebaja+"' and st_intersects(the_geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) and ban in ('3','1','K','R','T','C') order by st_Area(the_geom) limit 1";
    break;
    case "2":
    case "21":
    consulta = "select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza from cat_cd where st_intersects(the_geom,st_buffer(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800),100)) order by st_distance(the_geom,(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800))) ASC LIMIT 1";
    break;
    case "3":
    case "31":
    consulta = "select clave||replace(cve_ageb,'-','')||'800' FROM (SELECT cat_loc.clave,cve_ageb,the_geom FROM cat_loc WHERE status=1 and ambito='R' and NOT (cat_loc.clave::text IN ( SELECT bd_loc_pendientes.clave FROM bd_loc_pendientes)) UNION SELECT bd_loc_pendientes.clave,ageb, st_setsrid(st_point(ccl_x,ccl_y), 32800) AS the_geom  FROM bd_loc_pendientes WHERE status = 1 AND ambito = 'R') t2 WHERE st_intersects(the_geom,st_buffer(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800),100)) order by st_distance(the_geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) LIMIT 1";
    break;
    case "8":
    case "81":
      consulta ="select clave FROM (SELECT cat_loc.clave,cve_ageb,the_geom FROM cat_loc WHERE status=0 and ambito='R' and  NOT (cat_loc.clave::text IN ( SELECT bd_loc_pendientes.clave FROM bd_loc_pendientes)) union SELECT bd_loc_pendientes.clave,ageb, st_setsrid(st_point(ccl_x,ccl_y), 32800) AS the_geom FROM bd_loc_pendientes WHERE status = 0 AND ambito = 'R') t2 WHERE st_intersects(the_geom,st_buffer(st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800),100)) order by st_distance(the_geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) LIMIT 1";
    break;


}
    ResultSet rs = null;
    Statement str = null;
    Statement str2 = null;
    Connection conexion = null;
          ResultSet rs3 = null;
          Statement str3 = null;
          Connection conexion3 = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    str2 = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    rs = str.executeQuery( consulta );
    int reg=0;
    String clave="";
    String id="";
      while(rs.next()){
        clave=rs.getObject(1).toString();
        //out.println(clave);
       ////////aqui lo del MCC
        //clas es el tipo que se va a relacionar,, 1, manzana, 2 caserio y 3 localidad para ver que tabla afectar
        // el tipo es A LO QUE SE RELACIONA 1, y 4 manzana, 2 caserio, 3 y 8 localidad
       if (tipo.equals("1") ||
              tipo.equals("2") ||
              tipo.equals("3") ||
              tipo.equals("4") ||
              tipo.equals("8")){
                      if (!(tipo.equals("8"))){
                      //out.println(tipo);
                            reg=1;
                            switch (clas){
                            case "1":
                            case "2":
                                if (tipo.equals("4")){
                                  tipo="1";
                                }
                                consulta2 = "update mcc_poblacion.cat_manz_modcar set proc=2,cgo_def='"+tipo+"',cve_def='"+clave+"',fresp=current_date where proc!=1 and gid||figura='"+gid+figura+"'";
                                break;
                            case "3":
                                //consulta2 = "update mcc_poblacion.loc_rur set usado="+(tipo+1)+",cve_mza='"+clave+"' where gid="+gid+"";
                                consulta2 = "update mcc_poblacion.loc_rur set proc=2,cgo_def='"+tipo+"',cve_def='"+clave+"',fresp=current_date where proc!=1 and gid='"+gid+"'";
                                break;
                            }
                            str2.executeUpdate( consulta2 );
                      }else{
                          String consulta3="";
                          Class.forName("org.postgresql.Driver");
                          conexion3 = DriverManager.getConnection("jdbc:postgresql://10.153.3.25:5434/actcargeo10","actcar","actcar");
                          str3 = conexion3.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
                          consulta3 = "select id::text from bd_loc where fcap>='2023-08-01' and cgo1 in ('C','R','T','D','E','H','I','M') and ent_ant||mun_ant||loc_ant='"+clave+"' order by id desc limit 1";
                          rs3 = str3.executeQuery( consulta3 );
                          reg=0;
                          while(rs3.next()){
                            id=rs3.getObject(1).toString();
                            reg=1;
                            consulta3 = "update bd_loc set id_prov="+gid+" where id="+id;
                            //out.println(consulta3);
                            str3.executeUpdate( consulta3 );
                            consulta2 = "update mcc_poblacion.loc_rur set proc=1,fresp=current_date where gid='"+gid+"'";
                            str2.executeUpdate( consulta2 );
                            break;
                          } //while
                          str3.close();
                          conexion3.close();
                        } //tipo
        }else{

       ////////aqui lo del CUR

                      if (!(tipo.equals("81"))){
                      //out.println(tipo);
                            reg=1;
                            switch (clas){
                            case "1":
                            case "2":
                                //no hay manzana que relacionar de la cur ni caserio.
                                //consulta2 = "update mcc_poblacion.cat_manz_modcar set proc=2,cgo_def='"+tipo+"',cve_def='"+clave+"',fresp=current_date where proc!=1 and gid||figura='"+gid+figura+"'";
                                break;
                            case "3":
                                //consulta2 = "update mcc_poblacion.loc_rur set usado="+(tipo+1)+",cve_mza='"+clave+"' where gid="+gid+"";
                                consulta2 = "update act_cu.bcu_bd_loc_rur set proc=2,cgo_def=left('"+tipo+"',1),cve_def='"+clave+"',fresp=current_date where proc!=1 and gid='"+gid+"'";
                                break;
                            }
                            str2.executeUpdate( consulta2 );
                      }else{
                          String consulta3="";
                          Class.forName("org.postgresql.Driver");
                          conexion3 = DriverManager.getConnection("jdbc:postgresql://10.153.3.25:5434/actcargeo10","actcar","actcar");
                          str3 = conexion3.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
                          consulta3 = "select id::text from bd_loc where fcap>='2023-08-01' and cgo1 in ('C','R','T','D','E','H','I','M') and ent_ant||mun_ant||loc_ant='"+clave+"' order by id desc limit 1";
                          rs3 = str3.executeQuery( consulta3 );
                          reg=0;
                          while(rs3.next()){
                            id=rs3.getObject(1).toString();
                            reg=1;
                            consulta3 = "update bd_loc set id_prov="+gid+" where id="+id;
                            //out.println(consulta3);
                            str3.executeUpdate( consulta3 );
                            consulta2 = "update act_cu.bcu_bd_loc_rur set proc=1,fresp=current_date where gid='"+gid+"'";
                            str2.executeUpdate( consulta2 );
                            break;
                          } //while
                          str3.close();
                          conexion3.close();
                        } //tipo

        }


      }//whilw
      if (reg==1){
        out.print(clave);
    }else{
        out.print("1");
    }
    str.close();
    conexion.close();
  
%>

