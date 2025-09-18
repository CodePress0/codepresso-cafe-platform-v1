package com.codepresso.codepresso.repository.branch;

import com.codepresso.codepresso.entity.branch.Branch;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BranchRepository extends JpaRepository<Branch, Long> {
}

