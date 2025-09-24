package com.codepresso.codepresso.config.init;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@Order(200)
public class ProductInitializer implements ApplicationRunner {
    @Override
    public void run(ApplicationArguments args) {
        log.info("[Init] ProductInitializer executed");
        // TODO: Product 초기 데이터는 각자가 구현
    }
}

