package com.ygyong.task_manager.service;

import com.ygyong.task_manager.entity.Task;
import com.ygyong.task_manager.exception.TaskNotFoundException;
import com.ygyong.task_manager.repository.TaskQueryRepository;
import com.ygyong.task_manager.repository.TaskUpdateRepository;
import org.springframework.stereotype.Service;

@Service
public class TaskUpdateService {
    private final TaskUpdateRepository taskUpdateRepository;
    private final TaskQueryRepository taskQueryRepository;

    public TaskUpdateService(TaskUpdateRepository taskUpdateRepository, TaskQueryRepository taskQueryRepository) {
        this.taskUpdateRepository = taskUpdateRepository;
        this.taskQueryRepository = taskQueryRepository;
    }

    public boolean updateCompleted(int taskId, Boolean completed) {

        if(completed == null) {
            throw new IllegalArgumentException("Completed status cannot be null");
        }

        int updateCount = taskUpdateRepository.updateCompleted(taskId, completed);
        if (updateCount == 1) {
            return true;
        } else if (updateCount == 0) {
            // 调用现有 TaskQueryRepository.findById(taskId) 进一步判断
            Task task = taskQueryRepository.findById(taskId);
            if (task == null) {
                throw new TaskNotFoundException("Task with ID " + taskId + " not found");
            } else if (task.isCompleted() == completed) {
                return true; // 状态已经等于目标状态，允许重复设置
            } else {
                throw new IllegalStateException("Task update failed, current state does not match target state");
            }
        } else {
            throw new IllegalStateException("Unexpected update count: " + updateCount);
        }
    }
}
