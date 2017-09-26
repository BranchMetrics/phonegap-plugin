//
//  TunePlugin.h
//
//  Copyright 2016 TUNE, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

#import "Tune.h"

@interface TunePlugin : CDVPlugin <TuneDelegate>
{
    // empty
}

// Setup APIs

- (void)init:(CDVInvokedUrlCommand*)command;
- (void)initTune:(CDVInvokedUrlCommand*)command;

- (void)setDebugMode:(CDVInvokedUrlCommand*)command;
- (void)setDelegate:(CDVInvokedUrlCommand*)command;

- (void)setPackageName:(CDVInvokedUrlCommand*)command;

- (void)setAppAdMeasurement:(CDVInvokedUrlCommand*)command;

- (void)setFacebookEventLogging:(CDVInvokedUrlCommand*)command;

// Attribution APIs

- (void)setAge:(CDVInvokedUrlCommand*)command;
- (void)setCurrencyCode:(CDVInvokedUrlCommand*)command;
- (void)setGender:(CDVInvokedUrlCommand*)command;
- (void)setLocation:(CDVInvokedUrlCommand*)command;
- (void)setLocationWithAltitude:(CDVInvokedUrlCommand*)command;
- (void)setTRUSTeId:(CDVInvokedUrlCommand*)command;
- (void)setUserEmail:(CDVInvokedUrlCommand*)command;
- (void)setUserId:(CDVInvokedUrlCommand*)command;
- (void)setUserName:(CDVInvokedUrlCommand*)command;
- (void)setFacebookUserId:(CDVInvokedUrlCommand*)command;
- (void)setTwitterUserId:(CDVInvokedUrlCommand*)command;
- (void)setGoogleUserId:(CDVInvokedUrlCommand*)command;
- (void)setPayingUser:(CDVInvokedUrlCommand *)command;
- (void)setPreloadData:(CDVInvokedUrlCommand *)command;

- (void)setShouldAutoCollectDeviceLocation:(CDVInvokedUrlCommand*)command;

- (void)setDeepLink:(CDVInvokedUrlCommand*)command;
- (void)checkForDeferredDeeplink:(CDVInvokedUrlCommand*)command;

- (void)setExistingUser:(CDVInvokedUrlCommand*)command;
- (void)measureSession:(CDVInvokedUrlCommand*)command;

- (void)measureEventName:(CDVInvokedUrlCommand*)command;
- (void)measureEventId:(CDVInvokedUrlCommand*)command;
- (void)measureEvent:(CDVInvokedUrlCommand*)command;

- (void)getAdvertisingId:(CDVInvokedUrlCommand *)command;
- (void)getMatId:(CDVInvokedUrlCommand *)command DEPRECATED_MSG_ATTRIBUTE("Please use -(void)getTuneId:(CDVInvokedUrlCommand*)command instead.");
- (void)getTuneId:(CDVInvokedUrlCommand *)command;
- (void)getOpenLogId:(CDVInvokedUrlCommand *)command;
- (void)getIsPayingUser:(CDVInvokedUrlCommand *)command;

// IAM APIs

- (void)registerPowerHook:(CDVInvokedUrlCommand *)command;
- (void)getValueForHookById:(CDVInvokedUrlCommand *)command;

- (void)registerCustomProfileString:(CDVInvokedUrlCommand*)command;
- (void)setCustomProfileString:(CDVInvokedUrlCommand*)command;
- (void)getCustomProfileString:(CDVInvokedUrlCommand*)command;

- (void)registerCustomProfileDate:(CDVInvokedUrlCommand*)command;
- (void)setCustomProfileDate:(CDVInvokedUrlCommand*)command;
- (void)getCustomProfileDate:(CDVInvokedUrlCommand*)command;

- (void)registerCustomProfileNumber:(CDVInvokedUrlCommand*)command;
- (void)setCustomProfileNumber:(CDVInvokedUrlCommand*)command;
- (void)getCustomProfileNumber:(CDVInvokedUrlCommand*)command;

- (void)registerCustomProfileGeolocation:(CDVInvokedUrlCommand*)command;
- (void)setCustomProfileGeolocation:(CDVInvokedUrlCommand*)command;
- (void)getCustomProfileGeolocation:(CDVInvokedUrlCommand*)command;

- (void)clearCustomProfileVariable:(CDVInvokedUrlCommand*)command;
- (void)clearAllCustomProfileVariables:(CDVInvokedUrlCommand*)command;

- (void)registerCustomTuneLinkDomain:(CDVInvokedUrlCommand*)command;
- (void)enablePushNotifications:(CDVInvokedUrlCommand*)command;
- (void)isTuneLink:(CDVInvokedUrlCommand*)command;

// Smartwhere APIs

- (void)enableSmartwhere:(CDVInvokedUrlCommand *)command;
- (void)disableSmartwhere:(CDVInvokedUrlCommand *)command;
- (void)configureSmartwhere:(CDVInvokedUrlCommand *)command;

// iOS specific APIs

- (void)automateIapEventMeasurement:(CDVInvokedUrlCommand*)command;

- (void)setUseCookieMeasurement:(CDVInvokedUrlCommand*)command;

- (void)setAppleAdvertisingIdentifier:(CDVInvokedUrlCommand*)command;
- (void)setShouldAutoCollectAppleAdvertisingIdentifier:(CDVInvokedUrlCommand*)command;

- (void)setJailbroken:(CDVInvokedUrlCommand*)command;
- (void)setShouldAutoDetectJailbroken:(CDVInvokedUrlCommand*)command;

- (void)setAppleVendorIdentifier:(CDVInvokedUrlCommand*)command;
- (void)setShouldAutoGenerateAppleVendorIdentifier:(CDVInvokedUrlCommand*)command;

- (void)startAppToAppMeasurement:(CDVInvokedUrlCommand*)command;

- (void)setRedirectUrl:(CDVInvokedUrlCommand*)command;

// Android specific APIs

- (void)setAndroidId:(CDVInvokedUrlCommand *)command;
- (void)setAndroidIdMd5:(CDVInvokedUrlCommand *)command;
- (void)setAndroidIdSha1:(CDVInvokedUrlCommand *)command;
- (void)setAndroidIdSha256:(CDVInvokedUrlCommand *)command;

- (void)setDeviceId:(CDVInvokedUrlCommand *)command;
- (void)setGoogleAdvertisingId:(CDVInvokedUrlCommand *)command;
- (void)setEmailCollection:(CDVInvokedUrlCommand *)command;

- (void)setPushNotificationRegistrationId:(CDVInvokedUrlCommand *)command;

@end
