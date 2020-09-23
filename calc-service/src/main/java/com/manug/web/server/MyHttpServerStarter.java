package com.manug.web.server;

import com.manug.calculator.CalculatorHelper;
import com.sun.net.httpserver.HttpContext;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpServer;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;

import static java.lang.Double.parseDouble;
import static java.lang.String.format;
import static java.util.Objects.isNull;

public class MyHttpServerStarter {

    public static void main(String[] args) throws IOException {
        HttpServer server = HttpServer.create(new InetSocketAddress(8500), 0);
        HttpContext context = server.createContext("/");
        context.setHandler(MyHttpServerStarter::handleRequest);
        System.out.println(format("starting %s..", MyHttpServerStarter.class.getSimpleName()));
        server.start();
    }

    private static void handleRequest(HttpExchange exchange) throws IOException {
        final String urlPath = exchange.getRequestURI().getPath();
        String[] pathParts = urlPath.split("/");
        final String response = evaluateResponse(pathParts);
        exchange.sendResponseHeaders(200, response.getBytes().length);//response code and length
        OutputStream os = exchange.getResponseBody();
        os.write(response.getBytes());
        os.close();
    }

    private static String evaluateResponse(String[] pathParts) {
        if (isNull(pathParts)) {
            return usage();
        }
        return checkUrlAndFindResponse(pathParts);
    }

    private static String checkUrlAndFindResponse(String[] pathParts) {
        if (pathParts.length<3) {
            return usage();
        }
        switch (pathParts[1]) {
            case "calculator":
                try {
                    return new CalculatorHelper(
                            pathParts[2],
                            pathParts.length>3 ? parseDouble(pathParts[3]) : 0.0,
                            pathParts.length>4 ? parseDouble(pathParts[4]) : 0.0
                    ).calculate();
                } catch (Exception e) {
                    return e.getMessage();
                }
            default:
                return format("Hi there! You seem lost.%s%s", System.lineSeparator(), usage());
        }
    }

    private static String usage() {
        return format(
                "Welcome to calculator!"
                        + "%sSome examples:"
                        + "%s\t/calculator/square/5"
                        + "%s\t/calculator/add/5/10"
                , System.lineSeparator()
                , System.lineSeparator()
                , System.lineSeparator()
        );
    }
}