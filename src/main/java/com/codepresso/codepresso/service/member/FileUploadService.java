package com.codepresso.codepresso.service.member;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Service
public class FileUploadService {

    @Value("${file.upload.path:uploads/profile/}")
    private String uploadPath;

    public String uploadProfileImage(MultipartFile file, Long memberId) throws IOException {
        if (file.isEmpty()) {
            throw new IllegalArgumentException("파일이 비어있습니다.");
        }

        // 파일 확장자 검증
        String originalFilename = file.getOriginalFilename();
        if (originalFilename == null || !isImageFile(originalFilename)) {
            throw new IllegalArgumentException("이미지 파일만 업로드 가능합니다.");
        }

        // 업로드 디렉토리 생성
        Path uploadDir = Paths.get(uploadPath);
        if (!Files.exists(uploadDir)) {
            Files.createDirectories(uploadDir);
        }

        // 파일명 생성 (UUID + 확장자)
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String filename = "profile_" + memberId + "_" + UUID.randomUUID().toString() + extension;

        // 파일 저장
        Path filePath = uploadDir.resolve(filename);
        Files.write(filePath, file.getBytes());

        // 웹 접근 경로 반환
        return "/uploads/profile/" + filename;
    }

    public void deleteProfileImage(String imageUrl) {
        if (imageUrl == null || imageUrl.isEmpty()) {
            return;
        }

        try {
            // URL에서 파일명 추출
            String filename = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
            Path filePath = Paths.get(uploadPath, filename);

            if (Files.exists(filePath)) {
                Files.delete(filePath);
            }
        } catch (Exception e) {
            // 파일 삭제 실패는 로그만 남기고 예외 발생시키지 않음
            System.err.println("프로필 이미지 삭제 실패: " + e.getMessage());
        }
    }

    private boolean isImageFile(String filename) {
        String extension = filename.toLowerCase().substring(filename.lastIndexOf(".") + 1);
        return extension.matches("jpg|jpeg|png|gif|bmp|webp");
    }
}