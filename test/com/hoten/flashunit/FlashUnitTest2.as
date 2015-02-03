package com.hoten.flashunit {
  public class FlashUnitTest2 extends TestCase {

    public function testMultipleTestCases():void {
    }

    private var cleanSlate:Boolean = true;

    public function testCleanSlateEveryTestPart1():void {
      if (!cleanSlate) {
        fail("Expected a clean slate for every test!");
      }
      cleanSlate = false;
    }

    public function testCleanSlateEveryTestPart2():void {
      if (!cleanSlate) {
        fail("Expected a clean slate for every test!");
      }
      cleanSlate = false;
    }
  }
}
