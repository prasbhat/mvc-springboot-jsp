package com.myzonesoft.todo.mvc.controller;

import com.myzonesoft.todo.mvc.model.Tasks;
import com.myzonesoft.todo.mvc.util.TodoApplicationConstants;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import java.text.MessageFormat;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.List;

/**
 * TodoViewController is the Controller class for the To-do Tracker Application.
 * This class is responsible for communication between the JSP pages and the other Controller.
 *
 */
@RestController
@SuppressWarnings("unused")
public class TodoViewController implements TodoApplicationConstants {

    //Variable declarations
    private static final Logger LOGGER = LoggerFactory.getLogger(TodoViewController.class);
    private final String className = this.getClass().getSimpleName();

    @Autowired
    private TodoController todoController;

    /**
     * Method for redirecting to the index.jsp page
     * This method accepts HTTP_REQUEST_METHOD:GET
     * @param model required for ModelAndView
     *
     * @return Redirection to index.jsp using ModelAndView
     */
    @GetMapping
    public ModelAndView gotoHome(ModelMap model) {
        String methodName = Thread.currentThread().getStackTrace()[1].getMethodName();
        LOGGER.info(MessageFormat.format(LOGGER_ENTRY, className, methodName));
        model.put("todoList", todoController.getAllTasks().getBody());
        LOGGER.info(MessageFormat.format(LOGGER_EXIT, className, methodName));
        return new ModelAndView("index");
    }

    /**
     * Method for redirecting to the singleItemPage.jsp page
     * This method accepts HTTP_REQUEST_METHOD:GET
     * @param action can be view/edit
     * @param todoId Id of the To-do Task selected
     * @param model required for ModelAndView
     *
     * @return Redirection to singleViewPage.jsp using ModelAndView
     */
    @GetMapping("/singleItemView/{action}/{todoId}")
    public ModelAndView goToSingleItemView(ModelMap model, @PathVariable("action") String action,
                                           @PathVariable("todoId") Long todoId){
        String methodName = Thread.currentThread().getStackTrace()[1].getMethodName();
        LOGGER.info(MessageFormat.format(LOGGER_ENTRY, className, methodName));
        Tasks todoItem = Tasks.builder().title("").description("").dueDate(null).status("").build();
        if(todoId > 0) {
            todoItem = todoController.getTasksById(todoId).getBody();
        }
        model.put("todoItem", todoItem);
        model.put("action",action);
        model.put("todoStatus",todoController.getTaskStatus().getBody());
        LOGGER.info(MessageFormat.format(LOGGER_EXIT, className, methodName));
        return new ModelAndView("singleItemPage");
    }

    @PostMapping("/create")
    public void sendToCreate(ModelMap model, @RequestBody Tasks todoItem) {
        String methodName = Thread.currentThread().getStackTrace()[1].getMethodName();
        LOGGER.info(MessageFormat.format(LOGGER_ENTRY, className, methodName));
        LOGGER.debug("TodoObject="+todoItem);
        todoController.createTodoTask(todoItem);
        LOGGER.info(MessageFormat.format(LOGGER_EXIT, className, methodName));
        gotoHome(model);
    }

    @PutMapping("/update")
    public void sendToUpdate(ModelMap model, @RequestBody Tasks todoItem) {
        String methodName = Thread.currentThread().getStackTrace()[1].getMethodName();
        LOGGER.info(MessageFormat.format(LOGGER_ENTRY, className, methodName));
        LOGGER.debug("TodoObject="+todoItem);
        todoController.updateTaskItem(todoItem);
        LOGGER.info(MessageFormat.format(LOGGER_EXIT, className, methodName));
        gotoHome(model);
    }

    @DeleteMapping("/deleteById/{id}")
    public void sendToDeleteById(ModelMap model, @PathVariable long id) {
        String methodName = Thread.currentThread().getStackTrace()[1].getMethodName();
        LOGGER.info(MessageFormat.format(LOGGER_ENTRY, className, methodName));
        todoController.deleteTaskById(id);
        LOGGER.info(MessageFormat.format(LOGGER_EXIT, className, methodName));
        gotoHome(model);
    }
}
