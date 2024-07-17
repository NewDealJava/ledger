package com.newdeal.ledger.global.logging;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Aspect
@Component
@Slf4j
public class LoggingAspect {

	private static final Logger highlightLogger = LoggerFactory.getLogger("highlightLogger");

	@Pointcut("execution(* *(..)) && @within(org.springframework.web.bind.annotation.RestController)")
	public void restControllerMethods() {}

	@Before("restControllerMethods()")
	public void logBefore(JoinPoint joinPoint) {
		Object[] args = joinPoint.getArgs();
		highlightLogger.info("Method {} called with arguments: {}", joinPoint.getSignature().toShortString(), args);
	}

	@AfterReturning(pointcut = "restControllerMethods()", returning = "result")
	public void logAfterReturning(JoinPoint joinPoint, Object result) {
		highlightLogger.info("Method {} returned: {}", joinPoint.getSignature().toShortString(), result);
	}
}
