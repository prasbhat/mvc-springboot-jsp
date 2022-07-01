package com.myzonesoft.todo.mvc.repository;

import com.myzonesoft.todo.mvc.model.TodoTaskComments;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TodoTaskCommentsRepository extends JpaRepository<TodoTaskComments, Long> {

}
