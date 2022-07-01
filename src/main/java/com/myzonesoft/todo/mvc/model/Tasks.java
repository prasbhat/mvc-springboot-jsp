package com.myzonesoft.todo.mvc.model;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.Set;

/**
 * To-do POJO model class
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
@Entity
@SuppressWarnings("unused")
public class Tasks {
    /**
     * Unique Identifier for the To-do task
     */
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long systemTasksId;
    /**
     * Title for the To-do task
     */
    private String title;
    /**
     * Description for the To-do task
     */
    private String description;
    /**
     * Creation date- System generated
     */
    private LocalDate creationDate;
    /**
     * Due date for the To-do task
     */
    private LocalDate dueDate;
    /**
     * Status of the To-do task
     */
    private String status;

    @JsonManagedReference
    @OneToMany(mappedBy = "todoTask", fetch = FetchType.EAGER)
    private Set<TodoTaskComments> todoTaskCommentsSet;
}
