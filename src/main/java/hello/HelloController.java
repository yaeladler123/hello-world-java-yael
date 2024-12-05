package hello;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class HelloController {

    public static final String DEFAULT_NAME = "world";

    @RequestMapping("/")
    public String index() {
        return this.getHelloMessage() + " This is a Guide-Rails demo application for Java/Gradle!";
    }

    /**
     * @param name optional name of the message's intended recipient
     * @return a message string
     */
    public String getHelloMessage(String name) {
        if ((name == null) || (name.trim().length() == 0)) {
            name = DEFAULT_NAME.trim();
        } else {
            name = name.trim();
        }
        return "Hello " + name + "!";
    }

    public String getHelloMessage() {
        return this.getHelloMessage(null);
    }

    /**
     * @param name optional name of the message's intended recipient
     * @return a message string
     */
    public String getGoodbyeMessage(String name) {
        if ((name == null) || (name.trim().length() == 0)) {
            name = DEFAULT_NAME.trim();
        } else {
            name = name.trim();
        }
        return "Goodbye " + name + "!";
    }

    public String getGoodbyeMessage() {
        return this.getGoodbyeMessage(null);
    }

}
