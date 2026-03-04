package mx.org.inegi.maven_eclipse_test.dao;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Oscar.Duran
 */
public class DataSourceConfig {
    private final String ARCHIVO_BD = "/db.properties";
    
    private String driver;
    private String url;
    private String user;
    private String password;

    private boolean testWhileIdle;
    private boolean testOnBorrow;
    private boolean testOnReturn;
    private String validationQuery;
    private int validationQueryTimeout;
    private int timeBetweenEvictionRunsMillis;
    private int removeAbandonedTimeout;
    private boolean removeAbandonedOnBorrow;
    private boolean logAbandoned;
    private int minEvictableIdleTimeMillis;
    private int maxTotal;
    private int minIdle;
    private int maxWaitMillis;
    private int initialSize;
    private int maxConnLifetimeMillis;
    
    private String rutaBase;
    private String urlLogService;
    
    private static DataSourceConfig instance = null;
    
    public static DataSourceConfig getInstance() {
        if (instance == null) {
            try {
                instance = new DataSourceConfig();
            } catch (IOException ex) {
                Logger.getLogger(DataSourceConfig.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return instance;
    }
    
    private DataSourceConfig() throws IOException {
        InputStream inputStream = null;
        
        inputStream = getClass().getResourceAsStream(ARCHIVO_BD); 
        try {
            Properties propiedadesConexion = new Properties();
            propiedadesConexion.load(inputStream);
            
            this.driver = propiedadesConexion.getProperty("driverName");
            this.url = propiedadesConexion.getProperty("urlBD");
            this.user = propiedadesConexion.getProperty("userBD");
            this.password = propiedadesConexion.getProperty("passwordBD");
            this.testWhileIdle = Boolean.valueOf(propiedadesConexion.getProperty("testWhileIdle"));
            this.testOnBorrow = Boolean.valueOf(propiedadesConexion.getProperty("testOnBorrow"));
            this.testOnReturn = Boolean.valueOf(propiedadesConexion.getProperty("testOnReturn"));
            this.validationQuery = propiedadesConexion.getProperty("validationQuery");
            this.validationQueryTimeout = Integer.valueOf(propiedadesConexion.getProperty("validationQueryTimeout"));
            
            this.timeBetweenEvictionRunsMillis = Integer.valueOf(propiedadesConexion.getProperty("timeBetweenEvictionRunsMillis"));
            this.removeAbandonedTimeout = Integer.valueOf(propiedadesConexion.getProperty("removeAbandonedTimeout"));
            this.removeAbandonedOnBorrow = Boolean.valueOf(propiedadesConexion.getProperty("removeAbandonedOnBorrow"));
            this.logAbandoned = Boolean.valueOf(propiedadesConexion.getProperty("logAbandoned"));
            this.minEvictableIdleTimeMillis = Integer.valueOf(propiedadesConexion.getProperty("minEvictableIdleTimeMillis"));

            this.maxTotal = Integer.valueOf(propiedadesConexion.getProperty("maxTotal"));
            this.minIdle = Integer.valueOf(propiedadesConexion.getProperty("minIdle"));
            this.maxWaitMillis = Integer.valueOf(propiedadesConexion.getProperty("maxWaitMillis"));
            this.initialSize = Integer.valueOf(propiedadesConexion.getProperty("initialSize"));
            
            this.maxConnLifetimeMillis = Integer.valueOf(propiedadesConexion.getProperty("maxConnLifetimeMillis"));
        } finally {
            if(inputStream != null) {
                inputStream.close();
                inputStream = null;
            }
        }
        
    }

    /**
     * @return the driver
     */
    public String getDriver() {
        return driver;
    }

    /**
     * @param driver the driver to set
     */
    public void setDriver(String driver) {
        this.driver = driver;
    }

    /**
     * @return the url
     */
    public String getUrl() {
        return url;
    }

    /**
     * @param url the url to set
     */
    public void setUrl(String url) {
        this.url = url;
    }

    /**
     * @return the user
     */
    public String getUser() {
        return user;
    }

    /**
     * @param user the user to set
     */
    public void setUser(String user) {
        this.user = user;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * @return the testWhileIdle
     */
    public boolean isTestWhileIdle() {
        return testWhileIdle;
    }

    /**
     * @param testWhileIdle the testWhileIdle to set
     */
    public void setTestWhileIdle(boolean testWhileIdle) {
        this.testWhileIdle = testWhileIdle;
    }

    /**
     * @return the testOnBorrow
     */
    public boolean isTestOnBorrow() {
        return testOnBorrow;
    }

    /**
     * @param testOnBorrow the testOnBorrow to set
     */
    public void setTestOnBorrow(boolean testOnBorrow) {
        this.testOnBorrow = testOnBorrow;
    }

    /**
     * @return the testOnReturn
     */
    public boolean isTestOnReturn() {
        return testOnReturn;
    }

    /**
     * @param testOnReturn the testOnReturn to set
     */
    public void setTestOnReturn(boolean testOnReturn) {
        this.testOnReturn = testOnReturn;
    }

    /**
     * @return the validationQuery
     */
    public String getValidationQuery() {
        return validationQuery;
    }

    /**
     * @param validationQuery the validationQuery to set
     */
    public void setValidationQuery(String validationQuery) {
        this.validationQuery = validationQuery;
    }

    /**
     * @return the timeBetweenEvictionRunsMillis
     */
    public int getTimeBetweenEvictionRunsMillis() {
        return timeBetweenEvictionRunsMillis;
    }

    /**
     * @param timeBetweenEvictionRunsMillis the timeBetweenEvictionRunsMillis to set
     */
    public void setTimeBetweenEvictionRunsMillis(int timeBetweenEvictionRunsMillis) {
        this.timeBetweenEvictionRunsMillis = timeBetweenEvictionRunsMillis;
    }

    /**
     * @return the removeAbandonedTimeout
     */
    public int getRemoveAbandonedTimeout() {
        return removeAbandonedTimeout;
    }

    /**
     * @param removeAbandonedTimeout the removeAbandonedTimeout to set
     */
    public void setRemoveAbandonedTimeout(int removeAbandonedTimeout) {
        this.removeAbandonedTimeout = removeAbandonedTimeout;
    }

    /**
     * @return the logAbandoned
     */
    public boolean isLogAbandoned() {
        return logAbandoned;
    }

    /**
     * @param logAbandoned the logAbandoned to set
     */
    public void setLogAbandoned(boolean logAbandoned) {
        this.logAbandoned = logAbandoned;
    }

    /**
     * @return the minEvictableIdleTimeMillis
     */
    public int getMinEvictableIdleTimeMillis() {
        return minEvictableIdleTimeMillis;
    }

    /**
     * @param minEvictableIdleTimeMillis the minEvictableIdleTimeMillis to set
     */
    public void setMinEvictableIdleTimeMillis(int minEvictableIdleTimeMillis) {
        this.minEvictableIdleTimeMillis = minEvictableIdleTimeMillis;
    }

    /**
     * @return the minIdle
     */
    public int getMinIdle() {
        return minIdle;
    }

    /**
     * @param minIdle the minIdle to set
     */
    public void setMinIdle(int minIdle) {
        this.minIdle = minIdle;
    }

    /**
     * @return the initialSize
     */
    public int getInitialSize() {
        return initialSize;
    }

    /**
     * @param initialSize the initialSize to set
     */
    public void setInitialSize(int initialSize) {
        this.initialSize = initialSize;
    }

    /**
     * @return the validationQueryTimeout
     */
    public int getValidationQueryTimeout() {
        return validationQueryTimeout;
    }

    /**
     * @param validationQueryTimeout the validationQueryTimeout to set
     */
    public void setValidationQueryTimeout(int validationQueryTimeout) {
        this.validationQueryTimeout = validationQueryTimeout;
    }

    /**
     * @return the removeAbandonedOnBorrow
     */
    public boolean isRemoveAbandonedOnBorrow() {
        return removeAbandonedOnBorrow;
    }

    /**
     * @param removeAbandonedOnBorrow the removeAbandonedOnBorrow to set
     */
    public void setRemoveAbandonedOnBorrow(boolean removeAbandonedOnBorrow) {
        this.removeAbandonedOnBorrow = removeAbandonedOnBorrow;
    }

    /**
     * @return the maxTotal
     */
    public int getMaxTotal() {
        return maxTotal;
    }

    /**
     * @param maxTotal the maxTotal to set
     */
    public void setMaxTotal(int maxTotal) {
        this.maxTotal = maxTotal;
    }

    /**
     * @return the maxWaitMillis
     */
    public int getMaxWaitMillis() {
        return maxWaitMillis;
    }

    /**
     * @param maxWaitMillis the maxWaitMillis to set
     */
    public void setMaxWaitMillis(int maxWaitMillis) {
        this.maxWaitMillis = maxWaitMillis;
    }

    /**
     * @return the maxConnLifetimeMillis
     */
    public int getMaxConnLifetimeMillis() {
        return maxConnLifetimeMillis;
    }

    /**
     * @param maxConnLifetimeMillis the maxConnLifetimeMillis to set
     */
    public void setMaxConnLifetimeMillis(int maxConnLifetimeMillis) {
        this.maxConnLifetimeMillis = maxConnLifetimeMillis;
    }

    /**
     * @return the rutaBase
     */
    public String getRutaBase() {
        return rutaBase;
    }

    /**
     * @param rutaBase the rutaBase to set
     */
    public void setRutaBase(String rutaBase) {
        this.rutaBase = rutaBase;
    }

    /**
     * @return the urlLogService
     */
    public String getUrlLogService() {
        return urlLogService;
    }

    /**
     * @param urlLogService the urlLogService to set
     */
    public void setUrlLogService(String urlLogService) {
        this.urlLogService = urlLogService;
    }
}