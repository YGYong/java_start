package com.ygyong.task_manager.service;

import com.ygyong.task_manager.dto.TaskResponse;
import com.ygyong.task_manager.entity.Task;
import com.ygyong.task_manager.exception.TaskNotFoundException;
import com.ygyong.task_manager.repository.TaskQueryRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class TaskQueryService {
    private final TaskQueryRepository taskQueryRepository;

    public TaskQueryService(TaskQueryRepository taskQueryRepository) {
        this.taskQueryRepository = taskQueryRepository;
    }

//    public List<TaskResponse> getTasks() {
//        List<Task> tasks = taskQueryRepository.findAll();
//        List<TaskResponse> taskResponses = new ArrayList<>();
//
//        for (Task task : tasks) {
//            TaskResponse taskResponse = new TaskResponse(task.getId(), task.getTitle(), task.isCompleted());
//            taskResponses.add(taskResponse);
//        }
//        return taskResponses;
//    }

    public List<TaskResponse> getTasks(Boolean completed, String keyword) {

        if(keyword != null) {
            keyword = keyword.strip();
        }

        List<Task> tasks = taskQueryRepository.findByConditions(completed,keyword);
        List<TaskResponse> taskResponses = new ArrayList<>();

        for (Task task : tasks) {
            TaskResponse taskResponse = new TaskResponse(task.getId(), task.getTitle(), task.isCompleted());
            taskResponses.add(taskResponse);
        }
        return taskResponses;
    }

    public TaskResponse getTaskById(int id) {
        Task task = taskQueryRepository.findById(id);
        if (task != null) {
            return new TaskResponse(task.getId(), task.getTitle(), task.isCompleted());
        }
        throw new TaskNotFoundException("Task not found with id: " + id);
    }
}
