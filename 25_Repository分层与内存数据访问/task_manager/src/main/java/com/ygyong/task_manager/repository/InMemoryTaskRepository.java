package com.ygyong.task_manager.repository;

import com.ygyong.task_manager.dto.TaskResponse;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class InMemoryTaskRepository implements TaskRepository {

    private final List<TaskResponse> tasks = new ArrayList<>();

    private int nextId = 1;

    @Override
    public int count() {
        return tasks.size();
    }

    @Override
    public List<TaskResponse> findAll() {
        return new ArrayList<>(tasks);
    }

    @Override
    public TaskResponse findById(int taskId) {
        for(TaskResponse task:tasks) {
            if(task.getId() == taskId) {
                return task;
            }
        }
        return null;
    }

    @Override
    public TaskResponse insert(String title, boolean completed) {
        TaskResponse task = new TaskResponse(nextId++, title, completed);
        tasks.add(task);
        return task;
    }

    @Override
    public TaskResponse updateCompleted(int taskId, boolean completed) {
        TaskResponse task = findById(taskId);
        if (task != null) {
            task.setCompleted(completed);
        }else {
            return null;
        }
        return task;
    }

    @Override
    public boolean deleteById(int taskId) {
        TaskResponse task = findById(taskId);
        if (task != null) {
            tasks.remove(task);
            return true;
        } else {
            return false;
        }
    }
}
