package com.hoten.flashunit {
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.external.ExternalInterface;
  import flash.text.TextField;
  import flash.utils.*;
  import mx.utils.StringUtil;

  public class Main extends Sprite {
    public var tf:TextField = new TextField();

    public function Main():void {
      addEventListener(Event.ADDED_TO_STAGE, init);
    }

    public function init(e:Event = null):void {
      removeEventListener(Event.ADDED_TO_STAGE, init);

      tf.x = 0;
      tf.y = 0;
      tf.width = 500;
      tf.height = 500;
      addChild(tf);

      displayResults(runTests());
    }

    private function displayResults(testResults:Array):void {
      function out(line:String = ""):void {
        tf.appendText(line + "\n");
      }

      function outf(format:String, ...args):void {
        out(StringUtil.substitute(format, args));
      }

      var flattened:Array = flatten(testResults);
      var numSuccess:int = flattened.filter(function(result:*):* {
        return result.success;
      }).length;
      var passRate:Number = numSuccess / flattened.length * 100;

      outf("TESTS = {0} | PASSED = {1} ({2}%)", flattened.length, numSuccess, passRate)
      out();
      flattened.sortOn("success").forEach(function(result:*):* {
        outf("{0}: {1}", result.method, result.success ? "SUCCESS" : "FAILED");
        if (!result.success) {
          out(result.ex.getStackTrace());
        }
        out();
      });
    }

    private function runTests():Array {
      var tests:Array = root.loaderInfo.parameters.classesToTest.split(" ");

      return tests.map(function(test:*):* {
        var klass:Class = getDefinitionByName(test) as Class;
        return runTest(klass);
      });
    }

    private function runTest(testKlass:Class):Array {
      function callIfExists(method:String):void {
        if (test.hasOwnProperty(method)) {
          test[method]();
        }
      }

      var test:* = new testKlass();
      var results:Array = [];
      var methods:Array = getMethods(test);

      callIfExists("setUpClass");
      for each (var method:String in methods) {
        test = new testKlass();
        callIfExists("setUp");
        var result:Object;
        try {
          test[method]();
          result = { method: method, success: true }
        } catch (ex:*) {
          result = { method: method, success: false, ex: ex }
        }
        results.push(result);
        callIfExists("tearDown");
      }
      callIfExists("tearDownClass");

      return results;
    }

    private function getMethods(obj:*):Array {
      var typeName:String = getQualifiedClassName(obj);
      var typeDesc:XML = describeType(getDefinitionByName(typeName));
      var methodList:XMLList = typeDesc.factory.method;
      var result:Array = [];
      for (var i:int = 0; i < methodList.length(); i++) {
        var methodName:String = methodList[i].@name;
        if (methodName.indexOf("test") == 0) {
          result.push(methodName);
        }
      }
      return result;
    }

    private function flatten(arrays:Array):Array {
      var result:Array = [];
      for (var i:int=0; i < arrays.length; i++){
        result = result.concat(arrays[i]);
      }
      return result;
    }
  }
}
