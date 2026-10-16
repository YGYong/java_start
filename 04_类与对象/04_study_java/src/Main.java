
public class Main {
    public static void main(String[] args) {
        Task task1 = new Task();
        task1.complete = false;

        Task alias = task1;

        System.out.println("是否完成1：" + task1.complete);

        alias.markCompleted();

        System.out.println("是否完成1：" + task1.complete);
    }
}