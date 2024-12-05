package hello;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class HelloControllerTest {

    private HelloController subject;

    @Before
    public void setup() {
        subject = new HelloController();
    }

    @Test
    public void testGetHelloMessage() {
        assertEquals("Hello world!", subject.getHelloMessage(null));
    }

    @Test
    public void testGetGoodbyeMessage() {
        assertEquals("Goodbye world!", subject.getGoodbyeMessage());
    }
}