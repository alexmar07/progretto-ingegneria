package sample;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class JUnitTest {

    @Test
    void doLoginTestUsernamePasswordCorretti() {
        try {
            Service.doLogin("administrator","password");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    void doLoginTestUsernamePasswordErrati() {
        try {
            Service.doLogin("egewga","asfewehwe");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    void doLoginTestUsernameValidoPasswordNonValida() {
        try {
            Service.doLogin("administrator","asfewehwe");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    void doLoginTestUsernamePasswordNulli() {
        try {
            Service.doLogin("","");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}