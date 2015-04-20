var exec = require("cordova/exec");

var IFAWrapperPlugin = function() {

}

IFAWrapperPlugin.prototype.getAppleAdvertisingIdentifier = function(success, failure) {
    console.log("IFAWrapperPlugin.js: Calling getAppleAdvertisingIdentifier");
    cordova.exec(success, failure, "IFAWrapperPlugin", "getAppleAdvertisingIdentifier", []);
};

module.exports = new IFAWrapperPlugin();