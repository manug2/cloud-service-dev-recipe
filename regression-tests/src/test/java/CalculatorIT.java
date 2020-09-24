import org.junit.BeforeClass;
import org.junit.Test;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import static org.junit.Assert.assertEquals;

public class CalculatorIT {

    static String baseURL=null;
    @BeforeClass public static void setBaseURL() {
        baseURL = System.getProperty("test.calc.service.url", "http://localhost:8500");
    }

    @Test public void should_square() throws Exception {
        final String result = get(baseURL + "/calculator/square/6");
        assertEquals(36.0, Double.parseDouble(result), 0.0000001);
    }

    private static String get(String uri) throws Exception {
        URL obj = new URL(uri);

        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        con.setRequestMethod("GET");
        int responseCode = con.getResponseCode();
        System.out.println("GET Response Code :: " + responseCode);
        if (responseCode == HttpURLConnection.HTTP_OK) { // success
            BufferedReader in = new BufferedReader(new InputStreamReader(
                    con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // print result
            System.out.println(response.toString());
            return response.toString();
        } else {
            System.out.println("GET request not worked");
            throw new RuntimeException("error http response" + responseCode);
        }
    }
}
