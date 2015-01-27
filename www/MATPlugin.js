var exec = require("cordova/exec");

var MATPlugin = function() {

}

MATPlugin.prototype.initTracker = function(success, failure, matAdvertiserId, matConversionKey) {
    console.log("MATPlugin.js: Calling initTracker");
    cordova.exec(success, failure, "MATPlugin", "initTracker", [matAdvertiserId, matConversionKey]);
};

MATPlugin.prototype.checkForDeferredDeeplink = function(success, failure, timeout) {
    console.log("MATPlugin.js: Calling checkForDeferredDeeplink");
    cordova.exec(success, failure, "MATPlugin", "checkForDeferredDeeplink", [timeout]);
};

MATPlugin.prototype.getMatId = function(success, failure) {
    console.log("MATPlugin.js: Calling getMatId");
    cordova.exec(success, failure, "MATPlugin", "getMatId", []);
};

MATPlugin.prototype.getOpenLogId = function(success, failure) {
    console.log("MATPlugin.js: Calling getOpenLogId");
    cordova.exec(success, failure, "MATPlugin", "getOpenLogId", []);
};

MATPlugin.prototype.getIsPayingUser = function(success, failure) {
    console.log("MATPlugin.js: Calling getIsPayingUser");
    cordova.exec(success, failure, "MATPlugin", "getIsPayingUser", []);
};

MATPlugin.prototype.setAge = function(success, failure, age) {
    console.log("MATPlugin.js: Calling setAge");
    cordova.exec(success, failure, "MATPlugin", "setAge", [age]);
};

MATPlugin.prototype.setAllowDuplicates = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setAllowDuplicates");
    cordova.exec(success, failure, "MATPlugin", "setAllowDuplicates", [enable]);
};

MATPlugin.prototype.setAndroidId = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setAndroidId");
    cordova.exec(success, failure, "MATPlugin", "setAndroidId", [enable]);
};

MATPlugin.prototype.setAndroidIdMd5 = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setAndroidIdMd5");
    cordova.exec(success, failure, "MATPlugin", "setAndroidIdMd5", [enable]);
};

MATPlugin.prototype.setAndroidIdSha1 = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setAndroidIdSha1");
    cordova.exec(success, failure, "MATPlugin", "setAndroidIdSha1", [enable]);
};

MATPlugin.prototype.setAndroidIdSha256 = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setAndroidIdSha256");
    cordova.exec(success, failure, "MATPlugin", "setAndroidIdSha256", [enable]);
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

MATPlugin.prototype.setDeviceId = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setDeviceId");
    cordova.exec(success, failure, "MATPlugin", "setDeviceId", [enable]);
};

MATPlugin.prototype.setEmailCollection = function(success, failure, enable) {
    console.log("MATPlugin.js: Calling setEmailCollection");
    cordova.exec(success, failure, "MATPlugin", "setEmailCollection", [enable]);
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

MATPlugin.prototype.setEventContentId = function(success, failure, contentId) {
    console.log("MATPlugin.js: Calling setEventContentId");
    cordova.exec(success, failure, "MATPlugin", "setEventContentId", [contentId]);
};

MATPlugin.prototype.setEventContentType = function(success, failure, contentType) {
    console.log("MATPlugin.js: Calling setEventContentType");
    cordova.exec(success, failure, "MATPlugin", "setEventContentType", [contentType]);
};

MATPlugin.prototype.setEventDate1 = function(success, failure, date1) {
    console.log("MATPlugin.js: Calling setEventDate1");
    cordova.exec(success, failure, "MATPlugin", "setEventDate1", [date1]);
};

MATPlugin.prototype.setEventDate2 = function(success, failure, date2) {
    console.log("MATPlugin.js: Calling setEventDate2");
    cordova.exec(success, failure, "MATPlugin", "setEventDate2", [date2]);
};

MATPlugin.prototype.setEventLevel = function(success, failure, level) {
    console.log("MATPlugin.js: Calling setEventLevel");
    cordova.exec(success, failure, "MATPlugin", "setEventLevel", [level]);
};

MATPlugin.prototype.setEventQuantity = function(success, failure, quantity) {
    console.log("MATPlugin.js: Calling setEventQuantity");
    cordova.exec(success, failure, "MATPlugin", "setEventQuantity", [quantity]);
};

MATPlugin.prototype.setEventRating = function(success, failure, rating) {
    console.log("MATPlugin.js: Calling setEventRating");
    cordova.exec(success, failure, "MATPlugin", "setEventRating", [rating]);
};

MATPlugin.prototype.setEventSearchString = function(success, failure, searchString) {
    console.log("MATPlugin.js: Calling setEventSearchString");
    cordova.exec(success, failure, "MATPlugin", "setEventSearchString", [searchString]);
};

MATPlugin.prototype.setExistingUser = function(success, failure, existingUser) {
    console.log("MATPlugin.js: Calling setExistingUser");
    cordova.exec(success, failure, "MATPlugin", "setExistingUser", [existingUser]);
};

MATPlugin.prototype.setFacebookEventLogging = function(success, failure, enable, limit) {
    console.log("MATPlugin.js: Calling setFacebookEventLogging");
    cordova.exec(success, failure, "MATPlugin", "setFacebookEventLogging", [enable, limit]);
};

MATPlugin.prototype.setFacebookUserId = function(success, failure, facebookUserId) {
    console.log("MATPlugin.js: Calling setFacebookUserId");
    cordova.exec(success, failure, "MATPlugin", "setFacebookUserId", [facebookUserId]);
};

MATPlugin.prototype.setGender = function(success, failure, gender) {
    console.log("MATPlugin.js: Calling setGender");
    cordova.exec(success, failure, "MATPlugin", "setGender", [gender]);
};

MATPlugin.prototype.setGoogleAdvertisingId = function(success, failure, googleAid, isLAT) {
    console.log("MATPlugin.js: Calling setGoogleAdvertisingId");
    cordova.exec(success, failure, "MATPlugin", "setGoogleAdvertisingId", [googleAid, isLAT]);
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

MATPlugin.prototype.setPayingUser = function(success, failure, payingUser) {
    console.log("MATPlugin.js: Calling setPayingUser");
    cordova.exec(success, failure, "MATPlugin", "setPayingUser", [payingUser]);
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

MATPlugin.prototype.startAppToAppTracking = function(success, failure, targetAppPackageName, targetAppAdvertiserId, targetAdvertiserOfferId, targetAdvertiserPublisherId, shouldRedirect) {
    console.log("MATPlugin.js: Calling startAppToAppTracking");
    cordova.exec(success, failure, "MATPlugin", "startAppToAppTracking", [targetAppPackageName, targetAppAdvertiserId, targetAdvertiserOfferId, targetAdvertiserPublisherId, shouldRedirect]);
};

MATPlugin.prototype.setRedirectUrl = function(success, failure, redirectUrl) {
    console.log("MATPlugin.js: Calling setRedirectUrl");
    cordova.exec(success, failure, "MATPlugin", "setRedirectUrl", [redirectUrl]);
};

MATPlugin.prototype.measureSession = function(success, failure) {
    console.log("MATPlugin.js: calling measureSession");
    cordova.exec(success, failure, "MATPlugin", "measureSession", []);
}

MATPlugin.prototype.measureAction = function(success, failure, eventName, referenceId, revenue, currency) {
    console.log("MATPlugin.js: Calling measureAction");
    cordova.exec(success, failure, "MATPlugin", "measureAction", [eventName, referenceId, revenue, currency]);
};

MATPlugin.prototype.measureActionWithItems = function(success, failure, eventName, items, referenceId, revenue, currency) {
    console.log("MATPlugin.js: Calling measureActionWithItems");
    cordova.exec(success, failure, "MATPlugin", "measureActionWithItems", [eventName, items, referenceId, revenue, currency]);
};

MATPlugin.prototype.measureActionWithReceipt = function(success, failure, eventName, items, referenceId, revenue, currency, transactionState, receipt, signature) {
    console.log("MATPlugin.js: Calling measureActionWithReceipt");
    cordova.exec(success, failure, "MATPlugin", "measureActionWithReceipt", [eventName, items, referenceId, revenue, currency, transactionState, receipt, signature]);
};

module.exports = new MATPlugin();