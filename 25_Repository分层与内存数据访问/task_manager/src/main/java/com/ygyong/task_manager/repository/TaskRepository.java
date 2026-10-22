package com.ygyong.task_manager.repository;

import com.ygyong.task_manager.dto.TaskResponse;

import java.util.List;

public interface TaskRepository {
    int count();

    List<TaskResponse> findAll();

    TaskResponse findById(int taskId);

    TaskResponse insert(String title, boolean completed);

    TaskResponse updateCompleted(int taskId, boolean completed);

    boolean deleteById(int taskId);
}
