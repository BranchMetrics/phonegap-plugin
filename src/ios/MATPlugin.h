//
//  MATPlugin.h
//
//  Copyright 2013 HasOffers Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

#import "MobileAppTracker.h"

@interface MATPlugin : CDVPlugin <TuneDelegate, TuneAdDelegate>
{
    // empty
}

- (void)init:(CDVInvokedUrlCommand*)command;

- (void)setAllowDuplicates:(CDVInvokedUrlCommand*)command;
- (void)setDebugMode:(CDVInvokedUrlCommand*)command;
- (void)setDelegate:(CDVInvokedUrlCommand*)command;

- (void)setPackageName:(CDVInvokedUrlCommand*)command;
- (void)setSiteId:(CDVInvokedUrlCommand*)command;

- (void)setAppAdMeasurement:(CDVInvokedUrlCommand*)command;
- (void)setAppleAdvertisingIdentifier:(CDVInvokedUrlCommand*)command;
- (void)setAppleVendorIdentifier:(CDVInvokedUrlCommand*)command;

- (void)setAge:(CDVInvokedUrlCommand*)command;
- (void)setCurrencyCode:(CDVInvokedUrlCommand*)command;
- (void)setGender:(CDVInvokedUrlCommand*)command;
- (void)setJailbroken:(CDVInvokedUrlCommand*)command;
- (void)setLocation:(CDVInvokedUrlCommand*)command;
- (void)setLocationWithAltitude:(CDVInvokedUrlCommand*)command;
- (void)setTRUSTeId:(CDVInvokedUrlCommand*)command;
- (void)setUseCookieMeasurement:(CDVInvokedUrlCommand*)command;
- (void)setUserEmail:(CDVInvokedUrlCommand*)command;
- (void)setUserId:(CDVInvokedUrlCommand*)command;
- (void)setUserName:(CDVInvokedUrlCommand*)command;
- (void)setFacebookUserId:(CDVInvokedUrlCommand*)command;
- (void)setTwitterUserId:(CDVInvokedUrlCommand*)command;
- (void)setGoogleUserId:(CDVInvokedUrlCommand*)command;
- (void)setPayingUser:(CDVInvokedUrlCommand *)command;
- (void)setPreloadData:(CDVInvokedUrlCommand *)command;
- (void)setShouldAutoCollectAppleAdvertisingIdentifier:(CDVInvokedUrlCommand*)command;
- (void)setShouldAutoCollectDeviceLocation:(CDVInvokedUrlCommand*)command;
- (void)setShouldAutoDetectJailbroken:(CDVInvokedUrlCommand*)command;
- (void)setShouldAutoGenerateAppleVendorIdentifier:(CDVInvokedUrlCommand*)command;

- (void)applicationDidOpenURL:(CDVInvokedUrlCommand*)command;

- (void)startAppToAppMeasurement:(CDVInvokedUrlCommand*)command;
- (void)setRedirectUrl:(CDVInvokedUrlCommand*)command;

- (void)checkForDeferredDeeplink:(CDVInvokedUrlCommand*)command;
- (void)automateIapEventMeasurement:(CDVInvokedUrlCommand*)command;

- (void)setExistingUser:(CDVInvokedUrlCommand*)command;
- (void)measureSession:(CDVInvokedUrlCommand*)command;

- (void)measureEventName:(CDVInvokedUrlCommand*)command;
- (void)measureEventId:(CDVInvokedUrlCommand*)command;
- (void)measureEvent:(CDVInvokedUrlCommand*)command;

- (void)getMatId:(CDVInvokedUrlCommand *)command;
- (void)getOpenLogId:(CDVInvokedUrlCommand *)command;
- (void)getIsPayingUser:(CDVInvokedUrlCommand *)command;

- (void)setAndroidId:(CDVInvokedUrlCommand *)command;
- (void)setGoogleAdvertisingId:(CDVInvokedUrlCommand *)command;
- (void)setDeviceId:(CDVInvokedUrlCommand *)command;

- (void)showBanner:(CDVInvokedUrlCommand*)command;
- (void)hideBanner:(CDVInvokedUrlCommand*)command;
- (void)cacheInterstitial:(CDVInvokedUrlCommand*)command;
- (void)showInterstitial:(CDVInvokedUrlCommand*)command;

@end