package com.ygyong.task_manager.dto;

import java.util.List;

public class BatchUpdateTaskCompletedRequest {
    private List<Integer> ids;
    private Boolean completed;

    public List<Integer> getIds() {
        return ids;
    }

    public void setIds(List<Integer> ids) {
        this.ids = ids;
    }

    public Boolean getCompleted() {
        return completed;
    }

    public void setCompleted(Boolean completed) {
        this.completed = completed;
    }
}
