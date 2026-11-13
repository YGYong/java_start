package com.ygyong.task_manager.dto;

import java.util.List;

public class BatchDeleteTaskRequest {
    private List<Integer> ids;

    public List<Integer> getIds() {
        return ids;
    }

    public void setIds(List<Integer> ids) {
        this.ids = ids;
    }
}
