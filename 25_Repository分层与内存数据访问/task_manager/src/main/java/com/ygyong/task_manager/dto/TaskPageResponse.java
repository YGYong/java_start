package com.ygyong.task_manager.dto;

import java.util.List;

public class TaskPageResponse {
    private List<TaskResponse> items;
    private long total;
    private int page;
    private int size;

    public TaskPageResponse(List<TaskResponse> items, long total, int page, int size) {
        this.items = items;
        this.total = total;
        this.page = page;
        this.size = size;
    }

    public List<TaskResponse> getItems() {
        return items;
    }

    public long getTotal() {
        return total;
    }

    public int getPage() {
        return page;
    }

    public int getSize() {
        return size;
    }
}
