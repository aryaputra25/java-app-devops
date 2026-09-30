import com.sun.net.httpserver.HttpServer;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;

public class Main {

    public static void main(String[] args) throws IOException {

        HttpServer server = HttpServer.create(
            new InetSocketAddress(8081),
            0
        );

        server.createContext("/", exchange -> {

            String response = "DevOps Ver 2grep -n "8081\|HttpServer\|createContext" Main.java";

            exchange.sendResponseHeaders(
                200,
                response.getBytes().length
            );

            OutputStream output = exchange.getResponseBody();

            output.write(response.getBytes());

            output.close();
        });

        server.start();

        System.out.println("Server running on port 8081");
    }
}
