package com.hoten.flashunit {
  public class TestCase {

    public function assert(value:Boolean):void {
      if (!value) {
        fail();
      }
    }

    public function assertEquals(expected:*, actual:*):void {
      if (expected != actual) {
        fail();
      }
    }

    public function fail(message:String = ""):void {
      throw new AssertionError(message);
    }
  }
}
