package com.codepresso.codepresso.controller.branch;

import com.codepresso.codepresso.entity.branch.Branch;
import com.codepresso.codepresso.service.branch.BranchService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/branch")
public class BranchController {

    private final BranchService branchService;

    public BranchController(BranchService branchService) {
        this.branchService = branchService;
    }

    @GetMapping("/list")
    public String list(Model model) {
        int page = 0;
        int size = 6;
        Page<Branch> branchPage = branchService.getBranchPage(page, size);
        model.addAttribute("branches", branchPage.getContent());
        model.addAttribute("nextPage", branchPage.hasNext() ? page + 1 : null);
        model.addAttribute("pageSize", size);
        model.addAttribute("hasNext", branchPage.hasNext());
        return "branch/branch-list";
    }

    @GetMapping("/page")
    public String page(int page, Integer size, Model model, HttpServletResponse response) {
        int pageSize = (size == null || size <= 0) ? 6 : size;
        Page<Branch> branchPage = branchService.getBranchPage(page, pageSize);
        model.addAttribute("branches", branchPage.getContent());
        response.setHeader("X-Has-Next", String.valueOf(branchPage.hasNext()));
        // 카드 목록만 렌더링하는 JSP (fragment)
        return "branch/branch-cards";
    }
}
