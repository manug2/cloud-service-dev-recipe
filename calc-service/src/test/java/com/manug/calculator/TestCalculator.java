package com.manug.calculator;

import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class TestCalculator {

    @Test
    public void should_square() {
        assertEquals(25.0, new Calculator().square(5.0), 0.0000001);
    }

    @Test
    public void should_add() {
        assertEquals(15.0, new Calculator().add(10.0, 5.0), 0.0000001);
    }
}
