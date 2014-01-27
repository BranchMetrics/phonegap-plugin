var exec = require("cordova/exec");

var MATPlugin = function() {

}

MATPlugin.prototype.initTracker = function(success, failure, matAdvertiserId, matConversionKey) {
    console.log("MATPlugin.js: Calling initTracker");
    cordova.exec(success, failure, "MATPlugin", "initTracker", [matAdvertiserId, matConversionKey]);
};

MATPlugin.prototype.setDebugMode = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setDebugMode");
    cordova.exec(success, failure, "MATPlugin", "setDebugMode", [enable]);
};

MATPlugin.prototype.setDelegate = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setDelegate");
    cordova.exec(success, failure, "MATPlugin", "setDelegate", [enable]);
};

MATPlugin.prototype.setPackageName = function(success, failure, packageName) {
    console.log("MATPlugin.js: Calling setPackageName");
    cordova.exec(success, failure, "MATPlugin", "setPackageName", [packageName]);
};

MATPlugin.prototype.setTrusteTPID = function(success, failure, trusteTPID) {
    console.log("MATPlugin.js: Calling setTrusteTPID");
    cordova.exec(success, failure, "MATPlugin", "setTrusteTPID", [trusteTPID]);
};

MATPlugin.prototype.setMACAddress = function(success, failure, mac) {
    console.log("MATPlugin.js: Calling setMACAddress");
    cordova.exec(success, failure, "MATPlugin", "setMACAddress", [mac]);
};

MATPlugin.prototype.setODIN1 = function(success, failure, odin1) {
    console.log("MATPlugin.js: Calling setODIN1");
    cordova.exec(success, failure, "MATPlugin", "setODIN1", [odin1]);
};

MATPlugin.prototype.setOpenUDID = function(success, failure, openUDID) {
    console.log("MATPlugin.js: Calling setOpenUDID");
    cordova.exec(success, failure, "MATPlugin", "setOpenUDID", [openUDID]);
};

MATPlugin.prototype.setUserId = function(success, failure, userId) {
    console.log("MATPlugin.js: Calling setUserId");
    cordova.exec(success, failure, "MATPlugin", "setUserId", [userId]);
};

MATPlugin.prototype.setFacebookUserId = function(success, failure, facebookUserId) {
    console.log("MATPlugin.js: Calling setFacebookUserId");
    cordova.exec(success, failure, "MATPlugin", "setFacebookUserId", [facebookUserId]);
};

MATPlugin.prototype.setTwitterUserId = function(success, failure, twitterUserId) {
    console.log("MATPlugin.js: Calling setTwitterUserId");
    cordova.exec(success, failure, "MATPlugin", "setTwitterUserId", [twitterUserId]);
};

MATPlugin.prototype.setGoogleUserId = function(success, failure, googleUserId) {
    console.log("MATPlugin.js: Calling setGoogleUserId");
    cordova.exec(success, failure, "MATPlugin", "setGoogleUserId", [googleUserId]);
};

MATPlugin.prototype.setUIID = function(success, failure, uiid) {
    console.log("MATPlugin.js: Calling setUIID");
    cordova.exec(success, failure, "MATPlugin", "setUIID", [uiid]);
};

MATPlugin.prototype.setCurrencyCode = function(success, failure, currencyCode) {
    console.log("MATPlugin.js: Calling setCurrencyCode");
    cordova.exec(success, failure, "MATPlugin", "setCurrencyCode", [currencyCode]);
};

MATPlugin.prototype.setGender = function(success, failure, gender) {
    console.log("MATPlugin.js: Calling setGender");
    cordova.exec(success, failure, "MATPlugin", "setGender", [gender]);
};

MATPlugin.prototype.setLocation = function(success, failure, latitude, longitude) {
    console.log("MATPlugin.js: Calling setLocation");
    cordova.exec(success, failure, "MATPlugin", "setLocation", [latitude, longitude]);
};

MATPlugin.prototype.setLocationWithAltitude = function(success, failure, latitude, longitude, altitude) {
    console.log("MATPlugin.js: Calling setLocationWithAltitude");
    cordova.exec(success, failure, "MATPlugin", "setLocationWithAltitude", [latitude, longitude, altitude]);
};

MATPlugin.prototype.setUseCookieTracking = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setUseCookieTracking");
    cordova.exec(success, failure, "MATPlugin", "setUseCookieTracking", [enable]);
};

MATPlugin.prototype.setShouldAutoDetectJailbroken = function(success, failure, autoDetect) {
    console.log("MATPlugin.js: Calling setShouldAutoDetectJailbroken");
    cordova.exec(success, failure, "MATPlugin", "setShouldAutoDetectJailbroken", [autoDetect]);
};

MATPlugin.prototype.setShouldAutoGenerateAppleAdvertisingIdentifier = function(success, failure, autoGenerate) {
    console.log("MATPlugin.js: Calling setShouldAutoGenerateAppleAdvertisingIdentifier");
    cordova.exec(success, failure, "MATPlugin", "setShouldAutoGenerateAppleAdvertisingIdentifier", [autoGenerate]);
};

MATPlugin.prototype.setShouldAutoGenerateAppleVendorIdentifier = function(success, failure, autoGenerate) {
    console.log("MATPlugin.js: Calling setShouldAutoGenerateAppleVendorIdentifier");
    cordova.exec(success, failure, "MATPlugin", "setShouldAutoGenerateAppleVendorIdentifier", [autoGenerate]);
};

MATPlugin.prototype.setAllowDuplicates = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setAllowDuplicates");
    cordova.exec(success, failure, "MATPlugin", "setAllowDuplicates", [enable]);
};

MATPlugin.prototype.setUseCookieTracking = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setUseCookieTracking");
    cordova.exec(success, failure, "MATPlugin", "setUseCookieTracking", [enable]);
};

MATPlugin.prototype.setAppAdTracking = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setAppAdTracking");
    cordova.exec(success, failure, "MATPlugin", "setAppAdTracking", [enable]);
};

MATPlugin.prototype.setAge = function(success, failure, age) {
    console.log("MATPlugin.js: Calling setAge");
    cordova.exec(success, failure, "MATPlugin", "setAge", [age]);
};

MATPlugin.prototype.setJailbroken = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setJailbroken");
    cordova.exec(success, failure, "MATPlugin", "setJailbroken", [enable]);
};

MATPlugin.prototype.setMATAdvertiserId = function(success, failure, matAdvertiserId) {
    console.log("MATPlugin.js: Calling setMATAdvertiserId");
    cordova.exec(success, failure, "MATPlugin", "setMATAdvertiserId", [matAdvertiserId]);
};

MATPlugin.prototype.setMATConversionKey = function(success, failure, matConversionKey) {
    console.log("MATPlugin.js: Calling setMATConversionKey");
    cordova.exec(success, failure, "MATPlugin", "setMATConversionKey", [matConversionKey]);
};

MATPlugin.prototype.setAppleAdvertisingIdentifier = function(success, failure, appleAdvertisingId) {
    console.log("MATPlugin.js: Calling setAppleAdvertisingIdentifier");
    cordova.exec(success, failure, "MATPlugin", "setAppleAdvertisingIdentifier", [appleAdvertisingId]);
};

MATPlugin.prototype.setAppleVendorIdentifier = function(success, failure, appleVendorId) {
    console.log("MATPlugin.js: Calling setAppleVendorIdentifier");
    cordova.exec(success, failure, "MATPlugin", "setAppleVendorIdentifier", [appleVendorId]);
};

MATPlugin.prototype.sdkDataParameters = function(success, failure) {
    console.log("MATPlugin.js: Calling sdkDataParameters");
    cordova.exec(success, failure, "MATPlugin", "sdkDataParameters", []);
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

MATPlugin.prototype.trackInstall = function(success, failure, referenceId) {
    console.log("MATPlugin.js: Calling trackInstall");
    cordova.exec(success, failure, "MATPlugin", "trackInstall", [referenceId]);
};

MATPlugin.prototype.trackUpdate = function(success, failure, referenceId) {
    console.log("MATPlugin.js: Calling trackUpdate");
    cordova.exec(success, failure, "MATPlugin", "trackUpdate", [referenceId]);
};

MATPlugin.prototype.trackAction = function(success, failure, eventName, isId, referenceId, revenue, currency) {
    console.log("MATPlugin.js: Calling trackAction");
    cordova.exec(success, failure, "MATPlugin", "trackAction", [eventName, isId, referenceId, revenue, currency]);
};

MATPlugin.prototype.trackActionWithItems = function(success, failure, eventName, isId, items, referenceId, revenue, currency) {
    console.log("MATPlugin.js: Calling trackActionWithItems");
    cordova.exec(success, failure, "MATPlugin", "trackActionWithItems", [eventName, isId, items, referenceId, revenue, currency]);
};

MATPlugin.prototype.trackActionWithReceipt = function(success, failure, eventName, isId, items, referenceId, revenue, currency, transactionState, receipt, signature) {
    console.log("MATPlugin.js: Calling trackActionWithReceipt");
    cordova.exec(success, failure, "MATPlugin", "trackActionWithReceipt", [eventName, isId, items, referenceId, revenue, currency, transactionState, receipt, signature]);
};

module.exports = new MATPlugin();