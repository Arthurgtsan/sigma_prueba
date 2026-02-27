package mx.org.inegi.maven_eclipse_test.dto;

public class AgemDTO {

    private int objectid;
    private String cve_ent;
    private String cvegeo;
    private String nombre;

    public AgemDTO() {
        super();
    }

    public AgemDTO(int objectid, String cvegeo, String nombre) {
        super();
        this.objectid = objectid;
        this.cvegeo = cvegeo;
        this.nombre = nombre;
    }

    public int getObjectid() {
        return objectid;
    }

    public void setObjectid(int objectid) {
        this.objectid = objectid;
    }

    public String getCve_ent() {
        return cve_ent;
    }

    public void setCve_ent(String cve_ent) {
        this.cve_ent = cve_ent;
    }

    public String getCvegeo() {
        return cvegeo;
    }

    public void setCvegeo(String cvegeo) {
        this.cvegeo = cvegeo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    @Override
    public String toString() {
        return "Agem [objectid=" + objectid + ", cvegeo=" + cvegeo + ", nombre=" + nombre + "]";
    }
}
