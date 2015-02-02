package com.hoten.flashunit {
  public class TestCase {

    public function assertTrue(value:Boolean):void {
      if (!value) {
        fail();
      }
    }

    public function fail(message:String = ""):void {
      throw new AssertionError(message);
    }
  }
}

class AssertionError extends Error {

  public function AssertionError(message:String) {
    super(message);
  }
}
