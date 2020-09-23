package com.manug.calculator;

import static java.lang.String.format;

public class CalculatorHelper {

    private final String op;
    private final double arg1;
    private final double arg2;

    public CalculatorHelper(String op, double arg1, double arg2) {
        this.op = op;
        this.arg1 = arg1;
        this.arg2 = arg2;
    }

    public String calculate() {
        return "" + calculate0();
    }

    private double calculate0() {
        switch(op) {
            case "square": return new Calculator().square(arg1);
            case "sqrt": return new Calculator().sqrt(arg1);
            case "add": return new Calculator().add(arg1, arg2);
            case "multiply": return new Calculator().multiply(arg1, arg2);
            default:
                throw new IllegalArgumentException(format("calculation of type '%s' is not supported", op));
        }
    }
}
