package com.hoten.flashunit {
  import mx.utils.StringUtil;
  import flash.utils.*;

  public class AssertionError extends Error {

    private static function prettyObjectToString(obj:*):String {
      if (obj is Array) {
        return "[" + obj.toString() + "]";
      } else {
        return obj.toString();
      }
    }

    public static function expected(expected:*, actual:*, message:String = ""):AssertionError {
      var format:String = "Expected {0}, actually was {1}";
      var expectedPretty:String = prettyObjectToString(expected);
      var actualPretty:String = prettyObjectToString(actual);
      if (expectedPretty == actualPretty) {
        expectedPretty = StringUtil.substitute("{0} <{1}>", expectedPretty, getQualifiedClassName(expected));
        actualPretty = StringUtil.substitute("{0} <{1}>", actualPretty, getQualifiedClassName(actual));
      }
      var formatted:String = StringUtil.substitute(format, expectedPretty, actualPretty);
      return new AssertionError((message != "" ? (message + " | ") : "") + formatted);
    }

    public static function unexpected(unexpected:*, message:String = ""):AssertionError {
      var format:String = "Did not expect {0}";
      var formatted:String = StringUtil.substitute(format, prettyObjectToString(unexpected));
      return new AssertionError((message != "" ? (message + " | ") : "") + formatted);
    }

    public function AssertionError(message:String) {
      super(message);
    }
  }
}
