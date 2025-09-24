package com.codepresso.codepresso.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 웹 설정
 */

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Value("${app.file.upload.path}")
    private String uploadPath;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 프로필 이미지 정적 리소스 설정
        registry.addResourceHandler("/uploads/profile-images/**")
                .addResourceLocations("file:" + uploadPath);
    }
}