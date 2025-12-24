package com.alpms.al_paper_management.subjects.controller;


import com.alpms.al_paper_management.subjects.model.Subject;
import com.alpms.al_paper_management.subjects.service.SubjectService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/subjects")
public class SubjectController {

    private final SubjectService service;
    public SubjectController(SubjectService service) { this.service = service; }

    @GetMapping
    public String list(Model model) {
        model.addAttribute("subjects", service.findAll());
        return "subjects/list";
    }

    @GetMapping("/new")
    public String createForm(Model model) {
        model.addAttribute("subject", new Subject());
        model.addAttribute("streams", Subject.Stream.values());
        return "subjects/new";
    }

    @PostMapping
    public String create(@Valid @ModelAttribute("subject") Subject subject,
                         BindingResult result,
                         Model model) {
        if (result.hasErrors()) {
            model.addAttribute("streams", Subject.Stream.values());
            return "subjects/new";
        }
        service.save(subject);
        return "redirect:/subjects";
    }
    // 🔹 NEW: Edit form
    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) {
        Subject subject = service.findById(id);      // uses new service method
        model.addAttribute("subject", subject);
        model.addAttribute("streams", Subject.Stream.values());
        return "subjects/edit";                      // we’ll create this view
    }

    // 🔹 NEW: Handle update
    @PostMapping("/{id}")
    public String update(@PathVariable Long id,
                         @Valid @ModelAttribute("subject") Subject subject,
                         BindingResult result,
                         Model model) {
        if (result.hasErrors()) {
            model.addAttribute("streams", Subject.Stream.values());
            return "subjects/edit";
        }

        subject.setId(id);        // make sure it updates, not insert new
        service.save(subject);    // same save() used for create & update

        return "redirect:/subjects";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) {
        service.delete(id);
        return "redirect:/subjects";
    }


}

