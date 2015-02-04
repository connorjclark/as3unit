# FlashUnit

FlashUnit is a unit testing framework for Flash.

  - Automate your unit testing
  - Minimal set up

### Installation

In order to use FlashUnit, you need the following installed on your system and in your ENV variable:

- [Ruby](https://www.ruby-lang.org/en/downloads/)
- [Adobe Flex](http://www.adobe.com/devnet/flex/flex-sdk-download.html)*
 
##### *extra step

If you have a 64-bit Java installation as your system's default, you need to do an [extra step](http://tipila.com/tips/79/cannot-find-jvm-error-in-mxmlc-windows-64bit). Simply install a 32-bit version, and add the following line to flex_home/jvm.config:
```
java.home=location of your 32-bit java installation
```
### Integrating with your project

Now, pull the latest version of FlashUnit's .git repo, and type this in the command line:
```
ruby build.rb
```

This will create a folder called flash-unit-release. You can place this folder in the root directory of your Flash project. In the same folder as flash-unit-release is where you should keep your test directory. To run your tests, enter the command line from your project's directory (if viewing the folder in Windows, a nice shortcut is Alt+D, type 'cmd', enter), and type:
```
ruby flash-unit-release/test.rb
```

Voila! Your browser will launch and the test results will be on display.

If you wish to keep the tool packaged in your project's repo, add these items to add to your .gitignore:
```
flash_unit.swf
flash_unit.js
```

Otherwise, add this:
```
flash-unit-release/
```

### Writing tests

Check out the [tests](test/) for FlashUnit to get an idea of how to make a unit test in FlashUnit. A quick rundown:
 * Put all of your tests in a directory called tests/ in the SAME FOLDER as the directory flash-unit-release/
 * Every class in tests/ will be run as test cases. For your test case, extend TestCase.
 * Only methods starting with 'test' will be run
 * The available assert methods are like those in any other unit testing framework.
 * ex: assert, assertFalse, assertEquals, assertSame, assertNotEquals, assertNotSame, fail
 * helper methods: setUp, tearDown, setUpClass, tearDownClass. Simply define them in your test case, or don't. FlashUnit doesn't care.

### Development

Want to contribute? Cool! I highly encourage a TDD approach for the development of this tool. If you wish to contribute by adding *new features*, do so in a TDD manner! :)

### Todo's

 - Make build / test scripts platform agnostic
 - Mocking

### License

Apache License, Version 2.0
