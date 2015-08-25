var exec = require("cordova/exec");

var MATPlugin = function() {}

MATPlugin.prototype.init = function(tuneAdvertiserId, tuneConversionKey, tunePackageName, tuneIsWearable) {
    console.log("MATPlugin.js: Calling init");
    exec(null, null, "MATPlugin", "init", [tuneAdvertiserId, tuneConversionKey, tunePackageName, tuneIsWearable]);
    return this;
};

// Ads calls
MATPlugin.prototype.showBanner = function(placement, adMetadata, bannerPosition) {
    console.log("MATPlugin.js: Calling showBanner");
    exec(null, null, "MATPlugin", "showBanner", [placement, adMetadata, bannerPosition]);
    return this;
};

MATPlugin.prototype.hideBanner = function() {
    console.log("MATPlugin.js: Calling hideBanner");
    exec(null, null, "MATPlugin", "hideBanner", []);
    return this;
};

MATPlugin.prototype.cacheInterstitial = function(placement, adMetadata) {
    console.log("MATPlugin.js: Calling cacheInterstitial");
    exec(null, null, "MATPlugin", "cacheInterstitial", [placement, adMetadata]);
    return this;
};

MATPlugin.prototype.showInterstitial = function(placement, adMetadata) {
    console.log("MATPlugin.js: Calling showInterstitial");
    exec(null, null, "MATPlugin", "showInterstitial", [placement, adMetadata]);
    return this;
};

// Measure calls
MATPlugin.prototype.checkForDeferredDeeplink = function(success, failure) {
    console.log("MATPlugin.js: Calling checkForDeferredDeeplink");
    exec(success, failure, "MATPlugin", "checkForDeferredDeeplink", []);
    return this;
};

MATPlugin.prototype.automateIapEventMeasurement = function(automate) {
    console.log("MATPlugin.js: Calling automateIapEventMeasurement");
    exec(null, null, "MATPlugin", "automateIapEventMeasurement", [automate]);
    return this;
};

MATPlugin.prototype.getMatId = function(success, failure) {
    console.log("MATPlugin.js: Calling getMatId");
    exec(success, failure, "MATPlugin", "getMatId", []);
};

MATPlugin.prototype.getOpenLogId = function(success, failure) {
    console.log("MATPlugin.js: Calling getOpenLogId");
    exec(success, failure, "MATPlugin", "getOpenLogId", []);
};

MATPlugin.prototype.getIsPayingUser = function(success, failure) {
    console.log("MATPlugin.js: Calling getIsPayingUser");
    exec(success, failure, "MATPlugin", "getIsPayingUser", []);
};

MATPlugin.prototype.setAge = function(age) {
    console.log("MATPlugin.js: Calling setAge");
    exec(null, null, "MATPlugin", "setAge", [age]);
    return this;
};

MATPlugin.prototype.setAllowDuplicates = function(enable) {
    console.log("MATPlugin.js: Calling setAllowDuplicates");
    exec(null, null, "MATPlugin", "setAllowDuplicates", [enable]);
    return this;
};

MATPlugin.prototype.setAndroidId = function(enable) {
    console.log("MATPlugin.js: Calling setAndroidId");
    exec(null, null, "MATPlugin", "setAndroidId", [enable]);
    return this;
};

MATPlugin.prototype.setAndroidIdMd5 = function(enable) {
    console.log("MATPlugin.js: Calling setAndroidIdMd5");
    exec(null, null, "MATPlugin", "setAndroidIdMd5", [enable]);
    return this;
};

MATPlugin.prototype.setAndroidIdSha1 = function(enable) {
    console.log("MATPlugin.js: Calling setAndroidIdSha1");
    exec(null, null, "MATPlugin", "setAndroidIdSha1", [enable]);
    return this;
};

MATPlugin.prototype.setAndroidIdSha256 = function(enable) {
    console.log("MATPlugin.js: Calling setAndroidIdSha256");
    exec(null, null, "MATPlugin", "setAndroidIdSha256", [enable]);
    return this;
};

MATPlugin.prototype.setAppAdMeasurement = function(enable) {
    console.log("MATPlugin.js: Calling setAppAdMeasurement");
    exec(null, null, "MATPlugin", "setAppAdMeasurement", [enable]);
    return this;
};

MATPlugin.prototype.setCurrencyCode = function(currencyCode) {
    console.log("MATPlugin.js: Calling setCurrencyCode");
    exec(null, null, "MATPlugin", "setCurrencyCode", [currencyCode]);
    return this;
};

MATPlugin.prototype.setDebugMode = function(enable) {
    console.log("MATPlugin.js: Calling setDebugMode");
    exec(null, null, "MATPlugin", "setDebugMode", [enable]);
    return this;
};

MATPlugin.prototype.setDelegate = function(enable, success, failure) {
    console.log("MATPlugin.js: Calling setDelegate");
    exec(success, failure, "MATPlugin", "setDelegate", [enable]);
    return this;
};

MATPlugin.prototype.setDeviceId = function(enable) {
    console.log("MATPlugin.js: Calling setDeviceId");
    exec(null, null, "MATPlugin", "setDeviceId", [enable]);
    return this;
};

MATPlugin.prototype.setEmailCollection = function(enable) {
    console.log("MATPlugin.js: Calling setEmailCollection");
    exec(null, null, "MATPlugin", "setEmailCollection", [enable]);
    return this;
};

MATPlugin.prototype.setExistingUser = function(existingUser) {
    console.log("MATPlugin.js: Calling setExistingUser");
    exec(null, null, "MATPlugin", "setExistingUser", [existingUser]);
    return this;
};

MATPlugin.prototype.setFacebookEventLogging = function(enable, limit) {
    console.log("MATPlugin.js: Calling setFacebookEventLogging");
    exec(null, null, "MATPlugin", "setFacebookEventLogging", [enable, limit]);
    return this;
};

MATPlugin.prototype.setFacebookUserId = function(facebookUserId) {
    console.log("MATPlugin.js: Calling setFacebookUserId");
    exec(null, null, "MATPlugin", "setFacebookUserId", [facebookUserId]);
    return this;
};

MATPlugin.prototype.setGender = function(gender) {
    console.log("MATPlugin.js: Calling setGender");
    exec(null, null, "MATPlugin", "setGender", [gender]);
    return this;
};

MATPlugin.prototype.setGoogleAdvertisingId = function(googleAid, isLAT) {
    console.log("MATPlugin.js: Calling setGoogleAdvertisingId");
    exec(null, null, "MATPlugin", "setGoogleAdvertisingId", [googleAid, isLAT]);
    return this;
};

MATPlugin.prototype.setGoogleUserId = function(googleUserId) {
    console.log("MATPlugin.js: Calling setGoogleUserId");
    exec(null, null, "MATPlugin", "setGoogleUserId", [googleUserId]);
    return this;
};

MATPlugin.prototype.setLocation = function(latitude, longitude) {
    console.log("MATPlugin.js: Calling setLocation");
    exec(null, null, "MATPlugin", "setLocation", [latitude, longitude]);
    return this;
};

MATPlugin.prototype.setLocationWithAltitude = function(latitude, longitude, altitude) {
    console.log("MATPlugin.js: Calling setLocationWithAltitude");
    exec(null, null, "MATPlugin", "setLocationWithAltitude", [latitude, longitude, altitude]);
    return this;
};

MATPlugin.prototype.setPackageName = function(packageName) {
    console.log("MATPlugin.js: Calling setPackageName");
    exec(null, null, "MATPlugin", "setPackageName", [packageName]);
    return this;
};

MATPlugin.prototype.setPayingUser = function(payingUser) {
    console.log("MATPlugin.js: Calling setPayingUser");
    exec(null, null, "MATPlugin", "setPayingUser", [payingUser]);
    return this;
};

MATPlugin.prototype.setPreloadData = function(preloadData) {
    console.log("MATPlugin.js: Calling setPreloadData");
    exec(null, null, "MATPlugin", "setPreloadData", [preloadData]);
    return this;
};

MATPlugin.prototype.setTRUSTeId = function(trusteID) {
    console.log("MATPlugin.js: Calling setTRUSTeId");
    exec(null, null, "MATPlugin", "setTRUSTeId", [trusteID]);
    return this;
};

MATPlugin.prototype.setTwitterUserId = function(twitterUserId) {
    console.log("MATPlugin.js: Calling setTwitterUserId");
    exec(null, null, "MATPlugin", "setTwitterUserId", [twitterUserId]);
    return this;
};

MATPlugin.prototype.setUserEmail = function(userEmail) {
    console.log("MATPlugin.js: Calling setUserEmail");
    exec(null, null, "MATPlugin", "setUserEmail", [userEmail]);
    return this;
};

MATPlugin.prototype.setUserId = function(userId) {
    console.log("MATPlugin.js: Calling setUserId");
    exec(null, null, "MATPlugin", "setUserId", [userId]);
    return this;
};

MATPlugin.prototype.setUserName = function(userName) {
    console.log("MATPlugin.js: Calling setUserName");
    exec(null, null, "MATPlugin", "setUserName", [userName]);
    return this;
};

MATPlugin.prototype.setUseCookieMeasurement = function(enable) {
    console.log("MATPlugin.js: Calling setUseCookieMeasurement");
    exec(null, null, "MATPlugin", "setUseCookieMeasurement", [enable]);
    return this;
};

MATPlugin.prototype.setShouldAutoCollectAppleAdvertisingIdentifier = function(autoCollect) {
    console.log("MATPlugin.js: Calling setShouldAutoCollectAppleAdvertisingIdentifier");
    exec(null, null, "MATPlugin", "setShouldAutoCollectAppleAdvertisingIdentifier", [autoCollect]);
    return this;
};

MATPlugin.prototype.setShouldAutoCollectDeviceLocation = function(autoCollect) {
    console.log("MATPlugin.js: Calling setShouldAutoCollectDeviceLocation");
    exec(null, null, "MATPlugin", "setShouldAutoCollectDeviceLocation", [autoCollect]);
    return this;
};

MATPlugin.prototype.setShouldAutoDetectJailbroken = function(autoDetect) {
    console.log("MATPlugin.js: Calling setShouldAutoDetectJailbroken");
    exec(null, null, "MATPlugin", "setShouldAutoDetectJailbroken", [autoDetect]);
    return this;
};

MATPlugin.prototype.setShouldAutoGenerateAppleVendorIdentifier = function(autoGenerate) {
    console.log("MATPlugin.js: Calling setShouldAutoGenerateAppleVendorIdentifier");
    exec(null, null, "MATPlugin", "setShouldAutoGenerateAppleVendorIdentifier", [autoGenerate]);
    return this;
};

MATPlugin.prototype.setJailbroken = function(enable) {
    console.log("MATPlugin.js: Calling setJailbroken");
    exec(null, null, "MATPlugin", "setJailbroken", [enable]);
    return this;
};

MATPlugin.prototype.setAppleAdvertisingIdentifier = function(appleAdvertisingId, adTrackingEnabled) {
    console.log("MATPlugin.js: Calling setAppleAdvertisingIdentifier");
    exec(null, null, "MATPlugin", "setAppleAdvertisingIdentifier", [appleAdvertisingId, adTrackingEnabled]);
    return this;
};

MATPlugin.prototype.setAppleVendorIdentifier = function(appleVendorId) {
    console.log("MATPlugin.js: Calling setAppleVendorIdentifier");
    exec(null, null, "MATPlugin", "setAppleVendorIdentifier", [appleVendorId]);
    return this;
};

MATPlugin.prototype.applicationDidOpenURL = function(urlString, sourceApp) {
    console.log("MATPlugin.js: Calling applicationDidOpenURL");
    exec(null, null, "MATPlugin", "applicationDidOpenURL", [urlString, sourceApp]);
    return this;
};

MATPlugin.prototype.startAppToAppMeasurement = function(targetAppPackageName, targetAppAdvertiserId, targetAdvertiserOfferId, targetAdvertiserPublisherId, shouldRedirect) {
    console.log("MATPlugin.js: Calling startAppToAppMeasurement");
    exec(null, null, "MATPlugin", "startAppToAppMeasurement", [targetAppPackageName, targetAppAdvertiserId, targetAdvertiserOfferId, targetAdvertiserPublisherId, shouldRedirect]);
    return this;
};

MATPlugin.prototype.setRedirectUrl = function(redirectUrl) {
    console.log("MATPlugin.js: Calling setRedirectUrl");
    exec(null, null, "MATPlugin", "setRedirectUrl", [redirectUrl]);
    return this;
};

MATPlugin.prototype.measureSession = function() {
    console.log("MATPlugin.js: calling measureSession");
    exec(null, null, "MATPlugin", "measureSession", []);
    return this;
};

MATPlugin.prototype.measureEvent = function(tuneEvent) {
    if (typeof tuneEvent == 'number') {
        console.log("MATPlugin.js: Calling measureEventId");
        exec(null, null, "MATPlugin", "measureEventId", [tuneEvent]);
    } else if (typeof tuneEvent == 'string') {
        console.log("MATPlugin.js: Calling measureEventName");
        exec(null, null, "MATPlugin", "measureEventName", [tuneEvent]);
    } else if (typeof tuneEvent == 'object') {
        console.log("MATPlugin.js: Calling measureEvent");
        exec(null, null, "MATPlugin", "measureEvent", [tuneEvent]);
    }
    return this;
};

module.exports = new MATPlugin();
