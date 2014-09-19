var exec = require("cordova/exec");

var GAIDWrapperPlugin = function() {

}

GAIDWrapperPlugin.prototype.getGoogleAdvertisingId = function(success, failure) {
    console.log("GAIDWrapperPlugin.js: Calling getGoogleAdvertisingId");
    cordova.exec(success, failure, "GAIDWrapperPlugin", "getGAID", []);
};

module.exports = new GAIDWrapperPlugin();