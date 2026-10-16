public class Task {
    private String title;

    private boolean complete = false;

    public Task(String title) {
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
