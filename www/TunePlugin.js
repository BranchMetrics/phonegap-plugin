/**
 * @file
 * @fileoverview <h3>Tune Cordova Plugin Documentation.</h3>
 */

var exec = require("cordova/exec");

var TunePlugin = function() {}

/**
 * @function initTune
 * @summary Initializes the TUNE SDK.
 *
 * @param {string} tuneAdvertiserId TUNE advertiser ID
 * @param {string} tuneConversionKey TUNE conversion key
 * @param {string} tunePackageName Optional value to set the package name
 */
TunePlugin.prototype.initTune = function(tuneAdvertiserId, tuneConversionKey, tunePackageName) {
    console.log("TunePlugin.js: Calling initTune");
    exec(null, null, "TunePlugin", "initTune", [tuneAdvertiserId, tuneConversionKey, tunePackageName]);
    return this;
};

/**
 * @function setDebugMode
 * @summary Turns debug mode on or off.
 *
 * @param {boolean} enable whether to enable debug output
 */
TunePlugin.prototype.setDebugMode = function(enable) {
    console.log("TunePlugin.js: Calling setDebugMode");
    exec(null, null, "TunePlugin", "setDebugMode", [enable]);
    return this;
};

/**
 * IOS Only.
 */
TunePlugin.prototype.automateInAppPurchaseEventMeasurement = function(automate) {
    console.log("TunePlugin.js: Calling automateInAppPurchaseEventMeasurement");
    exec(null, null, "TunePlugin", "automateInAppPurchaseEventMeasurement", [automate]);
};

/**
 * IOS Only.
 * TODO: Implement for Android
 */
TunePlugin.prototype.getAdvertisingId = function(success, failure) {
    console.log("TunePlugin.js: Calling getAdvertisingId");
    exec(success, failure, "TunePlugin", "getAdvertisingId", []);
};

/**
 * @function getTuneId
 * @summary Gets the TUNE ID generated on install
 *
 * @param {callback} success Callback returns the TUNE ID.
 * @param {callback} failure Callback Message if there was an error.
 */
TunePlugin.prototype.getTuneId = function(success, failure) {
    console.log("TunePlugin.js: Calling getTuneId");
    exec(success, failure, "TunePlugin", "getTuneId", []);
};

/**
 * @function getOpenLogId
 * @summary Gets the first TUNE open log ID
 *
 * @param {callback} success Callback returns the first TUNE open log ID.
 * @param {callback} failure Callback Message if there was an error.
 */
TunePlugin.prototype.getOpenLogId = function(success, failure) {
    console.log("TunePlugin.js: Calling getOpenLogId");
    exec(success, failure, "TunePlugin", "getOpenLogId", []);
};

/**
 * @function getIsPayingUser
 * @summary Gets whether the user is revenue-generating or not
 *
 * @param {callback} success Callback returns true if the user is revenue-generating, or false if not.
 * @param {callback} failure Callback Message if there was an error.
 */
TunePlugin.prototype.getIsPayingUser = function(success, failure) {
    console.log("TunePlugin.js: Calling getIsPayingUser");
    exec(success, failure, "TunePlugin", "getIsPayingUser", []);
};

/**
 * @function getIsPrivacyProtectedDueToAge
 * @summary Returns whether this device profile is flagged as privacy protected.
 * @description This will be true if either the age is set to less than 13 or if setPrivacyProtectedDueToAge(boolean) is set to true.
 *
 * @param {callback} success Callback returns true if the age has been set to less than 13 OR this profile has been set explicitly as privacy protected.
 * @param {callback} failure Callback Message if there was an error.
 */
TunePlugin.prototype.getIsPrivacyProtectedDueToAge = function(success, failure) {
    console.log("TunePlugin.js: Calling getIsPrivacyProtectedDueToAge");
    exec(success, failure, "TunePlugin", "getIsPrivacyProtectedDueToAge", []);
};

/**
 * @function registerDeeplinkListener
 * @summary Set the deeplink listener that will be called.
 * @description This will be called when either a deferred deeplink is found for a fresh install or for handling an opened Tune Link.  Registering a deeplink listener will trigger an asynchronous call to check for deferred deeplinks
 *
 * @param {callback} success Callback returns if successfully did Receive a Deeplink
 * @param {callback} failure Callback Message if registration failed.
 */
TunePlugin.prototype.registerDeeplinkListener = function(success, failure) {
    console.log("TunePlugin.js: Calling registerDeeplinkListener");
    exec(success, failure, "TunePlugin", "registerDeeplinkListener", []);
    return this;
};

/**
 * @function unregisterDeeplinkListener
 * @summary Unregister the deeplink listener.
 * @description Remove the deeplink listener previously set with registerDeeplinkListener().
 */
TunePlugin.prototype.unregisterDeeplinkListener = function() {
    console.log("TunePlugin.js: Calling unregisterDeeplinkListener");
    exec(null, null, "TunePlugin", "unregisterDeeplinkListener", []);
    return this;
};

/**
 * Android Only.
 */
TunePlugin.prototype.setAndroidId = function(enable) {
    console.log("TunePlugin.js: Calling setAndroidId");
    exec(null, null, "TunePlugin", "setAndroidId", [enable]);
    return this;
};

/**
 * Android Only.
 */
TunePlugin.prototype.setAndroidIdMd5 = function(enable) {
    console.log("TunePlugin.js: Calling setAndroidIdMd5");
    exec(null, null, "TunePlugin", "setAndroidIdMd5", [enable]);
    return this;
};

/**
 * Android Only.
 */
TunePlugin.prototype.setAndroidIdSha1 = function(enable) {
    console.log("TunePlugin.js: Calling setAndroidIdSha1");
    exec(null, null, "TunePlugin", "setAndroidIdSha1", [enable]);
    return this;
};

/**
 * Android Only.
 */
TunePlugin.prototype.setAndroidIdSha256 = function(enable) {
    console.log("TunePlugin.js: Calling setAndroidIdSha256");
    exec(null, null, "TunePlugin", "setAndroidIdSha256", [enable]);
    return this;
};

/**
 * @function setDeepLink
 * @summary Set referral url (deeplink).
 * @description Set referral url (deeplink). You usually do not need to call this directly.
 *
 * @param {string} deepLinkUrl deeplink with which app was invoked
 */
TunePlugin.prototype.setDeepLink = function(deepLinkUrl) {
    console.log("TunePlugin.js: Calling setDeepLink");
    exec(null, null, "TunePlugin", "setDeepLink", [deepLinkUrl]);
    return this;
};

/**
 * Android only.
 */
TunePlugin.prototype.setDeviceId = function(enable) {
    console.log("TunePlugin.js: Calling setDeviceId");
    exec(null, null, "TunePlugin", "setDeviceId", [enable]);
    return this;
};

/**
 * Android only.
 */
TunePlugin.prototype.setEmailCollection = function(enable) {
    console.log("TunePlugin.js: Calling setEmailCollection");
    exec(null, null, "TunePlugin", "setEmailCollection", [enable]);
    return this;
};

/**
 * @function setExistingUser
 * @summary Set whether this is an existing user or a new one.
 * @description This is generally used to distinguish users who were using previous versions of the
 * app, prior to integration of the Tune SDK. The default is to assume a new user.
 * @see http://support.mobileapptracking.com/entries/22621001-Handling-Installs-prior-to-SDK-implementation
 *
 * @param {boolean} existingUser true if this user already had the app installed prior to updating to TUNE
 */
TunePlugin.prototype.setExistingUser = function(existingUser) {
    console.log("TunePlugin.js: Calling setExistingUser");
    exec(null, null, "TunePlugin", "setExistingUser", [existingUser]);
    return this;
};

/**
 * @function setFacebookEventLogging
 * @summary Set whether the Tune events should also be logged to the Facebook SDK.
 * @description This flag is ignored if the Facebook SDK is not present.
 *
 * @param {boolean} enable Whether to send Tune events to FB as well
 * @param {boolean} limit Whether data such as that generated through FBAppEvents and sent to Facebook should be restricted from being used for other than analytics and conversions.
 */
TunePlugin.prototype.setFacebookEventLogging = function(enable, limit) {
    console.log("TunePlugin.js: Calling setFacebookEventLogging");
    exec(null, null, "TunePlugin", "setFacebookEventLogging", [enable, limit]);
    return this;
};

/**
 * Android only.
 */
TunePlugin.prototype.setGoogleAdvertisingId = function(googleAid, isLAT) {
    console.log("TunePlugin.js: Calling setGoogleAdvertisingId");
    exec(null, null, "TunePlugin", "setGoogleAdvertisingId", [googleAid, isLAT]);
    return this;
};

/**
 * Android only.
 */
TunePlugin.prototype.setGoogleUserId = function(googleUserId) {
    console.log("TunePlugin.js: Calling setGoogleUserId");
    exec(null, null, "TunePlugin", "setGoogleUserId", [googleUserId]);
    return this;
};

/**
 * @function setPayingUser
 * @summary Set whether the user is generating revenue for the app or not.
 * @description If measureEvent is called with a non-zero revenue, this is automatically set to YES.
 *
 * @param {boolean} payingUser true if the user is revenue-generating, false if not
 */
TunePlugin.prototype.setPayingUser = function(payingUser) {
    console.log("TunePlugin.js: Calling setPayingUser");
    exec(null, null, "TunePlugin", "setPayingUser", [payingUser]);
    return this;
};

/**
 * @function setPreloadedAppData
 * @summary Sets publisher information for attribution.
 *
 * @param {object} preloadData Preload app attribution data (JSON)
 */
TunePlugin.prototype.setPreloadedAppData = function(preloadData) {
    console.log("TunePlugin.js: Calling setPreloadedAppData");
    exec(null, null, "TunePlugin", "setPreloadedAppData", [preloadData]);
    return this;
};

/**
 * @function setPrivacyProtectedDueToAge
 * @summary Set privacy as protected.
 * @description Set this device profile as privacy protected for the purposes of the protection of children from ad targeting and personal data collection. In the US this is part of the COPPA law.
 *
 * @param {boolean} isPrivacyProtected true if privacy should be protected for this user.
 */
TunePlugin.prototype.setPrivacyProtectedDueToAge = function(isPrivacyProtected) {
    console.log("TunePlugin.js: Calling setPrivacyProtectedDueToAge");
    exec(null, null, "TunePlugin", "setPrivacyProtectedDueToAge", [isPrivacyProtected]);
    return this;
};

/**
 * @function setUseId
 * @summary Sets the user ID.
 *
 * @param {string} userId The string name for the user ID.
 */
TunePlugin.prototype.setUserId = function(userId) {
    console.log("TunePlugin.js: Calling setUserId");
    exec(null, null, "TunePlugin", "setUserId", [userId]);
    return this;
};

/**
 * IOS Only.
 */
TunePlugin.prototype.setJailbroken = function(enable) {
    console.log("TunePlugin.js: Calling setJailbroken");
    exec(null, null, "TunePlugin", "setJailbroken", [enable]);
    return this;
};

/**
 * IOS Only.
 */
TunePlugin.prototype.setRedirectUrl = function(redirectUrl) {
    console.log("TunePlugin.js: Calling setRedirectUrl");
    exec(null, null, "TunePlugin", "setRedirectUrl", [redirectUrl]);
    return this;
};

/**
 * @function measureSession
 * @summary To be called when an app opens.
 * TODO: Handle Android activity lifecycle on init
 */
TunePlugin.prototype.measureSession = function() {
    console.log("TunePlugin.js: calling measureSession");
    exec(null, null, "TunePlugin", "measureSession", []);
    return this;
};

/**
 * @function measureEvent
 * @summary Record an event with a TuneEvent.
 * @param {object} tuneEvent the TuneEvent.  Can be a number, string, or JSON object.
 */
TunePlugin.prototype.measureEvent = function(tuneEvent) {
    if (typeof tuneEvent == 'string') {
        console.log("TunePlugin.js: Calling measureEventName");
        exec(null, null, "TunePlugin", "measureEventName", [tuneEvent]);
    } else if (typeof tuneEvent == 'object') {
        console.log("TunePlugin.js: Calling measureEvent");
        exec(null, null, "TunePlugin", "measureEvent", [tuneEvent]);
    }
    return this;
};

/**
 * @function isTuneLink
 * @summary Test if your custom Tune Link domain is registered with Tune.
 * @description Tune Links are Tune-hosted App Links. Tune Links are often shared as short-urls, and the Tune SDK will handle expanding the url and returning the in-app destination url to didReceiveDeeplink registered via registerDeeplinkListener.
 *
 * @param {string} appLinkUrl url to test if it is a Tune Link. Must not be null.
 * @param {callback} success Callback returns true if this link is a Tune Link that will be measured by Tune and routed into the TuneDeeplinkListener.  false if not.
 * @param {callback} failure Callback Message if there was an error.
 */
TunePlugin.prototype.isTuneLink = function(appLinkUrl, success, failure) {
    console.log("TunePlugin.js: Calling isTuneLink");
    exec(success, failure, "TunePlugin", "isTuneLink", [appLinkUrl]);
};

/**
 * Public Module
 */
module.exports = new TunePlugin();
