public class Task {
    private String title;

    private boolean complete = false;

    public Task(String title) {
        if (title == null || title.isBlank()) {
            throw new IllegalArgumentException("任务标题不能为空或仅包含空白");
        }
        this.title = title;
    }

    public void markCompleted() {
        this.complete = true;
    }

    public String getTitle() {
        return title;
    }

    public boolean isCompleted() {
        return complete;
    }
}
