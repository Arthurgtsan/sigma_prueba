
package mx.org.inegi;



import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;
import javax.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.FileWriter;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

//import mx.org.inegi_nuevo_sigma_historicos_prueba.dao.DebuggerServlet;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

/**
 * Servlet implementation class Shp_ogr
 */
@WebServlet(description = "Exporta shapes con libreria ogr", urlPatterns = { "/Shp_ogr2" })

//@WebServlet("/Shp_ogr2")

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

public class Shp_ogr2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static String carpeta;
	static ServletContext servletContext;
	
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    
	//public Shp_ogr2() {
    //    super();
    //    // TODO Auto-generated constructor stub
   // }

    
    //static String param1;
    

    
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

    
    
    public static String Lanza_sh(String cons, String carp, ServletRequest request, HttpServletResponse response) {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession();
        String message= "";
        
        LocalDateTime fechaHora = LocalDateTime.now();
        DateTimeFormatter formatoFechaHora = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String fechaHoraFormatada = fechaHora.format(formatoFechaHora);
        message = fechaHoraFormatada;
        
        Random rand = new Random();
        int ran = rand.nextInt(10000); // Número entre 0-9999
        String nom = "exp" + ran;
        		
        		
		try {
			 //System.out.println("Inicia proceso de descarga");
				//verificar si la carpeta existe y es accesible
				File folder = new File("/datos/sigma_historicos/");
		    if (folder.exists() && folder.isDirectory()) {
		        //System.out.println("La carpeta existe y es un directorio");
		        message += "\nLa carpeta existe y es un directorio";
		        if (folder.canWrite()) {
		        	//System.out.println("Tienes permisos de escritura en la carpeta");
		        	message += "\nTienes permisos de escritura en la carpeta";
		        } else {
		        	//System.out.println("No tienes permisos de escritura en la carpeta");
		        	message += "\nNo tienes permisos de escritura en la carpeta";
 
		        }
		    } else {
		    	//System.out.println("La carpeta no existe o no es un directorio");
	        	message += "\nLa carpeta no existe o no es un directorio";
 
		    }

		/*
		    String comando = "/apps/miniconda3/envs/geo_env/bin/ogr2ogr -f \"ESRI Shapefile\" " + carp + ".shp PG:\"host=10.153.3.25 port=5434 user=arcgis password=arcgis dbname=actcargeo10\" -sql \"" + cons + "\" -lco ENCODING=UTF-8";
    	//String comando = "ogr2ogr -f \"ESRI Shapefile\" " + carp + ".shp PG:\"host=10.153.3.25 port=5434 user=arcgis password=arcgis dbname=actcargeo10\" -sql \"" + cons + "\" -lco ENCODING=UTF-8";
    	//String contraseña = "Arthur01"; // Reemplaza "tu_contraseña" con la contraseña real
      	System.out.println("comando ogr2ogr: " + comando);
      	message += "\nEl comando ogr2ogr es : " + comando;
      	ProcessBuilder processBuilder = new ProcessBuilder("sh", "-c", comando);
      	//processBuilder.environment().put("SUDO_ASKPASS", "/datos/sh/askpass.sh"); // Reemplaza "/path/al/askpass.sh" con la ruta correcta de tu askpass helper
      	Process proceso = processBuilder.start();
      	proceso.waitFor();
    	proceso.destroy();
        if (proceso.isAlive())
        proceso.destroyForcibly();
     //Crear el zip de la carpeta:
        System.out.println("Inicia creación zip");
        message += "\nInicia creación zip";
        String carpeta = carp;
        String archivoZip = carpeta + ".zip";
        //podria renombrar aqui:
        */
		    
		    
		    String result = "";
		    //obtener nom
		    //String nom = (String) request.getAttribute("nom");
	        String filename = nom +  ".shp";
	        String sql = cons;
	        		//"select cve_ent,cve_mun,nom_mun,st_transform(geom,6362) as geom from historico.municipio_2023 where cve_ent||cve_mun ilike '01001%' order by cve_ent||cve_mun limit 500000";
	        // se definen los comandos
	        
	        String cad_ogr = null;
	        String t = request.getParameter("t");
	        if ("DBF".equals(t)) {
	        	filename = filename.replace(".shp", ".dbf");
	        } 
	        
	        
	        cad_ogr =
	        //     "/apps/miniconda3/envs/geo_env/bin/ogr2ogr -f \"ESRI Shapefile\" /datos/sigma_historicos/" + filename
  		  "ogr2ogr -f \"ESRI Shapefile\" /datos/sigma_historicos/" + filename
          + " PG:\"host=10.153.3.25 port=5434 user=arcgis password=arcgis dbname=actcargeo10\""
          + " -sql \"" + sql + "\""
          + " -lco ENCODING=UTF-8";
	        if ("DBF".equals(t)) { 
	        	cad_ogr = cad_ogr + " -nlt NONE"; //para que no exporte geometrias
	        } 
	        
	        final String commands[] = {"bash", "-c", cad_ogr};
	        
	        // se crea el proceso
	        Process proceso = new ProcessBuilder(commands).start(); 
            proceso.waitFor();
	    	proceso.destroy();
	        if (proceso.isAlive())
	        proceso.destroyForcibly();
	     //Crear el zip de la carpeta:
	        //System.out.println("Inicia creación zip");
	        message += "\nInicia creación zip";
	        String carpeta = carp;
	        String archivoZip = carpeta + nom + ".zip";
        
        //zipCarpeta(carpeta, archivoZip);
        
	        zipCarpeta("/datos/sigma_historicos/", archivoZip, nom);
        
	    ServletContext servletContext = request.getServletContext();    
        String fileName = new File(archivoZip).getName();
        //archivoZip = "/datos/sigma_historicos/" + fileName; //Aqui debe ser la ruta real local
        String mimeType = servletContext.getMimeType(archivoZip);
        if (mimeType == null) { 
        	mimeType = "application/octet-stream"; 
        	}
		  response.setContentType(mimeType);
		  // Configurar las cabeceras de la respuesta HTTP
         String filePath = archivoZip;
		  File file = new File(filePath);
		  response.setContentLength((int)file.length());
		  response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
 
		  File nfile = new File(filePath);
		  if (nfile.exists()) {
		      // El archivo existe
		      //System.out.println("El archivo zip se creo en la ubicación especificada");
		      message += "\nEl archivo zip SÍ se creó en la ubicación especificada";
		  } else {
		      // El archivo no existe
		      //System.out.println("El archivo zip NO pudo crearse en la ubicación especificada");
		      message += "\nEl archivo zip NO pudo crearse en la ubicación especificada";
		  }
		  // Enviar el archivo ZIP al cliente 
		  //System.out.println("Inicia descarga del shp");
		  message += "\nInicia descarga del zip";
		  
		  ServletOutputStream outStream = response.getOutputStream();

		  try (FileInputStream fis = new FileInputStream(filePath)) {
			    byte[] byteBuffer = new byte[4096];
			    long totalBytesRead = 0;
	
			    try (DataInputStream in = new DataInputStream(new FileInputStream(file))) {
		            // reads the file's bytes and writes them to the response stream
		            int numBytesRead;
		            while ((numBytesRead = in.read(byteBuffer)) > 0) {
		                outStream.write(byteBuffer, 0, numBytesRead);
		                totalBytesRead += numBytesRead;
		            }
		            in.close();
		        } finally {
		            outStream.close();
		            
		        }
			    
			    File file1 = new File(filePath);
			    long fileSize = file1.length();
			    //Thread.sleep(3000);
			    message += "\nLa longitud del zip es: " + fileSize;
			    
			    if (totalBytesRead == fileSize) {
			        // La descarga del archivo se ha completado
			        message += "\nEl outStream se leyó completo";
			    } else {
			        // La descarga del archivo ha fallado
			        // Manejar el caso en el que la descarga no se haya completado
			    	//System.out.println("La descarga del archivo ha fallado");
			        message += "\nLa descarga del archivo ha fallado";
			    }
			    //HttpServletRequest httpRequest = (HttpServletRequest) request;
		        //HttpSession session = httpRequest.getSession();
		        message = message.replaceAll("\n", "<br>");
		        session.setAttribute("message", message);

			} catch (IOException ex) {
			    // Manejar la excepción de lectura del archivo
				//System.out.println("Excepción de lectura del archivo");
				message += "\nExcepción de lectura del archivo";
				message = message.replaceAll("\n", "<br>");
		        session.setAttribute("message", message);

			}



    } catch (Throwable  ex) {
    	String contenido = "{\"error\": \"No fue posible ejecutar el proceso, error: "+ ex +"\"}";
    	//escribe_error(contenido);
    	//System.out.println(contenido);
		message += "\n" + contenido;
		message = message.replaceAll("\n", "<br>");
        session.setAttribute("message", message);
    	return "{\"error\": \"No fue posible ejecutar el proceso, error: "+ ex +"\"}";
    }
		return null;
}



    private static void zipCarpeta(String carpeta, String archivoZip, String nombreArchivoAGuardar) throws IOException {
        try (FileOutputStream fos = new FileOutputStream(archivoZip);
             ZipOutputStream zos = new ZipOutputStream(fos)) {
            agregarCarpetaAlZip(carpeta, carpeta, zos, nombreArchivoAGuardar);
        }
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////

    private static void agregarCarpetaAlZip(String carpetaRaiz, String carpetaActual, ZipOutputStream zos, String nombreArchivoAGuardar) throws IOException {
        File carpeta = new File(carpetaActual);
        File[] archivos = carpeta.listFiles();
        
        if (archivos != null) {
            for (File archivo : archivos) {
                if (archivo.isDirectory()) {
                    agregarCarpetaAlZip(carpetaRaiz, archivo.getAbsolutePath(), zos, nombreArchivoAGuardar);
                } else {
                    String nombreArchivo = getBaseFileName(archivo.getName());
                    if (nombreArchivo.equals(nombreArchivoAGuardar) && !archivo.getName().endsWith(".zip")) {
                        agregarArchivoAlZip(carpetaRaiz, archivo, zos);
                    }
                }
            }
        }
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////

    private static void agregarArchivoAlZip(String carpetaRaiz, File archivo, ZipOutputStream zos) throws IOException {
        String rutaRelativa = archivo.getAbsolutePath().substring(carpetaRaiz.length());
        ZipEntry zipEntry = new ZipEntry(rutaRelativa);
        zos.putNextEntry(zipEntry);
        
        try (FileInputStream fis = new FileInputStream(archivo)) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                zos.write(buffer, 0, bytesRead);
            }
        }
        
        catch (Exception e) { 
        	String mensajeError = e.getMessage();
        }
        
        zos.closeEntry();
    }

    private static String getBaseFileName(String nombreArchivo) {
        int indexOfDot = nombreArchivo.lastIndexOf(".");
        if (indexOfDot == -1) {
            return nombreArchivo;
        } else {
            return nombreArchivo.substring(0, indexOfDot);
        }
    }
    
    

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

	public static void descarga_1(String nom, int forma, int capa, String corte, String c0, String c1, String c2, String c3, String filtro, HttpServletRequest request, HttpServletResponse response, String cons) {
		//escribe_error("entre en descarga1");
		
		String f1=null;
		//String param0 = Integer.toString(corte);
		
		java.util.Date currentDate = new java.util.Date();
		java.sql.Timestamp timestamp = new java.sql.Timestamp(currentDate.getTime());
		
		if (forma==1){
		
			Constructor_de_Consultas.consulta_reg_descarga_01("act10_ed", cons, timestamp,capa, filtro,corte, forma, c0, c1, c2, c3);
			
			
			switch (capa){
		case 1:
			f1="select cve_ent,nom_ent,st_transform(geom,6362) as geom from historico.entidad_"+corte+" where geom && ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 900913) order by cve_ent";
			break;
		case 2:
			f1="select cve_ent,cve_mun,nom_mun,st_transform(geom,6362) as geom from historico.municipio_"+corte+"  where geom && ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 900913) order by cve_ent||cve_mun";
			break;
		case 3:
			f1="select cve_ent,cve_mun,replace(cve_ageb,'-','') as cve_ageb,st_transform(geom,6362) as geom from historico.ageb_"+corte+"  where  geom && ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 900913)  order by cve_ent||cve_mun||cve_ageb";
			break;
		case 4:
			f1="select cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,st_transform(geom,6362) as geom from historico.agebu_"+corte+"   where  geom && ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 900913)  order by cve_ent||cve_mun||cve_ageb";
			break;
		case 5:
			f1="select cve_ent,cve_mun,cve_loc,nom_loc,ambito,st_transform(geom,6362) as geom from historico.l_"+corte+" where substring(ambito,1,1)='U' and geom  && ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 900913)  order by cve_ent||cve_mun||cve_loc";
			break;
		case 6:
			f1="select cve_ent,cve_mun,cve_loc,nom_loc,ambito,st_transform(geom,6362) as geom from historico.l_"+corte+" where substring(ambito,1,1)='R' and geom  && ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 900913)  order by cve_ent||cve_mun||cve_loc";
			break;
		case 61:
			f1="select cvegeo,st_transform(geom,6362) as geom from historico.pe_"+corte+" where geom  && ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 900913)  order by cvegeo";
			break;
		case 7:
			f1="select cve_ent,cve_mun,replace(cve_ageb,'-','') as cve_ageb,cve_loc,nom_loc,ambito,st_transform(geom,6362) as geom from historico.lpr_"+corte+"  where geom && ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 900913)  order by cve_ent||cve_mun||cve_loc";
			break;
		case 9:
			f1="select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza as cvegeo,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,ambito,st_transform(geom,6362) as geom from historico.manzana_"+corte+" where geom && ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 900913)  order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza ";
			break;
		case 13:
			f1="select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza as cvegeo,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,ambito,st_transform(geom,6362) as geom from historico.caserio_"+corte+" where geom && ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 900913)  order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza ";
			break;
		case 14:
			f1="select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza as cvegeo,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,ambito,st_transform(geom,6362) as geom from historico.manzana_"+corte+" where geom && ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 900913) union select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza as cvegeo,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,ambito,st_collect(st_triangle_32800(st_transform(geom,6362),5.3)) as geom from historico.caserio_"+corte+" where geom && ST_MakeEnvelope("+c0+","+c1+","+c2+","+c3+", 900913) group by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza";
			break;
		}
	}else{  //forma=2
		
		Constructor_de_Consultas.consulta_reg_descarga_01("act10_ed", cons, timestamp,capa, filtro,corte, forma, c0, c1, c2, c3);
		
		switch (capa){
		case 1:
			f1="select cve_ent,nom_ent,st_transform(geom,6362) as geom  from historico.entidad_"+corte+" where cve_ent ilike '"+filtro+"%' order by cve_ent";
			break;
		case 2:
							f1="select cve_ent,cve_mun,nom_mun,st_transform(geom,6362) as geom  from historico.municipio_"+corte+"  where  cve_ent||cve_mun  ilike '"+filtro+"%' order by  cve_ent||cve_mun";
			break;
		case 3:
			f1="select cve_ent,cve_mun,replace(cve_ageb,'-','') as cve_ageb,st_transform(geom,6362) as geom  from historico.ageb_"+corte+"  where   cve_ent||cve_mun||cve_ageb  ilike '"+filtro+"%'  order by cve_ent||cve_mun||cve_ageb";

			break;
		case 4:
			f1="select cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,st_transform(geom,6362) as geom  from historico.agebu_"+corte+"  where   cve_ent||cve_mun||cve_loc||cve_ageb  ilike '"+filtro+"%'  order by cve_ent||cve_mun||cve_loc||cve_ageb";
			break;
		case 5:
			f1="select cve_ent,cve_mun,cve_loc,nom_loc,ambito,st_transform(geom,6362) as geom  from historico.l_"+corte+" where substring(ambito,1,1)='U'  and cve_ent||cve_mun||cve_loc ilike '"+filtro+"%'  order by cve_ent||cve_mun||cve_loc";
			break;
		case 6:
			f1="select cve_ent,cve_mun,cve_loc,nom_loc,ambito,st_transform(geom,6362) as geom  from historico.l_"+corte+" where substring(ambito,1,1)='R'  and cve_ent||cve_mun||cve_loc ilike '"+filtro+"%'  order by cve_ent||cve_mun||cve_loc";
			break;
		case 61:
			f1="select cvegeo,st_transform(geom,6362) as geom  from historico.pe_"+corte+" where cvegeo ilike '"+filtro+"%'  order by cvegeo";
			break;
		case 7:
			f1="select cve_ent,cve_mun,replace(cve_ageb,'-','') as cve_ageb,cve_loc,nom_loc,ambito,st_transform(geom,6362) as geom  from historico.lpr_"+corte+" where cve_ent||cve_mun||cve_loc ilike '"+filtro+"%'  order by cve_ent||cve_mun||cve_loc";
			break;
		case 9:
			f1="select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza as cvegeo,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,ambito,st_transform(geom,6362) as geom  from historico.manzana_"+corte+" where cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza ilike '"+filtro+"%' order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza ";
			break;
		case 13:
			f1="select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza as cvegeo,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,ambito,st_transform(geom,6362) as geom  from historico.caserio_"+corte+" where cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza ilike '"+filtro+"%' order by cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza ";
			break;
		case 14:

			f1="select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza as cvegeo,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,ambito,st_transform(geom,6362) as geom  from historico.manzana_"+corte+" where cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza ilike '"+filtro+"%' union select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza as cvegeo,cve_ent,cve_mun,cve_loc,replace(cve_ageb,'-','') as cve_ageb,cve_mza,ambito,st_collect(st_triangle_900913(st_transform(geom,6362),5.3)) as geom from historico.caserio_"+corte+" where cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza ilike '"+filtro+"%' group by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza";
			break;
		}
	}
	f1= f1+" limit 500000";
	String sexec="";
	String sFichero="";
	String user="-P arcgis -u arcgis";
	String hostbd  = "actcargeo10";
    String remotehostbd  = "10.153.3.25";
	remotehostbd=remotehostbd+" -p 5434 ";
	 
     //LINUX
		 
	
		 	carpeta= "/datos/sigma_historicos/"+nom;
		 	
		 	
		 	
		 	
		 	String resultado = Lanza_sh(f1,carpeta, request, response);
		 	
		 	//como lanzar este resultado al navegador?
		 	//<script>alert( "Hola <%=request.getAttribute("mensaje")%>")</script>
		 	//return resultado;
	}
    
    
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		//de aqui llamar todo?
		
		
		
		
        // Obtener la ruta absoluta del archivo en el servidor
        String filePath = carpeta; // Reemplaza con la ruta de tu archivo
        
        // Obtener el nombre del archivo
        String fileName = new File(filePath).getName();
        
        // Establecer el tipo MIME del archivo para la respuesta HTTP
        String mimeType = getServletContext().getMimeType(filePath);
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }
        response.setContentType(mimeType);
        
        // Configurar las cabeceras de la respuesta HTTP
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        
        // Enviar el archivo al cliente
        try (FileInputStream fis = new FileInputStream(filePath)) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                response.getOutputStream().write(buffer, 0, bytesRead);
            }
        }
    }
    
    
	
	
	
	
	// ...
    // Otros métodos del servlet (doPost, init, destroy, etc.) si los necesitas
		
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////


	/**
	 * @see HttpServlet#doPost(HttpServletRequest requsudo ogr2ogr -f "ESRI Shapefile" /datos/sigma_historicos/mun.shp PG:"host=10.153.3.25 port=5434 user=arcgis password=arcgis dbname=actcargeo10" -sql "select * from cat_mun where cve_ent='01'" -lco ENCODING=UTF-8 
est, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
		
		  try { // Lógica de tu función Lanza_sh() aquí
		  
		  //resultado = Lanza_sh(); request.setAttribute("error", param1);
		  
		  //request.getParameter("c3");

		  String consulta = request.getParameter("consulta");
	      String carpeta = request.getParameter("carpeta");
		  String resultado = Lanza_sh(consulta,carpeta, request, response);
		  
		  //String resultado = Lanza_sh(f1,carpeta);
		  
		  } catch (Exception e) { String mensajeError = e.getMessage();
		  request.setAttribute("error", mensajeError); }
		  
		  // Aquí puedes redirigir o enviar la respuesta de alguna manera según tus
		  //necesidades // Por ejemplo, redirigir a una página de error RequestDispatcher
		  //dispatcher = request.getRequestDispatcher("/error.jsp");
		  //dispatcher.forward(request, response);
		 
		
		
		
	}



	
	///----------------------------------------------------------------------------------------------
	
	
	public static void Descarga_servlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
	    // Obtener los valores necesarios del objeto request
		String nom = (String) request.getAttribute("nom");
		//System.out.println("nom: " + nom);
		//System.out.println("userName: "+request.getAttribute("userName"));
		
		String cons = "U:"+request.getAttribute("userName").toString();
		int forma = Integer.parseInt(request.getParameter("forma"));
	    int capa = Integer.parseInt(request.getParameter("capa"));
	    int corte = Integer.parseInt(request.getParameter("corte"));
	    String c0 = request.getParameter("c0");
	    String c1 = request.getParameter("c1");
	    String c2 = request.getParameter("c2");
	    String c3 = request.getParameter("c3");
	    String filtro = request.getParameter("filtro");
	    String corteString = String.valueOf(corte);
	    

	    // Obtener el objeto ServletContext a través del objeto HttpServletRequest
	    servletContext = request.getServletContext();
	    
	    //System.out.println("el nombre en desc_servlet es: " + nom);
	    
	    //System.out.println("nom: " + nom);
	    //System.out.println("forma: " + forma);
	    //System.out.println("capa: " + capa);
	    //System.out.println("corteString: " + corteString);
	    //System.out.println("c0: " + c0);
	    //System.out.println("c1: " + c1);
	    //System.out.println("c2: " + c2);
	    //System.out.println("c3: " + c3);
	    //System.out.println("filtro: " + filtro);
	    //System.out.println("cons: " + cons);
	    
	    
	    // Llamar a la función descarga_1 pasando los parámetros
	    descarga_1(nom, forma, capa, corteString, c0, c1, c2, c3, filtro, request, response,cons);

	    // Más lógica del método...
	}



    public static void borrar_basura() {
        String rutaCarpeta = "/datos/sigma_historicos";

        try {
        	Thread.sleep(10000);
        	ProcessBuilder processBuilder = new ProcessBuilder("rm", "-r", rutaCarpeta);
            Process process = processBuilder.start();
            int exitCode = process.waitFor();
            if (exitCode == 0) {
                //System.out.println("La carpeta ha sido eliminada exitosamente.");
            } else {
                //System.out.println("Ha ocurrido un error al eliminar la carpeta.");
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
	
	
    
    public static void mostrarAlerta(String mensaje) {
        try {
            // Construir la URL del Servlet
            //String servletUrl = "http://localhost:8070/sigma_historicos_prueba/alerta?message=" + URLEncoder.encode(mensaje, "UTF-8"); //win

            String servletUrl = "http://localhost:8082/sigma_desarrollo/alerta?message=" + URLEncoder.encode(mensaje, "UTF-8"); //win

            
            //String servletUrl = "http://localhost:8080/sigma_historicos_prueba/alerta?message=" + URLEncoder.encode(mensaje, "UTF-8"); //lnx
            
            //String servletUrl = "http://10.210.140.70:8081/sigma_historicos_prueba/alerta?message=" + URLEncoder.encode(mensaje, "UTF-8"); //oscar
            
            
            
            
            
            // Abrir una conexión HTTP y enviar la solicitud
            URL url = new URL(servletUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.getResponseCode();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
