package com.alpms.al_paper_management.support.repository;

import com.alpms.al_paper_management.support.model.SupportRequest;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SupportRequestRepository extends JpaRepository<SupportRequest, Long> {
}
