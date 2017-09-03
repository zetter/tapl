// For question 15.5.3

public class MainOne {
  public static class A {
  }

  public static class B extends A {
  }

  public static void main(String[] args) {
    System.out.println("running");

    A[] a = new B[]{new B()};
    a[0] = new A();  // raises 'java.lang.ArrayStoreException'
  }
}
