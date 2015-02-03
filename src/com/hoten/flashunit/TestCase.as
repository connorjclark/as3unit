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

    public function assertEquals(expected:*, actual:*):void {
      if (ObjectUtil.compare(expected, actual) != 0) {
        fail(formatFailure(expected, actual));
      }
    }

    public function assertArrayEquals(expected:Array, actual:Array):void {
      if (expected.length != actual.length) {
        fail(formatFailure(expected, actual));
      }
      for (var i:int = 0; i < expected.length; i++) {
        if (expected[i] != actual[i]) {
          fail(formatFailure(expected, actual));
        }
      }
    }

    public function assertSame(expected:*, actual:*):void {
      if (expected !== actual) {
        fail(formatFailure(expected, actual));
      }
    }

    public function fail(message:String = ""):void {
      throw new AssertionError(message);
    }
  }
}
