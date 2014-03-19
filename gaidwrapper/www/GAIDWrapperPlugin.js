var exec = require("cordova/exec");

var GAIDWrapperPlugin = function() {

}

GAIDWrapperPlugin.prototype.getGoogleAdvertisingId = function(success, failure) {
    cordova.exec(success, failure, "GAIDWrapperPlugin", "getGAID", []);
};

module.exports = new GAIDWrapperPlugin();