public interface TaskService {
    Task addTask(String title);
    int getTaskCount();
    int getRemainingTaskCount();
}
