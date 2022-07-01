package com.myzonesoft.todo.mvc.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class TodoTaskComments {
    /**
     * Unique Identifier for the To-do task Comments
     */
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long todoTaskCommentsId;

    private String taskComments;
    private LocalDate creationDate;

    @JsonBackReference
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="systemTasksId", nullable=false)
    private Tasks todoTask;

    @Override
    public String toString() {
        return "TodoTaskComments{" + "todoTaskCommentsId=" + todoTaskCommentsId +
                ", taskComments='" + taskComments + '\'' +
                ", creationDate=" + creationDate +
                '}';
    }
}
