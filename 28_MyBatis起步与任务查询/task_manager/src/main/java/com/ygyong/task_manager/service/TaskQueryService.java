package com.ygyong.task_manager.service;

import com.ygyong.task_manager.dto.TaskResponse;
import com.ygyong.task_manager.entity.Task;
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

    public List<TaskResponse> getTasks() {
        List<Task> tasks = taskQueryRepository.findAll();
        List<TaskResponse> taskResponses = new ArrayList<>();

        for (Task task : tasks) {
            TaskResponse taskResponse = new TaskResponse(task.getId(), task.getTitle(), task.isCompleted());
            taskResponses.add(taskResponse);
        }
        return taskResponses;
    }
}
