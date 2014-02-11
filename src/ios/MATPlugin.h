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
- (void)setFacebookUserId:(CDVInvokedUrlCommand*)command;
- (void)setTwitterUserId:(CDVInvokedUrlCommand*)command;
- (void)setGoogleUserId:(CDVInvokedUrlCommand*)command;

- (void)setShouldAutoDetectJailbroken:(CDVInvokedUrlCommand*)command;
- (void)setShouldAutoGenerateAppleVendorIdentifier:(CDVInvokedUrlCommand*)command;

- (void)applicationDidOpenURL:(CDVInvokedUrlCommand*)command;

- (void)setTracking:(CDVInvokedUrlCommand*)command;
- (void)setRedirectUrl:(CDVInvokedUrlCommand*)command;

- (void)setExistingUser:(CDVInvokedUrlCommand*)command;
- (void)trackSession:(CDVInvokedUrlCommand*)command;

- (void)trackAction:(CDVInvokedUrlCommand*)command;
- (void)trackActionWithItems:(CDVInvokedUrlCommand*)command;
- (void)trackActionWithReceipt:(CDVInvokedUrlCommand*)command;

- (void)setEventAttribute1:(CDVInvokedUrlCommand*)command;
- (void)setEventAttribute2:(CDVInvokedUrlCommand*)command;
- (void)setEventAttribute3:(CDVInvokedUrlCommand*)command;
- (void)setEventAttribute4:(CDVInvokedUrlCommand*)command;
- (void)setEventAttribute5:(CDVInvokedUrlCommand*)command;

@end