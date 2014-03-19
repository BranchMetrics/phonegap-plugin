var exec = require("cordova/exec");

var IFAWrapperPlugin = function() {

}

IFAWrapperPlugin.prototype.getAppleAdvertisingIdentifier = function(success, failure) {
    cordova.exec(success, failure, "IFAWrapperPlugin", "getAppleAdvertisingIdentifier", []);
};

module.exports = new IFAWrapperPlugin();