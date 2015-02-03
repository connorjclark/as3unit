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

    public function assertEquals(expected:*, actual:*):void {
      if (ObjectUtil.compare(expected, actual) != 0) {
        fail(formatFailure(expected, actual));
      }
    }

    public function assertNotEquals(expected:*, actual:*):void {
      if (ObjectUtil.compare(expected, actual) == 0) {
        fail(formatFailure(expected, actual));
      }
    }

    private function arrayEqualityCheck(arr1:Array, arr2:Array):Boolean {
      if (arr1.length != arr2.length) {
        return false;
      }
      for (var i:int = 0; i < arr1.length; i++) {
        if (arr1[i] != arr2[i]) {
          return false;
        }
      }
      return true;
    }

    public function assertArrayEquals(expected:Array, actual:Array):void {
      if (!arrayEqualityCheck(expected, actual)) {
        fail(formatFailure(expected, actual));
      }
    }

    public function assertArrayNotEquals(expected:Array, actual:Array):void {
      if (arrayEqualityCheck(expected, actual)) {
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
