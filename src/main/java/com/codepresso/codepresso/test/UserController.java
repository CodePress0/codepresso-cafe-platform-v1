
package com.codepresso.codepresso.test;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

//@Controller  // 메인 UserController와 충돌 방지를 위해 주석 처리
@RequiredArgsConstructor
public class UserController {
    private final MybatisService mybatisService;

    @GetMapping("/")
    public String home(Model model) {
        try {
            List<TestUser> users = this.mybatisService.getAllUsers();
            model.addAttribute("users", users);
            return "test/testindex";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "error";
        }
    }

    @GetMapping("/user")
    public String getUserById(@RequestParam Long id, Model model) {
        try {
            TestUser user = this.mybatisService.getUserById(id);
            model.addAttribute("user", user);
            return "test/user";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "error";
        }
    }

    @PostMapping("/user")
    public String addUser(@RequestParam String name, @RequestParam String email, Model model) {
        try {
            this.mybatisService.createUser(name, email);
            return "redirect:/";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("users", this.mybatisService.getAllUsers());
            return "test/testindex";
        }
    }

}
