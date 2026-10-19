package com.ygyong.task_manager.service;

import com.ygyong.task_manager.dto.TaskResponse;
import com.ygyong.task_manager.exception.TaskNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class TaskService {
    private final List<TaskResponse> tasks = new ArrayList<>();
    private int nextId = 1;

    public int getTaskCount() {
        return tasks.size();
    }

    public TaskResponse getTaskById(int taskId) {
        // 根据id查询任务
        for(TaskResponse task:tasks) {
            if(task.getId() == taskId) {
                return task;
            }
        }

        throw new TaskNotFoundException("任务不存在：" + taskId);
        // return new TaskResponse(taskId, "学习 HTTP 参数", false);
    }

    public TaskResponse createTask(String title) {

        // 校验空字符串或者null
        if(title == null || title.isBlank()) {
            throw new IllegalArgumentException("任务标题不能为空");
        }

        TaskResponse newTask = new TaskResponse(nextId++, title, false);
        tasks.add(newTask);
        return newTask;
    }

    // 修改完成状态
    public TaskResponse updateTaskCompleted(int taskId, Boolean completed) {
        if(completed == null) {
            throw new IllegalArgumentException("完成状态不能为空");
        }

        TaskResponse task = getTaskById(taskId);

        task.setCompleted(completed);
        return task;
    }

    // 删除任务
    public void deleteTask(int taskId) {
        TaskResponse task = getTaskById(taskId);
        tasks.remove(task);
    }

    // 列表查询
    public List<TaskResponse> getTasks(Boolean completed) {
        if(completed != null) {
            List<TaskResponse> filteredTasks = new ArrayList<>();
            for(TaskResponse task:tasks) {
                if(task.isCompleted() == completed) {
                    filteredTasks.add(task);
                }
            }
            return filteredTasks;
        }

        return new ArrayList<>(tasks);
    }
}
