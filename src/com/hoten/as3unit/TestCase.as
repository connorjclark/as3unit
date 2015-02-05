package com.hoten.as3unit {
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

    public function assertArrayEqualsIgnoreOrder(expected:Array, actual:Array):void {
      if (expected.length != actual.length) {
        throw AssertionError.expected(expected, actual, "assert array equals ignore order")
      }

      var expectedCopy:Array = expected.concat();
      expectedCopy.sort(ObjectUtil.compare);

      var actualCopy:Array = actual.concat().sort(ObjectUtil.compare);
      actualCopy.sort(ObjectUtil.compare);

      if (!deepObjectEqualityCheck(expectedCopy, actualCopy)) {
        throw AssertionError.expected(expected, actual, "assert array equals ignore order")
      }
    }

    public function fail(message:String):void {
      throw new AssertionError(message);
    }
  }
}
