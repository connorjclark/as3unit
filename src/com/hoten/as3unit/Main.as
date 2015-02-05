package com.hoten.as3unit {
  import flash.display.*;
  import flash.events.Event;
  import flash.text.*;
  import flash.utils.*;
  import mx.utils.StringUtil;

  public class Main extends Sprite {
    public var tf:TextField = new TextField();

    public function Main():void {
      stage.scaleMode = StageScaleMode.NO_SCALE;
      stage.align = StageAlign.TOP_LEFT;
      addEventListener(Event.ADDED_TO_STAGE, init);
    }

    public function init(e:Event = null):void {
      removeEventListener(Event.ADDED_TO_STAGE, init);

      tf.x = 0;
      tf.y = 0;
      tf.width = stage.stageWidth;
      tf.height = stage.stageHeight;
      var format:TextFormat = new TextFormat();
      format.size = 18;
      tf.defaultTextFormat = format;
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

      // http://stackoverflow.com/a/2560017/2788187
      function humanize(s:String):String {
        return s.replace(/(?<=[A-Z])(?=[A-Z][a-z])|(?<=[^A-Z])(?=[A-Z])|(?<=[A-Za-z])(?=[^A-Za-z])/g, " ");
      }

      var flattened:Array = flatten(testResults);
      var numSuccess:int = flattened.filter(function(result:*):* {
        return result.success;
      }).length;
      var passRate:Number = numSuccess / flattened.length * 100;

      outf("TESTS = {0} | PASSED = {1} ({2}%)", flattened.length, numSuccess, passRate)
      out();
      flattened.sortOn("success").forEach(function(result:*):* {
        outf("{0}: {1}", humanize(result.method.substring(4)), result.success ? "SUCCESS" : "FAILED");
        if (!result.success) {
          out("\t" + result.ex.getStackTrace());
        }
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
        var result:Object;
        try {
          callIfExists("setUp");
          test[method]();
          result = { method: method, success: true }
        } catch (ex:*) {
          result = { method: method, success: false, ex: ex }
        } finally {
          try {
            callIfExists("tearDown");
          } catch (ex:*) {
            result = { method: method, success: false, ex: ex }
          }
        }
        results.push(result);
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
        result.push.apply(null, arrays[i]);
      }
      return result;
    }
  }
}
