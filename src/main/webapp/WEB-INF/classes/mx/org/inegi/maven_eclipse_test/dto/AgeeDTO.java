package mx.org.inegi.maven_eclipse_test.dto;

public class AgeeDTO {

    private int objectid;
    private String cvegeo;
    private String nombre;

    public AgeeDTO() {
        super();
    }

    public AgeeDTO(int objectid, String cvegeo, String nombre) {
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
        return "Agee [objectid=" + objectid + ", cvegeo=" + cvegeo + ", nombre=" + nombre + "]";
    }
}
