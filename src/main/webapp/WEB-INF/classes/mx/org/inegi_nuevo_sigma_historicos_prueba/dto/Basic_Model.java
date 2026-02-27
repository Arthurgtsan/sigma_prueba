package mx.org.inegi_nuevo_sigma_historicos_prueba.dto;

public class Basic_Model {

    private String Select_cnx;
    private String Q_R_Y;
   
    
    public Basic_Model() {}
   
    /**
     * @param Select_cnx Se refiere a la conexi�n elegida en el pool_driver_manager.
     * @param q_r_y La consulta a ejecutar.
     */
    public Basic_Model(String select_cnx,  String q_r_y ) {
        //tipo es la opciom de conexion de las que estan guardadas en pool_driverManager (local, actcargeo1. etc)
    	
    	this.Select_cnx = select_cnx;
        this.Q_R_Y = q_r_y;
        
    }
	
    
    public void setSelect_cnx(String select_cnx) {
        this.Select_cnx = select_cnx;
    }
    
    public String getSelect_cnx() {
        return Select_cnx;
    }
    
    
    
    public void setQ_R_Y(String q_r_y) {
        this.Q_R_Y = q_r_y;
    }
    
    public String getQ_R_Y() {
        return Q_R_Y;
    }

    
    
    @Override
    public String toString() {
        return "Basic_Model [Select_cnx=" + Select_cnx + ", Q_R_Y=" + Q_R_Y + "]";
    }
    
}
