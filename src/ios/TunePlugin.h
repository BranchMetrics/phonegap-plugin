//
//  TunePlugin.h
//
//  Copyright 2016 TUNE, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@import Tune;

@interface TunePlugin : CDVPlugin <TuneDelegate>
{
    // empty
}

// Setup APIs

- (void)initTune:(CDVInvokedUrlCommand *)command;

- (void)setDebugMode:(CDVInvokedUrlCommand *)command;

- (void)setFacebookEventLogging:(CDVInvokedUrlCommand *)command;

// Attribution APIs

- (void)getPrivacyProtectedDueToAge:(CDVInvokedUrlCommand *)command;
- (void)setPrivacyProtectedDueToAge:(CDVInvokedUrlCommand *)command;

- (void)setUserId:(CDVInvokedUrlCommand *)command;
- (void)setPayingUser:(CDVInvokedUrlCommand *)command;
- (void)setPreloadedAppData:(CDVInvokedUrlCommand *)command;

- (void)registerDeeplinkListener:(CDVInvokedUrlCommand *)command;
- (void)unregisterDeeplinkListener:(CDVInvokedUrlCommand *)command;
- (void)setDeepLink:(CDVInvokedUrlCommand *)command;

- (void)setExistingUser:(CDVInvokedUrlCommand *)command;
- (void)measureSession:(CDVInvokedUrlCommand *)command;

- (void)measureEventName:(CDVInvokedUrlCommand *)command;
- (void)measureEvent:(CDVInvokedUrlCommand *)command;

- (void)getAdvertisingId:(CDVInvokedUrlCommand *)command;
- (void)getTuneId:(CDVInvokedUrlCommand *)command;
- (void)getOpenLogId:(CDVInvokedUrlCommand *)command;
- (void)getIsPayingUser:(CDVInvokedUrlCommand *)command;

- (void)isTuneLink:(CDVInvokedUrlCommand *)command;

// iOS specific APIs

- (void)automateIapEventMeasurement:(CDVInvokedUrlCommand *)command;
- (void)setJailbroken:(CDVInvokedUrlCommand *)command;

- (void)setRedirectUrl:(CDVInvokedUrlCommand *)command;

// Android specific APIs

- (void)setAndroidId:(CDVInvokedUrlCommand *)command;
- (void)setAndroidIdMd5:(CDVInvokedUrlCommand *)command;
- (void)setAndroidIdSha1:(CDVInvokedUrlCommand *)command;
- (void)setAndroidIdSha256:(CDVInvokedUrlCommand *)command;

- (void)setDeviceId:(CDVInvokedUrlCommand *)command;
- (void)setGoogleAdvertisingId:(CDVInvokedUrlCommand *)command;
- (void)setEmailCollection:(CDVInvokedUrlCommand *)command;

@end
