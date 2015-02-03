package com.hoten.flashunit {
  import mx.utils.StringUtil;
  import mx.utils.ObjectUtil;
  import flash.utils.*;

  public class TestCase {

    public function prettyObjectToString(obj:*):String {
      if (obj is Array) {
        return "[" + obj.toString() + "]";
      } else {
        return obj.toString();
      }
    }

    public function formatFailureExpected(expected:*, actual:*):String {
      var format:String = "Expected {0}, actually was {1}";
      var expectedPretty:String = prettyObjectToString(expected);
      var actualPretty:String = prettyObjectToString(actual);
      if (expectedPretty == actualPretty) {
        expectedPretty = StringUtil.substitute("{0} <{1}>", expectedPretty, getQualifiedClassName(expected));
        actualPretty = StringUtil.substitute("{0} <{1}>", expectedPretty, getQualifiedClassName(actual));
      }
      return StringUtil.substitute(format, expectedPretty, actualPretty);
    }

    public function formatFailureUnexpected(unexpected:*):String {
      var format:String = "Did not expect {0}";
      return StringUtil.substitute(format, prettyObjectToString(unexpected));
    }

    public function assert(value:Boolean):void {
      if (!value) {
        fail("assert true: " + formatFailureExpected(true, false));
      }
    }

    public function assertFalse(value:Boolean):void {
      if (value) {
        fail("assert false: " + formatFailureExpected(false, true));
      }
    }

    private function deepObjectEqualityCheck(obj1:*, obj2:*):Boolean {
      return ObjectUtil.compare(obj1, obj2) == 0;
    }

    public function assertEquals(expected:*, actual:*):void {
      if (!deepObjectEqualityCheck(expected, actual)) {
        fail("assert equals: " + formatFailureExpected(expected, actual));
      }
    }

    public function assertNotEquals(unexpected:*, actual:*):void {
      if (deepObjectEqualityCheck(unexpected, actual)) {
        fail("assert not equals: " + formatFailureUnexpected(actual));
      }
    }

    public function assertSame(expected:*, actual:*):void {
      if (expected !== actual) {
        fail("assert same: " + formatFailureUnexpected(actual));
      }
    }

    public function assertNotSame(unexpected:*, actual:*):void {
      if (unexpected === actual) {
        fail("assert not same: " + formatFailureUnexpected(actual));
      }
    }

    public function fail(message:String = ""):void {
      throw new AssertionError(message);
    }
  }
}
