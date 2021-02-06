package sample;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javafx.beans.Observable;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class Service {

    private static final String USER_AGENT = "Mozilla/5.0" ;
    private static final String REQUEST_URL = "https://alessandro.samagtech.dev/api/";

    public static void doLogin(String username, String password) throws Exception {

        URL obj = new URL(REQUEST_URL + "login");
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("User-Agent", USER_AGENT);
        con.setRequestProperty("Accept", "application/json");

        String params = "username=" + username + "&password=" + password;

        // For POST only - START
        con.setDoOutput(true);
        OutputStream os = con.getOutputStream();
        os.write(params.getBytes());
        os.flush();
        os.close();
        // For POST only - END

        int responseCode = con.getResponseCode();

        System.out.println("POST Response Code :: " + responseCode);

        if (responseCode == HttpURLConnection.HTTP_OK) { //success
            BufferedReader in = new BufferedReader(new InputStreamReader(
                    con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                System.out.println(inputLine);
                response.append(inputLine);
            }

            in.close();

            JSONObject json = new JSONObject(response.toString());

            if ( ! json.getBoolean("success")) {
                throw new Exception(json.getString("message"));
            }

            UsersSingleton usersSingleton = UsersSingleton.getInstance();
            usersSingleton.setJwt(json.getJSONObject("data").getString("jwt"));

        } else {
            System.out.println("POST request not worked");
        }
    }

    public static String sendNewsletter(String subject, String body ) throws IOException, JSONException {

        URL obj = new URL(REQUEST_URL + "users/newsletter");
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("User-Agent", USER_AGENT);
        con.setRequestProperty("Accept", "application/json");
        con.setRequestProperty("Authorization", UsersSingleton.getInstance().getJwt());

        String params = "subject=" + subject + "&body=" + body;

        // For POST only - START
        con.setDoOutput(true);
        OutputStream os = con.getOutputStream();
        os.write(params.getBytes());
        os.flush();
        os.close();
        // For POST only - END

        int responseCode = con.getResponseCode();

        System.out.println("POST Response Code :: " + responseCode);

        if (responseCode == HttpURLConnection.HTTP_OK) { //success
            BufferedReader in = new BufferedReader(new InputStreamReader(
                    con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                System.out.println(inputLine);
                response.append(inputLine);
            }

            in.close();

            JSONObject json = new JSONObject(response.toString());

            return json.getString("message");
        }
        else {
           return "Errore durante la richiesta";
        }
    }

    public static ObservableList<Users> getUsers() throws JSONException, IOException {

        ObservableList<Users> usersList = FXCollections.observableArrayList();

        URL obj = new URL(REQUEST_URL + "users/list?page=1&newsletter=1");

        System.out.println(obj.toString());
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("User-Agent", USER_AGENT);
        con.setRequestProperty("Accept", "application/json");
        con.setRequestProperty("Authorization", UsersSingleton.getInstance().getJwt());

        int responseCode = con.getResponseCode();

        System.out.println("GET Response Code :: " + responseCode);

        if (responseCode == HttpURLConnection.HTTP_OK) { //success
            BufferedReader in = new BufferedReader(new InputStreamReader(
                    con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                System.out.println(inputLine);
                response.append(inputLine);
            }

            in.close();
            System.out.println(response.toString());
            JSONObject json = new JSONObject(response.toString());
            JSONArray data = json.getJSONArray("data");
            System.out.println(data);
            for ( int i = 0; i < data.length(); i++ ) {
                JSONObject user = data.getJSONObject(i);
                usersList.add(
                        new Users(user.getString("first_name") + " " + user.getString("last_name"), user.getString("username"), user.getString("email") )
                );
            }

        } else {
            System.out.println("POST request not worked");
        }

        return usersList;
    }
}
