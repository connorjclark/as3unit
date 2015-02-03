package com.hoten.flashunit {
  public class FlashUnitTest extends TestCase {

    public function testCanary():void {
      assert(true);
    }

    public function thisIsNotATest():void {
      fail("Expected only methods starting with 'test' to run!");
    }

    public function testAssertEqualsOneAndOnePasses():void {
      assertEquals(1, 1);
    }

    public function expectAssertionError(fun:Function):void {
      try {
        fun();
      } catch (ex:AssertionError) {
        return;
      }
      fail("Expected false assert to throw assertion error.");
    }

    public function testAssertEqualsOneAndTwoFail():void {
      expectAssertionError(function():* { assertEquals(1, 2); });
    }

    public function testAssertEqualsEqualStringsPass():void {
      assertEquals("Hello", "Hel" + "lo");
    }

    public function testAssertEqualsUnequalStringsFail():void {
      expectAssertionError(function():* { assertEquals("Hello", "Bye"); });
    }

    public function testAssertArrayEqualsEqualArraysPass():void {
      assertArrayEquals([1, 2, 3], [1, 2, 3]);
    }

    public function testAssertArrayEqualsUnequalArraysFail():void {
      expectAssertionError(function():* { assertArrayEquals([1, 2, 3], [1, 2, 4]); });
    }

    public function testAssertSameSameObjectsPass():void {
      var obj = { test: "Hello!", test2: 12 };
      assertSame(obj, obj);
    }

    public function testAssertSameDifferentObjectsFail():void {
      var obj1 = { test: "Hello!", test2: 12 };
      var obj2 = { test: "Hello!", test2: 12 };
      expectAssertionError(function():* { assertSame(obj1, obj2); });
    }
  }
}
