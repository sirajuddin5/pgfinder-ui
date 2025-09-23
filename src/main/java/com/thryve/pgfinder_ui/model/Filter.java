package com.thryve.pgfinder_ui.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Filter {

    private String key;
    private String value;
    private Operation operation;
    private String joinObject;
    private JoinOperation joinOperation;

    // --- Enum for normal operations ---
    public enum Operation {
        EQUAL,
        DATE_EQUAL,
        DATE_BETWEEN,
        NOT_EQUAL,
        LIKE,
        IN,
        GREATER_THAN,
        LESS_THAN,
        BETWEEN,
        JOIN,
        DATE_GREATER_THAN_EQUAL_TO
    }

    // --- Enum for join operations ---
    public enum JoinOperation {
        EQUAL,
        DATE_EQUAL,
        LIKE,
        BETWEEN,
        DATE_GREATER_THAN_EQUAL_TO,
        DATE_LESS_THAN,
        DATE_BETWEEN
    }

    // --- Fluent setters for chaining ---
    public Filter setKey(String key) {
        this.key = key;
        return this;
    }

    public Filter setValue(String value) {
        this.value = value;
        return this;
    }

    public Filter setOperation(Operation operation) {
        this.operation = operation;
        return this;
    }

    public Filter setJoinObject(String joinObject) {
        this.joinObject = joinObject;
        return this;
    }

    public Filter setJoinOperation(JoinOperation joinOperation) {
        this.joinOperation = joinOperation;
        return this;
    }
}
