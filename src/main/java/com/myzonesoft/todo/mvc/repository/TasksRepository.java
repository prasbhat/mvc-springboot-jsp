package com.myzonesoft.todo.mvc.repository;

import com.myzonesoft.todo.mvc.model.Tasks;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TasksRepository extends JpaRepository<Tasks, Long> {

}
