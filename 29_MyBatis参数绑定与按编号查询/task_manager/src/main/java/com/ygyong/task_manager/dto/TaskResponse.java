package com.ygyong.task_manager.dto;

import java.util.List;

public class TaskResponse {
    private int id;
    private String title;
    private boolean completed;

    public TaskResponse(int id, String title, boolean completed) {
        this.id = id;
        this.title = title;
        this.completed = completed;
    }

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public boolean isCompleted() {
        return completed;
    }

    public void setCompleted(boolean completed) {
        this.completed = completed;
    }
}
