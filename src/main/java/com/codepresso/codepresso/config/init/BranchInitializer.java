package com.codepresso.codepresso.config.init;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@Order(100)
public class BranchInitializer implements ApplicationRunner {
    @Override
    public void run(ApplicationArguments args) {
        log.info("[Init] BranchInitializer executed");
        // TODO: Branch 초기 데이터는 각자가 구현
    }
}

