package sample;

public class UsersSingleton {

    // Unica istanza della classe
    private static UsersSingleton instance = null;

    // Variable of type String
    private String jwt;

    // Costruttore invisibile
    private UsersSingleton() {}

    public static UsersSingleton getInstance() {
        // Crea l'oggetto solo se NON esiste:
        if (instance == null) {
            instance = new UsersSingleton();
        }
        return instance;
    }

    public void setJwt(String jwt ) {
        this.jwt = jwt;
    }

    public String getJwt() {
        return this.jwt;
    }
}
