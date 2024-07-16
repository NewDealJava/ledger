package com.newdeal.ledger.global.exception;

import org.springframework.http.HttpStatus;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class LedgerAPIException extends RuntimeException {
  private HttpStatus status;
  private String message;
}