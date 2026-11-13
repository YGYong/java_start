package com.ygyong.task_manager.service;

import com.ygyong.task_manager.exception.TaskNotFoundException;
import com.ygyong.task_manager.repository.TaskDeleteRepository;
import org.springframework.stereotype.Service;

@Service
public class TaskDeleteService {
    private final TaskDeleteRepository taskDeleteRepository;

    public TaskDeleteService(TaskDeleteRepository taskDeleteRepository) {
        this.taskDeleteRepository = taskDeleteRepository;
    }

    public boolean deleteTask(int id) {
        int rowsAffected = taskDeleteRepository.deleteById(id);

        if(rowsAffected == 1) {
            return true;
        }else if(rowsAffected == 0) {
            throw new TaskNotFoundException("Task with id " + id + " does not exist.");
        }else {
            throw new IllegalStateException("Unexpected number of rows affected: " + rowsAffected);
        }
    }
}
