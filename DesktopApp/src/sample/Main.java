package sample;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class Main extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception{
        Parent root = FXMLLoader.load(getClass().getResource("BO_Newsletter.fxml"));
        primaryStage.setTitle("CineMates20 By MezMar - BackOffice Login");
        primaryStage.setScene(new Scene(root, 640, 385));
        primaryStage.show();
    }


    public static void main(String[] args) {
        launch(args);
    }
}
