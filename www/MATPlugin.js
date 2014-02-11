var exec = require("cordova/exec");

var MATPlugin = function() {

}

MATPlugin.prototype.initTracker = function(success, failure, matAdvertiserId, matConversionKey) {
    console.log("MATPlugin.js: Calling initTracker");
    cordova.exec(success, failure, "MATPlugin", "initTracker", [matAdvertiserId, matConversionKey]);
};

MATPlugin.prototype.setAge = function(success, failure, age) {
    console.log("MATPlugin.js: Calling setAge");
    cordova.exec(success, failure, "MATPlugin", "setAge", [age]);
};

MATPlugin.prototype.setAllowDuplicates = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setAllowDuplicates");
    cordova.exec(success, failure, "MATPlugin", "setAllowDuplicates", [enable]);
};

MATPlugin.prototype.setAppAdTracking = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setAppAdTracking");
    cordova.exec(success, failure, "MATPlugin", "setAppAdTracking", [enable]);
};

MATPlugin.prototype.setCurrencyCode = function(success, failure, currencyCode) {
    console.log("MATPlugin.js: Calling setCurrencyCode");
    cordova.exec(success, failure, "MATPlugin", "setCurrencyCode", [currencyCode]);
};

MATPlugin.prototype.setDebugMode = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setDebugMode");
    cordova.exec(success, failure, "MATPlugin", "setDebugMode", [enable]);
};

MATPlugin.prototype.setDelegate = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setDelegate");
    cordova.exec(success, failure, "MATPlugin", "setDelegate", [enable]);
};

MATPlugin.prototype.setEventAttribute1 = function(success, failure, attr) {
    console.log("MATPlugin.js: Calling setEventAttribute1");
    cordova.exec(success, failure, "MATPlugin", "setEventAttribute1", [attr]);
};

MATPlugin.prototype.setEventAttribute2 = function(success, failure, attr) {
    console.log("MATPlugin.js: Calling setEventAttribute2");
    cordova.exec(success, failure, "MATPlugin", "setEventAttribute2", [attr]);
};

MATPlugin.prototype.setEventAttribute3 = function(success, failure, attr) {
    console.log("MATPlugin.js: Calling setEventAttribute3");
    cordova.exec(success, failure, "MATPlugin", "setEventAttribute3", [attr]);
};

MATPlugin.prototype.setEventAttribute4 = function(success, failure, attr) {
    console.log("MATPlugin.js: Calling setEventAttribute4");
    cordova.exec(success, failure, "MATPlugin", "setEventAttribute4", [attr]);
};

MATPlugin.prototype.setEventAttribute5 = function(success, failure, attr) {
    console.log("MATPlugin.js: Calling setEventAttribute5");
    cordova.exec(success, failure, "MATPlugin", "setEventAttribute5", [attr]);
};

MATPlugin.prototype.setExistingUser = function(success, failure, existingUser) {
    console.log("MATPlugin.js: Calling setExistingUser");
    cordova.exec(success, failure, "MATPlugin", "setExistingUser", [existingUser]);
};

MATPlugin.prototype.setFacebookUserId = function(success, failure, facebookUserId) {
    console.log("MATPlugin.js: Calling setFacebookUserId");
    cordova.exec(success, failure, "MATPlugin", "setFacebookUserId", [facebookUserId]);
};

MATPlugin.prototype.setGender = function(success, failure, gender) {
    console.log("MATPlugin.js: Calling setGender");
    cordova.exec(success, failure, "MATPlugin", "setGender", [gender]);
};

MATPlugin.prototype.setGoogleAdvertisingId = function(success, failure, googleAid) {
    console.log("MATPlugin.js: Calling setGoogleAdvertisingId");
    cordova.exec(success, failure, "MATPlugin", "setGoogleAdvertisingId", [googleAid]);
}

MATPlugin.prototype.setGoogleUserId = function(success, failure, googleUserId) {
    console.log("MATPlugin.js: Calling setGoogleUserId");
    cordova.exec(success, failure, "MATPlugin", "setGoogleUserId", [googleUserId]);
};

MATPlugin.prototype.setLocation = function(success, failure, latitude, longitude) {
    console.log("MATPlugin.js: Calling setLocation");
    cordova.exec(success, failure, "MATPlugin", "setLocation", [latitude, longitude]);
};

MATPlugin.prototype.setLocationWithAltitude = function(success, failure, latitude, longitude, altitude) {
    console.log("MATPlugin.js: Calling setLocationWithAltitude");
    cordova.exec(success, failure, "MATPlugin", "setLocationWithAltitude", [latitude, longitude, altitude]);
};

MATPlugin.prototype.setPackageName = function(success, failure, packageName) {
    console.log("MATPlugin.js: Calling setPackageName");
    cordova.exec(success, failure, "MATPlugin", "setPackageName", [packageName]);
};

MATPlugin.prototype.setTRUSTeId = function(success, failure, trusteID) {
    console.log("MATPlugin.js: Calling setTRUSTeId");
    cordova.exec(success, failure, "MATPlugin", "setTRUSTeId", [trusteID]);
};

MATPlugin.prototype.setTwitterUserId = function(success, failure, twitterUserId) {
    console.log("MATPlugin.js: Calling setTwitterUserId");
    cordova.exec(success, failure, "MATPlugin", "setTwitterUserId", [twitterUserId]);
};

MATPlugin.prototype.setUserEmail = function(success, failure, userEmail) {
    console.log("MATPlugin.js: Calling setUserEmail");
    cordova.exec(success, failure, "MATPlugin", "setUserEmail", [userEmail]);
};

MATPlugin.prototype.setUserId = function(success, failure, userId) {
    console.log("MATPlugin.js: Calling setUserId");
    cordova.exec(success, failure, "MATPlugin", "setUserId", [userId]);
};

MATPlugin.prototype.setUserName = function(success, failure, userName) {
    console.log("MATPlugin.js: Calling setUserName");
    cordova.exec(success, failure, "MATPlugin", "setUserName", [userName]);
};

MATPlugin.prototype.setUseCookieTracking = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setUseCookieTracking");
    cordova.exec(success, failure, "MATPlugin", "setUseCookieTracking", [enable]);
};

MATPlugin.prototype.setShouldAutoDetectJailbroken = function(success, failure, autoDetect) {
    console.log("MATPlugin.js: Calling setShouldAutoDetectJailbroken");
    cordova.exec(success, failure, "MATPlugin", "setShouldAutoDetectJailbroken", [autoDetect]);
};

MATPlugin.prototype.setShouldAutoGenerateAppleVendorIdentifier = function(success, failure, autoGenerate) {
    console.log("MATPlugin.js: Calling setShouldAutoGenerateAppleVendorIdentifier");
    cordova.exec(success, failure, "MATPlugin", "setShouldAutoGenerateAppleVendorIdentifier", [autoGenerate]);
};

MATPlugin.prototype.setJailbroken = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setJailbroken");
    cordova.exec(success, failure, "MATPlugin", "setJailbroken", [enable]);
};

MATPlugin.prototype.setAppleAdvertisingIdentifier = function(success, failure, appleAdvertisingId, adTrackingEnabled) {
    console.log("MATPlugin.js: Calling setAppleAdvertisingIdentifier");
    cordova.exec(success, failure, "MATPlugin", "setAppleAdvertisingIdentifier", [appleAdvertisingId, adTrackingEnabled]);
};

MATPlugin.prototype.setAppleVendorIdentifier = function(success, failure, appleVendorId) {
    console.log("MATPlugin.js: Calling setAppleVendorIdentifier");
    cordova.exec(success, failure, "MATPlugin", "setAppleVendorIdentifier", [appleVendorId]);
};

MATPlugin.prototype.applicationDidOpenURL = function(success, failure, urlString, sourceApp) {
    console.log("MATPlugin.js: Calling applicationDidOpenURL");
    cordova.exec(success, failure, "MATPlugin", "applicationDidOpenURL", [urlString, sourceApp]);
};

MATPlugin.prototype.setTracking = function(success, failure, targetAppPackageName, targetAppAdvertiserId, targetAdvertiserOfferId, targetAdvertiserPublisherId, shouldRedirect) {
    console.log("MATPlugin.js: Calling setTracking");
    cordova.exec(success, failure, "MATPlugin", "setTracking", [targetAppPackageName, targetAppAdvertiserId, targetAdvertiserOfferId, targetAdvertiserPublisherId, shouldRedirect]);
};

MATPlugin.prototype.setRedirectUrl = function(success, failure, redirectUrl) {
    console.log("MATPlugin.js: Calling setRedirectUrl");
    cordova.exec(success, failure, "MATPlugin", "setRedirectUrl", [redirectUrl]);
};

MATPlugin.prototype.trackSession = function(success, failure) {
    console.log("MATPlugin.js: calling trackSession");
    cordova.exec(success, failure, "MATPlugin", "trackSession", []);
}

MATPlugin.prototype.trackAction = function(success, failure, eventName, referenceId, revenue, currency) {
    console.log("MATPlugin.js: Calling trackAction");
    cordova.exec(success, failure, "MATPlugin", "trackAction", [eventName, referenceId, revenue, currency]);
};

MATPlugin.prototype.trackActionWithItems = function(success, failure, eventName, items, referenceId, revenue, currency) {
    console.log("MATPlugin.js: Calling trackActionWithItems");
    cordova.exec(success, failure, "MATPlugin", "trackActionWithItems", [eventName, items, referenceId, revenue, currency]);
};

MATPlugin.prototype.trackActionWithReceipt = function(success, failure, eventName, items, referenceId, revenue, currency, transactionState, receipt, signature) {
    console.log("MATPlugin.js: Calling trackActionWithReceipt");
    cordova.exec(success, failure, "MATPlugin", "trackActionWithReceipt", [eventName, items, referenceId, revenue, currency, transactionState, receipt, signature]);
};

module.exports = new MATPlugin();