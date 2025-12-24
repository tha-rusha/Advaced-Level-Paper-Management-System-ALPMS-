package com.alpms.al_paper_management.support.service;

import com.alpms.al_paper_management.support.model.SupportRequest;
import com.alpms.al_paper_management.support.repository.SupportRequestRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SupportRequestService {

    private final SupportRequestRepository repo;

    public SupportRequestService(SupportRequestRepository repo) {
        this.repo = repo;
    }

    public SupportRequest save(SupportRequest r) {
        return repo.save(r);
    }

    public List<SupportRequest> findAll() {
        return repo.findAll();
    }

    public SupportRequest get(Long id) {
        return repo.findById(id).orElseThrow();
    }

    public void changeStatus(Long id, SupportRequest.Status status) {
        SupportRequest r = get(id);
        r.setStatus(status);
        repo.save(r);
    }
}
