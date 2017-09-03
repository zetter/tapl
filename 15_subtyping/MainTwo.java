// For question 15.5.3

public class MainTwo {
  public static class A {
  }

  public static class B extends A {
  }

  public static void main(String[] args) {
    System.out.println("running");

    B[] bArray = {new B(), new B()};
    A[] aArray = bArray;
    aArray[0] = new A(); // raises 'java.lang.ArrayStoreException'
  }
}
