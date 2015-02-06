package com.hoten.as3unit {
  import com.hoten.as3unit.asserts;

  import mx.utils.ObjectUtil;

  class Assert {

    asserts static function assert(value:Boolean):void {
      if (!value) {
        throw AssertionError.expected(true, false, "assert true")
      }
    }

    asserts static function assertFalse(value:Boolean):void {
      if (value) {
        throw AssertionError.expected(false, true, "assert false")
      }
    }

    asserts static function deepObjectEqualityCheck(obj1:*, obj2:*):Boolean {
      return ObjectUtil.compare(obj1, obj2) == 0;
    }

    asserts static function assertEquals(expected:*, actual:*):void {
      if (!deepObjectEqualityCheck(expected, actual)) {
        throw AssertionError.expected(expected, actual, "assert equals")
      }
    }

    asserts static function assertNotEquals(unexpected:*, actual:*):void {
      if (deepObjectEqualityCheck(unexpected, actual)) {
        throw AssertionError.unexpected(actual, "assert not equals")
      }
    }

    asserts static function assertSame(expected:*, actual:*):void {
      if (expected !== actual) {
        throw AssertionError.unexpected(actual, "assert same")
      }
    }

    asserts static function assertNotSame(unexpected:*, actual:*):void {
      if (unexpected === actual) {
        throw AssertionError.unexpected(actual, "assert not same")
      }
    }

    asserts static function assertArrayEqualsIgnoreOrder(expected:Array, actual:Array):void {
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

    asserts static function fail(message:String):void {
      throw new AssertionError(message);
    }
  }
}
