package sample;

import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;
import org.json.JSONException;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class Newsletter_Controller implements Initializable {

    @FXML
    private Button btnNewsletter;

    @FXML
    private TextField txtSubject;

    @FXML
    private TextArea txtBody;

    @FXML
    private MenuItem btnLogout;

    @FXML
    private TableView<Users> tableUsers;

    @FXML
    private TableColumn<Users,String> colFullname;

    @FXML
    private TableColumn<Users,String> colUsername;

    @FXML
    private TableColumn<Users,String> colEmail;

    ObservableList<Users> usersList;

    @FXML
    void sendNewsletter(ActionEvent event) {

        try {
            String message = Service.sendNewsletter(txtSubject.getText(), txtBody.getText());

            Alert alert = new Alert(Alert.AlertType.INFORMATION);
            alert.setTitle("Info");
            alert.setHeaderText(null);
            alert.setContentText(message);
            alert.showAndWait();

        } catch (IOException e) {
            e.printStackTrace();
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    @FXML
    void doLogout(ActionEvent event) throws IOException {
        this.changeScene("BO_Login.fxml");
        UsersSingleton.getInstance().setJwt(null);
    }

    public void changeScene(String fxml) throws IOException {
        Parent pane = FXMLLoader.load(getClass().getResource(fxml));
        Stage stage = (Stage) btnNewsletter.getScene().getWindow();
        Scene scene = new Scene(pane);
        stage.setScene(scene);
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        try {
            this.usersList = Service.getUsers();

            colFullname.setCellValueFactory(new PropertyValueFactory<>("Fullname"));
            colUsername.setCellValueFactory(new PropertyValueFactory<>("Username"));
            colEmail.setCellValueFactory(new PropertyValueFactory<>("Email"));

            tableUsers.setItems(usersList);

        } catch (JSONException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
