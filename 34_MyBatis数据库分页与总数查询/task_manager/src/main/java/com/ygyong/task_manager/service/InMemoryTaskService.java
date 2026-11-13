package com.ygyong.task_manager.service;

import com.ygyong.task_manager.dto.PageResponse;
import com.ygyong.task_manager.dto.TaskResponse;
import com.ygyong.task_manager.exception.TaskNotFoundException;
import com.ygyong.task_manager.repository.TaskRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class InMemoryTaskService implements TaskService {
    private final TaskRepository taskRepository;

    public InMemoryTaskService(TaskRepository taskRepository) {
        this.taskRepository = taskRepository;
    }

    @Override
    public int getTaskCount() {
        return taskRepository.count();
    }

    @Override
    public TaskResponse getTaskById(int taskId) {
        TaskResponse task = taskRepository.findById(taskId);
        if(task == null) {
            throw new TaskNotFoundException("任务不存在：" + taskId);
        }else {
            return task;
        }
    }

    @Override
    public TaskResponse createTask(String title) {

        // 校验空字符串或者null
        if (title == null || title.isBlank()) {
            throw new IllegalArgumentException("任务标题不能为空");
        }

        return taskRepository.insert(title, false);
    }

    // 修改完成状态
    @Override
    public TaskResponse updateTaskCompleted(int taskId, Boolean completed) {
        if (completed == null) {
            throw new IllegalArgumentException("完成状态不能为空");
        }

        TaskResponse task = taskRepository.updateCompleted(taskId, completed);
        if (task == null) {
            throw new TaskNotFoundException("任务不存在：" + taskId);
        }
        return task;
    }

    // 删除任务
    @Override
    public void deleteTask(int taskId) {
        boolean deleted = taskRepository.deleteById(taskId);
        if (!deleted) {
            throw new TaskNotFoundException("任务不存在：" + taskId);
        }
    }

    // 列表查询
    @Override
    public PageResponse<TaskResponse> getTasks(Boolean completed, String keyword, Integer page, Integer size) {
        if (page == null || page < 1 || size == null || size < 1 || size > 100) {
            throw new IllegalArgumentException("分页参数不合法");
        }

        if (keyword != null) {
            keyword = keyword.strip();
        }

        List<TaskResponse> tasks = taskRepository.findAll();
        List<TaskResponse> filteredTasks = new ArrayList<>();

        for (TaskResponse task : tasks) {
            boolean matchesCompleted = (completed == null || task.isCompleted() == completed);
            boolean matchesKeyword = (keyword == null || keyword.isBlank() || task.getTitle().contains(keyword));

            if (matchesCompleted && matchesKeyword) {
                filteredTasks.add(task);
            }
        }

        long total = filteredTasks.size();

        long offset = (long) (page - 1) * size;

        if (offset >= filteredTasks.size()) {
            return new PageResponse<>(new ArrayList<>(), total, page, size);
        }

        int start = (int) offset;
        int end = (int) Math.min(offset + size, filteredTasks.size());

        List<TaskResponse> paginatedTasks = new ArrayList<>(filteredTasks.subList(start, end));

        return new PageResponse<>(paginatedTasks, total, page, size);
    }
}
