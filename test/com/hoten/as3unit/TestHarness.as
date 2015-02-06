package com.hoten.as3unit {
  import com.hoten.as3unit.asserts;
  use namespace asserts;

  public class TestHarness {

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

    private var setUpFlag:Boolean = false;

    public function setUp():void {
      setUpFlag = true;
    }

    public function testSetUp():void {
      if (!setUpFlag) {
        fail("Expected set up to run before test!");
      }
    }

    private static var tearDownFlag:Boolean = false;

    public function tearDown():void {
      tearDownFlag = false;
    }

    public function testTearDownPart1():void {
      if (tearDownFlag) {
        fail("Expected tear down to run after test!");
      }
      tearDownFlag = true;
    }

    public function testTearDownPart2():void {
      if (tearDownFlag) {
        fail("Expected tear down to run after test!");
      }
      tearDownFlag = true;
    }
  }
}
