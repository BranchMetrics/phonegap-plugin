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

- (void)setAppAdTrackingEnabled:(CDVInvokedUrlCommand *)command;

- (void)setFacebookEventLogging:(CDVInvokedUrlCommand *)command;

// Attribution APIs

- (void)getPrivacyProtectedDueToAge:(CDVInvokedUrlCommand *)command;
- (void)setPrivacyProtectedDueToAge:(CDVInvokedUrlCommand *)command;

- (void)setUserId:(CDVInvokedUrlCommand *)command;
- (void)setPayingUser:(CDVInvokedUrlCommand *)command;
- (void)setPreloadedAppData:(CDVInvokedUrlCommand *)command;

- (void)registerDeeplinkListener:(CDVInvokedUrlCommand *)command;
- (void)unregisterDeeplinkListener:(CDVInvokedUrlCommand *)command;

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

- (void)automateInAppPurchaseEventMeasurement:(CDVInvokedUrlCommand *)command;
- (void)setJailbroken:(CDVInvokedUrlCommand *)command;

@end
