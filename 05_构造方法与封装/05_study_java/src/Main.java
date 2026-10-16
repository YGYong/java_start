
public class Main {
    public static void main(String[] args) {
        Task task1 = new Task("学习构造方法");

        System.out.println("标题1：" + task1.getTitle());
        System.out.println("是否完成1：" + task1.isCompleted());

        task1.markCompleted();

        System.out.println("是否完成1：" + task1.isCompleted());
    }
}