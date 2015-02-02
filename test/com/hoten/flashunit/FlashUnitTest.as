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

    public function testAssertEqualsOneAndTwoFails():void {
      expectAssertionError(function():* { assertEquals(1, 2); });
    }

    public function testAssertEqualsEqualStringsPasses():void {
      assertEquals("Hello", "Hel" + "lo");
    }

    public function testAssertEqualsUnequalStringsFail():void {
      expectAssertionError(function():* { assertEquals("Hello", "Bye"); });
    }
  }
}
