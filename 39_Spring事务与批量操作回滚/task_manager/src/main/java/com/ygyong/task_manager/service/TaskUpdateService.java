package com.ygyong.task_manager.service;

import com.ygyong.task_manager.entity.Task;
import com.ygyong.task_manager.exception.TaskNotFoundException;
import com.ygyong.task_manager.repository.TaskQueryRepository;
import com.ygyong.task_manager.repository.TaskUpdateRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;

@Service
public class TaskUpdateService {
    private final TaskUpdateRepository taskUpdateRepository;
    private final TaskQueryRepository taskQueryRepository;

    public TaskUpdateService(TaskUpdateRepository taskUpdateRepository, TaskQueryRepository taskQueryRepository) {
        this.taskUpdateRepository = taskUpdateRepository;
        this.taskQueryRepository = taskQueryRepository;
    }

    // Controller 从 Spring 管理的对象调用此方法，事务覆盖整个循环。
    @Transactional
    public int batchUpdateCompleted(List<Integer> ids, Boolean completed) {
        if (ids == null || ids.isEmpty()) {
            throw new IllegalArgumentException("任务编号列表不能为空");
        }
        if (ids.size() > 100) {
            throw new IllegalArgumentException("一次最多修改100个任务");
        }
        if (completed == null) {
            throw new IllegalArgumentException("任务完成状态不能为空");
        }
        HashSet<Integer> uniqueIds = new HashSet<>();
        // 先校验完整请求，再开始写入；重复编号拒绝，返回数量口径清晰。
        for (Integer id : ids) {
            if (id == null || id <= 0) {
                throw new IllegalArgumentException("任务编号必须是正整数");
            }
            if (!uniqueIds.add(id)) {
                throw new IllegalArgumentException("任务编号不能重复");
            }
        }

        for (Integer id : ids) {
            // 复用单条更新逻辑；不存在时抛出运行时异常，交给外层事务回滚。
            updateCompleted(id, completed);
        }
        // 成功处理的任务数，包含原本已处于目标状态的任务。
        return ids.size();
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
