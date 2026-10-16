package com.ygyong;

import java.util.ArrayList;

public class InMemoryTaskService implements TaskService {
    private final ArrayList<Task> tasks = new ArrayList<>();

    @Override
    public Task addTask(String title) {
        Task task = new Task(title);
        tasks.add(task);
        return task;
    }

    @Override
    public int getTaskCount() {
        return tasks.size();
    }

    @Override
    public int getRemainingTaskCount() {
        int remainingTaskCount = 0;

        for(Task task:tasks) {
            if(!task.isCompleted()) {
                remainingTaskCount++;
            }
        }
        return remainingTaskCount;
    }
}
