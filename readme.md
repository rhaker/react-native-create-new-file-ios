# react-native-create-new-file-ios

This is a wrapper for react-native that creates a blank new file in the app documents directory. File must not already exist

# Add it to your project

npm install react-native-create-new-file-ios --save

In XCode, in the project navigator, right click Libraries ➜ Add Files to [your project's name]

Go to node_modules ➜ react-native-create-new-file-ios and add RNCreateNewFileUtil.xcodeproj

In XCode, in the project navigator, select your project. Add libRNCreateNewFileUtil.a to your project's Build Phases ➜ Link Binary With Libraries

Click RNCreateNewFileUtil.xcodeproj in the project navigator and go the Build Settings tab. Make sure 'All' is toggled on (instead of 'Basic'). Look for Header Search Paths and make sure it contains both $(SRCROOT)/../react-native/React and $(SRCROOT)/../../React - mark both as recursive.

Run your project (Cmd+R)

Setup trouble?

If you get stuck, take a look at Brent Vatne's blog. His blog is my go to reference for this stuff.

# Api Setup

```javascript
var React = require('react-native');

var { NativeModules } = React;

var { RNCreateNewFileUtil } = NativeModules;

RNCreateNewFileUtil.createFile(

    'MyFile.txt',                   // File name

    function errorCallback(results) {

        console.log('Error: ' + results['errMsg']);

    },

    function successCallback(results) {

        console.log('Success: Blank File Created');

    }
);
```

# Error Callback

The following will cause an error callback (use the console.log to see the specific message):

1) File already exists - you can use the react-native-check-file-exists-ios package to test if file already exists (to prevent this error)

2) File name not set in javascript

3) File name does not contain a valid extension. Hidden files are also not allowed

# Acknowledgements

Special thanks to Brent Vatne for his posts on creating a react native packager. Some portions of this code have been based on answers from stackoverflow. This package also owes a special thanks to the tutorial by Modus Create on how to create a custom react native module.
