package com.hoten.flashunit {
  import mx.utils.StringUtil;
  import mx.utils.ObjectUtil;

  public class TestCase {

    public function prettyFormat(obj:*):String {
      if (obj is Array) {
        return "[" + obj.toString() + "]";
      } else {
        return obj.toString();
      }
    }

    public function formatFailure(expected:*, actual:*):String {
      var format:String = "Expected {0}, actually was {1}";
      return StringUtil.substitute(format, prettyFormat(expected), prettyFormat(actual))
    }

    public function assert(value:Boolean):void {
      if (!value) {
        fail(formatFailure(true, false));
      }
    }

    public function assertFalse(value:Boolean):void {
      if (value) {
        fail(formatFailure(false, true));
      }
    }

    private function deepObjectEqualityCheck(obj1:*, obj2:*):Boolean {
      return ObjectUtil.compare(obj1, obj2) == 0;
    }

    public function assertEquals(expected:*, actual:*):void {
      if (!deepObjectEqualityCheck(expected, actual)) {
        fail(formatFailure(expected, actual));
      }
    }

    public function assertNotEquals(expected:*, actual:*):void {
      if (deepObjectEqualityCheck(expected, actual)) {
        fail(formatFailure(expected, actual));
      }
    }

    public function assertSame(expected:*, actual:*):void {
      if (expected !== actual) {
        fail(formatFailure(expected, actual));
      }
    }

    public function assertNotSame(expected:*, actual:*):void {
      if (expected === actual) {
        fail(formatFailure(expected, actual));
      }
    }

    public function fail(message:String = ""):void {
      throw new AssertionError(message);
    }
  }
}
