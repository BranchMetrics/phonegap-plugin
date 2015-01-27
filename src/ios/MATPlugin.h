//
//  MATPlugin.h
//
//  Copyright 2013 HasOffers Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

#import "MobileAppTracker.h"

@interface MATPlugin : CDVPlugin <MobileAppTrackerDelegate>
{
    // empty
}

- (void)initTracker:(CDVInvokedUrlCommand*)command;

- (void)setAllowDuplicates:(CDVInvokedUrlCommand*)command;
- (void)setDebugMode:(CDVInvokedUrlCommand*)command;
- (void)setDelegate:(CDVInvokedUrlCommand*)command;

- (void)setPackageName:(CDVInvokedUrlCommand*)command;
- (void)setSiteId:(CDVInvokedUrlCommand*)command;

- (void)setAppAdTracking:(CDVInvokedUrlCommand*)command;
- (void)setAppleAdvertisingIdentifier:(CDVInvokedUrlCommand*)command;
- (void)setAppleVendorIdentifier:(CDVInvokedUrlCommand*)command;

- (void)setAge:(CDVInvokedUrlCommand*)command;
- (void)setCurrencyCode:(CDVInvokedUrlCommand*)command;
- (void)setGender:(CDVInvokedUrlCommand*)command;
- (void)setJailbroken:(CDVInvokedUrlCommand*)command;
- (void)setLocation:(CDVInvokedUrlCommand*)command;
- (void)setLocationWithAltitude:(CDVInvokedUrlCommand*)command;
- (void)setTRUSTeId:(CDVInvokedUrlCommand*)command;
- (void)setUseCookieTracking:(CDVInvokedUrlCommand*)command;
- (void)setUserEmail:(CDVInvokedUrlCommand*)command;
- (void)setUserId:(CDVInvokedUrlCommand*)command;
- (void)setUserName:(CDVInvokedUrlCommand*)command;
- (void)setFacebookEventLogging:(CDVInvokedUrlCommand*)command;
- (void)setFacebookUserId:(CDVInvokedUrlCommand*)command;
- (void)setTwitterUserId:(CDVInvokedUrlCommand*)command;
- (void)setGoogleUserId:(CDVInvokedUrlCommand*)command;
- (void)setPayingUser:(CDVInvokedUrlCommand *)command;
- (void)setShouldAutoDetectJailbroken:(CDVInvokedUrlCommand*)command;
- (void)setShouldAutoGenerateAppleVendorIdentifier:(CDVInvokedUrlCommand*)command;

- (void)applicationDidOpenURL:(CDVInvokedUrlCommand*)command;

- (void)startAppToAppTracking:(CDVInvokedUrlCommand*)command;
- (void)setRedirectUrl:(CDVInvokedUrlCommand*)command;

- (void)checkForDeferredDeeplink:(CDVInvokedUrlCommand*)command;
- (void)setExistingUser:(CDVInvokedUrlCommand*)command;
- (void)measureSession:(CDVInvokedUrlCommand*)command;

- (void)measureAction:(CDVInvokedUrlCommand*)command;
- (void)measureActionWithItems:(CDVInvokedUrlCommand*)command;
- (void)measureActionWithReceipt:(CDVInvokedUrlCommand*)command;

- (void)setEventAttribute1:(CDVInvokedUrlCommand*)command;
- (void)setEventAttribute2:(CDVInvokedUrlCommand*)command;
- (void)setEventAttribute3:(CDVInvokedUrlCommand*)command;
- (void)setEventAttribute4:(CDVInvokedUrlCommand*)command;
- (void)setEventAttribute5:(CDVInvokedUrlCommand*)command;

- (void)setEventContentType:(CDVInvokedUrlCommand*)command;
- (void)setEventContentId:(CDVInvokedUrlCommand*)command;
- (void)setEventDate1:(CDVInvokedUrlCommand*)command;
- (void)setEventDate2:(CDVInvokedUrlCommand*)command;
- (void)setEventLevel:(CDVInvokedUrlCommand*)command;
- (void)setEventQuantity:(CDVInvokedUrlCommand*)command;
- (void)setEventRating:(CDVInvokedUrlCommand*)command;
- (void)setEventSearchString:(CDVInvokedUrlCommand*)command;

- (void)getMatId:(CDVInvokedUrlCommand *)command;
- (void)getOpenLogId:(CDVInvokedUrlCommand *)command;
- (void)getIsPayingUser:(CDVInvokedUrlCommand *)command;

- (void)setAndroidId:(CDVInvokedUrlCommand *)command;
- (void)setAndroidIdMd5:(CDVInvokedUrlCommand *)command;
- (void)setAndroidIdSha1:(CDVInvokedUrlCommand *)command;
- (void)setAndroidIdSha256:(CDVInvokedUrlCommand *)command;
- (void)setGoogleAdvertisingId:(CDVInvokedUrlCommand *)command;
- (void)setDeviceId:(CDVInvokedUrlCommand *)command;
- (void)setEmailCollection:(CDVInvokedUrlCommand *)command;

@end