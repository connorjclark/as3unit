package com.hoten.flashunit {
  import mx.utils.ObjectUtil;

  public class TestCase {

    public function assert(value:Boolean):void {
      if (!value) {
        throw AssertionError.expected(true, false, "assert true")
      }
    }

    public function assertFalse(value:Boolean):void {
      if (value) {
        throw AssertionError.expected(false, true, "assert false")
      }
    }

    private function deepObjectEqualityCheck(obj1:*, obj2:*):Boolean {
      return ObjectUtil.compare(obj1, obj2) == 0;
    }

    public function assertEquals(expected:*, actual:*):void {
      if (!deepObjectEqualityCheck(expected, actual)) {
        throw AssertionError.expected(expected, actual, "assert equals")
      }
    }

    public function assertNotEquals(unexpected:*, actual:*):void {
      if (deepObjectEqualityCheck(unexpected, actual)) {
        throw AssertionError.unexpected(actual, "assert not equals")
      }
    }

    public function assertSame(expected:*, actual:*):void {
      if (expected !== actual) {
        throw AssertionError.unexpected(actual, "assert same")
      }
    }

    public function assertNotSame(unexpected:*, actual:*):void {
      if (unexpected === actual) {
        throw AssertionError.unexpected(actual, "assert not same")
      }
    }

    public function fail(message:String):void {
      throw new AssertionError(message);
    }
  }
}
