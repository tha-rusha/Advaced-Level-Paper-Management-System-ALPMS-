package com.alpms.al_paper_management.support.controller;

import com.alpms.al_paper_management.support.model.SupportRequest;
import com.alpms.al_paper_management.support.service.SupportRequestService;
import jakarta.validation.Valid;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/support")
public class SupportController {

    private final SupportRequestService service;

    public SupportController(SupportRequestService service) {
        this.service = service;
    }

    // 🧑‍🎓 student form
    @GetMapping
    public String showSupportForm(Model model, Authentication auth) {
        model.addAttribute("supportRequest", new SupportRequest());
        model.addAttribute("userEmail",
                auth != null ? auth.getName() : "");
        return "support/student-support";
    }

    // form submit
    @PostMapping
    public String submitSupportForm(
            @Valid @ModelAttribute("supportRequest") SupportRequest supportRequest,
            BindingResult result,
            RedirectAttributes ra,
            Authentication auth,
            Model model) {

        if (auth != null && (supportRequest.getEmail() == null || supportRequest.getEmail().isBlank())) {
            supportRequest.setEmail(auth.getName());
        }

        if (result.hasErrors()) {
            model.addAttribute("userEmail", auth != null ? auth.getName() : "");
            return "support/student-support";
        }

        service.save(supportRequest);
        ra.addFlashAttribute("success",
                "Your request has been submitted. Our team will contact you soon.");
        return "redirect:/support";
    }

    // 👩‍🏫 optional: staff view of all requests
    @GetMapping("/admin")
    public String listRequests(Model model) {
        model.addAttribute("requests", service.findAll());
        return "support/admin-list";
    }

    // optional: change status
    @PostMapping("/{id}/status")
    public String changeStatus(@PathVariable Long id,
                               @RequestParam SupportRequest.Status status) {
        service.changeStatus(id, status);
        return "redirect:/support/admin";
    }
}
