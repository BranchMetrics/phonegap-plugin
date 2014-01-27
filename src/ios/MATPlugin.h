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

- (void)sdkDataParameters:(CDVInvokedUrlCommand*)command;
- (void)setAllowDuplicates:(CDVInvokedUrlCommand*)command;
- (void)setDebugMode:(CDVInvokedUrlCommand*)command;
- (void)setDelegate:(CDVInvokedUrlCommand*)command;

- (void)setMATAdvertiserId:(CDVInvokedUrlCommand*)command;
- (void)setMATConversionKey:(CDVInvokedUrlCommand*)command;
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
- (void)setMACAddress:(CDVInvokedUrlCommand*)command;
- (void)setOpenUDID:(CDVInvokedUrlCommand*)command;
- (void)setODIN1:(CDVInvokedUrlCommand*)command;
- (void)setTrusteTPID:(CDVInvokedUrlCommand*)command;
- (void)setUIID:(CDVInvokedUrlCommand*)command;
- (void)setUseCookieTracking:(CDVInvokedUrlCommand*)command;
- (void)setUserId:(CDVInvokedUrlCommand*)command;
- (void)setFacebookUserId:(CDVInvokedUrlCommand*)command;
- (void)setTwitterUserId:(CDVInvokedUrlCommand*)command;
- (void)setGoogleUserId:(CDVInvokedUrlCommand*)command;

- (void)setShouldAutoDetectJailbroken:(CDVInvokedUrlCommand*)command;
- (void)setShouldAutoGenerateAppleAdvertisingIdentifier:(CDVInvokedUrlCommand*)command;
- (void)setShouldAutoGenerateAppleVendorIdentifier:(CDVInvokedUrlCommand*)command;

- (void)applicationDidOpenURL:(CDVInvokedUrlCommand*)command;

- (void)setTracking:(CDVInvokedUrlCommand*)command;
- (void)setRedirectUrl:(CDVInvokedUrlCommand*)command;

- (void)trackInstall:(CDVInvokedUrlCommand*)command;
- (void)trackUpdate:(CDVInvokedUrlCommand*)command;

- (void)trackAction:(CDVInvokedUrlCommand*)command;
- (void)trackActionWithItems:(CDVInvokedUrlCommand*)command;
- (void)trackActionWithReceipt:(CDVInvokedUrlCommand*)command;

@end