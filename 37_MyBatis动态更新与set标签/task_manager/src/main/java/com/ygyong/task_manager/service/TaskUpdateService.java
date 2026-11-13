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

    public boolean updateTask(int taskId, String title, Boolean completed) {
        if (title == null && completed == null) {
            throw new IllegalArgumentException("至少提供一个要更新的字段");
        }
        if (title != null) {
            title = title.strip();
            if (title.isBlank()) {
                throw new IllegalArgumentException("任务标题不能为空白");
            }
            if (title.length() > 100) {
                throw new IllegalArgumentException("任务标题不能超过100个字符");
            }
        }

        int updateCount = taskUpdateRepository.updateTask(taskId, title, completed);
        if (updateCount == 1) {
            return true;
        }
        if (updateCount == 0) {
            // 重复设置相同值也视为成功，兼容不同连接配置的行数口径。
            Task task = taskQueryRepository.findById(taskId);
            if (task == null) {
                throw new TaskNotFoundException("Task with ID " + taskId + " not found");
            }
            boolean titleMatches = title == null || title.equals(task.getTitle());
            boolean completedMatches = completed == null || completed == task.isCompleted();
            if (titleMatches && completedMatches) {
                return true;
            }
            throw new IllegalStateException("任务更新失败，当前值与目标值不一致");
        }
        throw new IllegalStateException("任务更新影响行数异常：" + updateCount);
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
