package sample;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;

import java.io.IOException;


public class Auth_Controller {

    @FXML
    private Button btnLogin;

    @FXML
    void doLogin(ActionEvent event) {
        try {
            Service.sendPOST();

        }
        catch (Exception e)  {
            System.out.println(e.getMessage());
        }
    }
}
