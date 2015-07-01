//
//  MATPlugin.m
//
//  Copyright 2015 HasOffers Inc. All rights reserved.
//

#import "MATPlugin.h"
#import <AdSupport/AdSupport.h>


#pragma mark - MobileAppTracker Category

@interface MobileAppTracker (PhoneGapPlugin)

+ (void)setPluginName:(NSString *)pluginName;

@end


@implementation MATPlugin


#pragma mark - Init Methods

- (void)init:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: init start");
    
    NSArray* arguments = command.arguments;
    
    NSString* advid = [arguments objectAtIndex:0];
    NSString* convkey = [arguments objectAtIndex:1];
    
    NSLog(@"MATPlugin: init: adv id = %@, conv key = %@", advid, convkey);
    
    CDVPluginResult* pluginResult = nil;
    if (advid == nil || convkey == nil || 0 == [advid length] || 0 == [convkey length])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Advertiser Id and Conversion Key cannot be nil"];
    }
    else
    {
        [MobileAppTracker initializeWithMATAdvertiserId:advid
                                       MATConversionKey:convkey];
        [MobileAppTracker setPluginName:@"phonegap"];
        [MobileAppTracker setAppleAdvertisingIdentifier:[[ASIdentifierManager sharedManager] advertisingIdentifier]
                             advertisingTrackingEnabled:[[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]];
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setDebugMode:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setDebugMode");
    
    NSArray* arguments = command.arguments;
    
    NSString* strEnable = [arguments objectAtIndex:0];
    
    if (![self isNull:strEnable])
    {
        BOOL enable = [strEnable boolValue];
        
        [MobileAppTracker setDebugMode:enable];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setDelegate:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setDelegate");
    
    NSArray* arguments = command.arguments;
    
    NSString* strEnable = [arguments objectAtIndex:0];
    
    if (![self isNull:strEnable])
    {
        BOOL enable = [strEnable boolValue];
        
        [MobileAppTracker setDelegate:enable ? self : nil];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)checkForDeferredDeeplink:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: checkForDeferredDeeplink");
    
    NSArray* arguments = command.arguments;
    
    NSNumber* numTimeout = [arguments objectAtIndex:0];
    
    if(![self isNull:numTimeout])
    {
        CGFloat timeout = [numTimeout doubleValue] / 1000; // millis --> sec
        
        [MobileAppTracker checkForDeferredDeeplinkWithTimeout:timeout];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)automateIapEventMeasurement:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: automateIapEventMeasurement");
    
    NSArray* arguments = command.arguments;
    
    NSString* strAutomate = [arguments objectAtIndex:0];
    
    if (![self isNull:strAutomate])
    {
        BOOL automate = [strAutomate boolValue];
        
        [MobileAppTracker automateIapEventMeasurement:automate];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

#pragma mark - Measure Session

- (void)measureSession:(CDVInvokedUrlCommand *)command
{
    NSLog(@"MATPlugin: measureSession");
    
    [MobileAppTracker measureSession];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

#pragma mark - Measure Events

- (void)measureEventName:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: measureEventName");
    
    NSArray* arguments = command.arguments;
    
    NSString *eventName = [arguments objectAtIndex:0];
    
    if(![self isNull:eventName])
    {
        [MobileAppTracker measureEventName:eventName];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)measureEventId:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: measureEventId");
    
    NSArray* arguments = command.arguments;
    
    NSString* strEventId = [arguments objectAtIndex:0];
    
    if(![self isNull:strEventId])
    {
        int eventId = [strEventId intValue];
        
        [MobileAppTracker measureEventId:eventId];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)measureEvent:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: measureEvent");
    
    NSArray* arguments = command.arguments;
    
    NSDictionary *dict = [arguments objectAtIndex:0];
    
    if(![self isNull:dict])
    {
        MATEvent *event = [self convertToMATEvent:dict];
        
        [MobileAppTracker measureEvent:event];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

#pragma mark - Setter Methods

- (void)setAllowDuplicates:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setAllowDuplicates");
    
    NSArray* arguments = command.arguments;
    
    NSString *strEnable = [arguments objectAtIndex:0];
    
    if(![self isNull:strEnable])
    {
        [MobileAppTracker setAllowDuplicateRequests:[strEnable boolValue]];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setPackageName:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setPackageName");
    
    NSArray* arguments = command.arguments;
    
    NSString *packageName = [arguments objectAtIndex:0];
    
    if(![self isNull:packageName])
    {
        [MobileAppTracker setPackageName:packageName];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setSiteId:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setSiteId");
    
    NSArray* arguments = command.arguments;
    
    NSString *siteId = [arguments objectAtIndex:0];
    
    if(![self isNull:siteId])
    {
        [MobileAppTracker setSiteId:siteId];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setCurrencyCode:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setCurrencyCode");
    
    NSArray* arguments = command.arguments;
    
    NSString *currencyCode = [arguments objectAtIndex:0];
    
    if(![self isNull:currencyCode])
    {
        [MobileAppTracker setCurrencyCode:currencyCode];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setAppleAdvertisingIdentifier:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setAppleAdvertisingIdentifier");
    
    NSArray* arguments = command.arguments;
    
    NSString *strAppleAdvId = [arguments objectAtIndex:0];
    NSString *strEnabled = [arguments objectAtIndex:1];
    
    id classNSUUID = NSClassFromString(@"NSUUID");
    
    CDVPluginResult* pluginResult = nil;
    
    if(classNSUUID)
    {
        if(![self isNull:strAppleAdvId] && ![self isNull:strEnabled])
        {
            NSUUID *ifa = [[classNSUUID alloc] initWithUUIDString:strAppleAdvId];
            BOOL trackingEnabled = [strEnabled boolValue];
            
            [MobileAppTracker setAppleAdvertisingIdentifier:ifa advertisingTrackingEnabled:trackingEnabled];
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }
    else
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"NSUUID class not found"];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setAppleVendorIdentifier:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setAppleVendorIdentifier");
    
    NSArray* arguments = command.arguments;
    
    NSString *strAppleVendorId = [arguments objectAtIndex:0];
    
    id classNSUUID = NSClassFromString(@"NSUUID");
    
    CDVPluginResult* pluginResult = nil;
    
    if(classNSUUID)
    {
        if(![self isNull:strAppleVendorId])
        {
            NSUUID *ifv = [[classNSUUID alloc] initWithUUIDString:strAppleVendorId];
            
            [MobileAppTracker setAppleVendorIdentifier:ifv];
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }
    else
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"NSUUID class not found"];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setTRUSTeId:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setTRUSTeId");
    
    NSArray* arguments = command.arguments;
    
    NSString *tpid = [arguments objectAtIndex:0];
    
    if(![self isNull:tpid])
    {
        [MobileAppTracker setTRUSTeId:tpid];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setUserEmail:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setUserEmail");
    
    NSArray* arguments = command.arguments;
    
    NSString *userEmail = [arguments objectAtIndex:0];
    
    if(![self isNull:userEmail])
    {
        [MobileAppTracker setUserEmail:userEmail];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setUserId:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setUserId");
    
    NSArray* arguments = command.arguments;
    
    NSString *userId = [arguments objectAtIndex:0];
    
    if(![self isNull:userId])
    {
        [MobileAppTracker setUserId:userId];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setUserName:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setUserName");
    
    NSArray* arguments = command.arguments;
    
    NSString *userName = [arguments objectAtIndex:0];
    
    if(![self isNull:userName])
    {
        [MobileAppTracker setUserName:userName];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setFacebookEventLogging:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setFacebookEventLogging");
    
    NSArray* arguments = command.arguments;
    
    NSString* strEnable = [arguments objectAtIndex:0];
    NSString* strLimit = [arguments objectAtIndex:1];
    
    if(![self isNull:strEnable] && ![self isNull:strLimit])
    {
        BOOL enable = [strEnable boolValue];
        BOOL limit = [strLimit boolValue];
        
        [MobileAppTracker setFacebookEventLogging:enable limitEventAndDataUsage:limit];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setFacebookUserId:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setFacebookUserId");
    
    NSArray* arguments = command.arguments;
    
    NSString *userId = [arguments objectAtIndex:0];
    
    if(![self isNull:userId])
    {
        [MobileAppTracker setFacebookUserId:userId];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setTwitterUserId:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setTwitterUserId");
    
    NSArray* arguments = command.arguments;
    
    NSString *userId = [arguments objectAtIndex:0];
    
    if(![self isNull:userId])
    {
        [MobileAppTracker setTwitterUserId:userId];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setGoogleUserId:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setGoogleUserId");
    
    NSArray* arguments = command.arguments;
    
    NSString *userId = [arguments objectAtIndex:0];
    
    if(![self isNull:userId])
    {
        [MobileAppTracker setGoogleUserId:userId];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setJailbroken:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setJailbroken");
    
    NSArray* arguments = command.arguments;
    
    NSString* strJailbroken = [arguments objectAtIndex:0];
    
    if(![self isNull:strJailbroken])
    {
        BOOL jailbroken = [strJailbroken boolValue];
        
        [MobileAppTracker setJailbroken:jailbroken];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setAge:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setAge");
    
    NSArray* arguments = command.arguments;
    
    NSString* strAge = [arguments objectAtIndex:0];
    
    if(![self isNull:strAge])
    {
        int age = [strAge intValue];
        
        [MobileAppTracker setAge:age];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setLocation:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setLocation");
    
    NSArray* arguments = command.arguments;
    
    NSNumber* numLat = [arguments objectAtIndex:0];
    NSNumber* numLon = [arguments objectAtIndex:1];
    
    if(![self isNull:numLat]
       && ![self isNull:numLon])
    {
        CGFloat lat = [numLat doubleValue];
        CGFloat lon = [numLon doubleValue];
        
        [MobileAppTracker setLatitude:lat longitude:lon];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setLocationWithAltitude:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setLocationWithAltitude");
    
    NSArray* arguments = command.arguments;
    
    NSNumber* numLat = [arguments objectAtIndex:0];
    NSNumber* numLon = [arguments objectAtIndex:1];
    NSNumber* numAlt = [arguments objectAtIndex:2];
    
    if(![self isNull:numLat]
       && ![self isNull:numLon]
       && ![self isNull:numAlt])
    {
        CGFloat lat = [numLat doubleValue];
        CGFloat lon = [numLon doubleValue];
        CGFloat alt = [numAlt doubleValue];
        
        [MobileAppTracker setLatitude:lat longitude:lon altitude:alt];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setUseCookieTracking:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setUseCookieTracking");
    
    NSArray* arguments = command.arguments;
    
    NSString* strUseCookie = [arguments objectAtIndex:0];
    
    if(![self isNull:strUseCookie])
    {
        BOOL useCookie = [strUseCookie boolValue];
        
        [MobileAppTracker setUseCookieTracking:useCookie];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setShouldAutoDetectJailbroken:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setShouldAutoDetectJailbroken");
    
    NSArray* arguments = command.arguments;
    
    NSString* strAutoDetect = [arguments objectAtIndex:0];
    
    if(![self isNull:strAutoDetect])
    {
        BOOL autoDetect = [strAutoDetect boolValue];
        
        [MobileAppTracker setShouldAutoDetectJailbroken:autoDetect];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setShouldAutoGenerateAppleVendorIdentifier:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setShouldAutoGenerateAppleVendorIdentifier");
    
    NSArray* arguments = command.arguments;
    
    NSString* strAutoGen = [arguments objectAtIndex:0];
    
    if(![self isNull:strAutoGen])
    {
        BOOL autoGen = [strAutoGen boolValue];
        
        [MobileAppTracker setShouldAutoGenerateAppleVendorIdentifier:autoGen];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setAppAdTracking:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setAppAdTracking");
    
    NSArray* arguments = command.arguments;
    
    NSString* strEnable = [arguments objectAtIndex:0];
    
    if(![self isNull:strEnable])
    {
        BOOL enable = [strEnable boolValue];
        
        [MobileAppTracker setAppAdTracking:enable];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setGender:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setGender");
    
    NSArray* arguments = command.arguments;
    
    NSString* strGender = [arguments objectAtIndex:0];
    
    if(![self isNull:strGender])
    {
        int gender = [strGender intValue];
        
        [MobileAppTracker setGender:gender];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)applicationDidOpenURL:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: applicationDidOpenURL");
    
    NSArray* arguments = command.arguments;
    
    NSString* strURL = [arguments objectAtIndex:0];
    NSString* strSource = [arguments objectAtIndex:1];
    
    if(![self isNull:strURL]
       && ![self isNull:strSource])
    {
        [MobileAppTracker applicationDidOpenURL:strURL sourceApplication:strSource];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)startAppToAppTracking:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: startAppToAppTracking");
    
    NSArray* arguments = command.arguments;
    
    NSString* strTargetAppPackageName = [arguments objectAtIndex:0];
    NSString* strTargetAdvId = [arguments objectAtIndex:1];
    NSString* strTargetOfferId = [arguments objectAtIndex:2];
    NSString* strTargetPublisherId = [arguments objectAtIndex:3];
    NSString* strShouldRedirect = [arguments objectAtIndex:4];
    
    if(![self isNull:strTargetAppPackageName]
       && ![self isNull:strTargetAdvId]
       && ![self isNull:strTargetOfferId]
       && ![self isNull:strTargetPublisherId]
       && ![self isNull:strShouldRedirect])
    {
        BOOL shouldRedirect = [strShouldRedirect boolValue];
        
        [MobileAppTracker startAppToAppTracking:strTargetAppPackageName
                                   advertiserId:strTargetAdvId
                                        offerId:strTargetOfferId
                                    publisherId:strTargetPublisherId
                                       redirect:shouldRedirect];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setRedirectUrl:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setRedirectUrl");
    
    NSArray* arguments = command.arguments;
    
    NSString* strURL = [arguments objectAtIndex:0];
    
    if(![self isNull:strURL])
    {
        [MobileAppTracker setRedirectUrl:strURL];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setExistingUser:(CDVInvokedUrlCommand *)command
{
    NSLog(@"MATPlugin: setExistingUser");
    
    NSArray* arguments = command.arguments;
    
    NSString* strExistingUser = [arguments objectAtIndex:0];
    
    if(![self isNull:strExistingUser])
    {
        BOOL isExistingUser = [strExistingUser boolValue];
        
        [MobileAppTracker setExistingUser:isExistingUser];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

-(void)setPayingUser:(CDVInvokedUrlCommand *)command
{
    NSLog(@"MATPlugin: setPayingUser");
    
    NSArray* arguments = command.arguments;
    
    NSString* strPayingUser = [arguments objectAtIndex:0];
    
    if(![self isNull:strPayingUser])
    {
        BOOL isPayingUser = [strPayingUser boolValue];
        
        [MobileAppTracker setPayingUser:isPayingUser];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

- (void)setPreloadData:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setPreloadData");
    
    NSArray* arguments = command.arguments;
    
    NSDictionary *dict = [arguments objectAtIndex:0];
    
    if(![self isNull:dict])
    {
        MATPreloadData *pd = [self convertToMATPreloadData:dict];
        
        [MobileAppTracker setPreloadData:pd];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else
    {
        [self throwInvalidArgsErrorForCommand:command];
    }
}

#pragma mark - Getter Methods

- (void)getMatId:(CDVInvokedUrlCommand *)command
{
    NSLog(@"MATPlugin: getMatId");
    
    NSString *matId = [MobileAppTracker matId];
    
    NSLog(@"MATPlugin: getMatId: %@", matId);
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:matId];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getOpenLogId:(CDVInvokedUrlCommand *)command
{
    NSLog(@"MATPlugin: getOpenLogId");
    
    NSString *logId = [MobileAppTracker openLogId];
    NSLog(@"MATPlugin: getOpenLogId: %@", logId);
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:logId];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getIsPayingUser:(CDVInvokedUrlCommand *)command
{
    NSLog(@"MATPlugin: getIsPayingUser");
    
    BOOL payingUser = [MobileAppTracker isPayingUser];
    NSLog(@"MATPlugin: getIsPayingUser: %d", payingUser);
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:payingUser];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

#pragma mark - Android only placeholder methods

- (void)setAndroidId:(CDVInvokedUrlCommand*)command
{
    // no-op Android only placeholder method
}

- (void)setAndroidIdMd5:(CDVInvokedUrlCommand*)command
{
    // no-op Android only placeholder method
}

- (void)setAndroidIdSha1:(CDVInvokedUrlCommand*)command
{
    // no-op Android only placeholder method
}

- (void)setAndroidIdSha256:(CDVInvokedUrlCommand*)command
{
    // no-op Android only placeholder method
}

- (void)setDeviceId:(CDVInvokedUrlCommand*)command
{
    // no-op Android only placeholder method
}

- (void)setGoogleAdvertisingId:(CDVInvokedUrlCommand *)command
{
    // no-op Android only placeholder method
}

- (void)setEmailCollection:(CDVInvokedUrlCommand*)command
{
    // no-op Android only placeholder method
}

#pragma mark - Helper Methods

- (MATEvent *)convertToMATEvent:(NSDictionary *)dict
{
    MATEvent *event = nil;
    
    NSString *strEventName = dict[@"name"];
    NSNumber *numEventId = dict[@"id"];
    
    if((strEventName && ![self isNull:strEventName]) || (numEventId && ![self isNull:numEventId]))
    {
        if(strEventName && ![self isNull:strEventName])
        {
            event = [MATEvent eventWithName:strEventName];
        }
        else
        {
            int eventId = [numEventId intValue];
            
            event = [MATEvent eventWithId:eventId];
        }
        
        NSString *strContentId = dict[@"contentId"];
        NSString *strContentType = dict[@"contentType"];
        NSString *strCurrency = dict[@"currency"];
        NSString *strEventAttribute1 = dict[@"attribute1"];
        NSString *strEventAttribute2 = dict[@"attribute2"];
        NSString *strEventAttribute3 = dict[@"attribute3"];
        NSString *strEventAttribute4 = dict[@"attribute4"];
        NSString *strEventAttribute5 = dict[@"attribute5"];
        NSString *strReceipt = dict[@"receipt"];
        NSString *strRefId = dict[@"advertiserRefId"];
        NSString *strSearchString = dict[@"searchString"];
        
        NSNumber *numLevel = dict[@"level"];
        NSNumber *numQuantity = dict[@"revenue"];
        NSNumber *numRev = dict[@"revenue"];
        NSNumber *numRating = dict[@"rating"];
        NSNumber *numTransactionState = dict[@"transactionState"];
        NSNumber *numDate1Millis = dict[@"date1"];
        NSNumber *numDate2Millis = dict[@"date2"];
        
        NSArray *arrItems = dict[@"eventItems"];
        
        if(numDate1Millis && ![self isNull:numDate1Millis])
        {
            double dateMillis = [numDate1Millis doubleValue];
            NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:dateMillis / 1000];
            event.date1 = date1;
        }
        if(numDate2Millis && ![self isNull:numDate2Millis])
        {
            double dateMillis = [numDate2Millis doubleValue];
            NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:dateMillis / 1000];
            event.date2 = date2;
        }
        if(strContentId && ![self isNull:strContentId])
        {
            event.contentId = strContentId;
        }
        if(strContentType && ![self isNull:strContentType])
        {
            event.contentType = strContentType;
        }
        if(strSearchString && ![self isNull:strSearchString])
        {
            event.searchString = strSearchString;
        }
        if (numLevel && ![self isNull:numLevel])
        {
            event.level = [numLevel intValue];
        }
        if (numQuantity && ![self isNull:numQuantity])
        {
            event.quantity = [numQuantity intValue];
        }
        if (numRating && ![self isNull:numRating])
        {
            event.rating = [numRating doubleValue];
        }
        if(strEventAttribute1 && ![self isNull:strEventAttribute1])
        {
            event.attribute1 = strEventAttribute1;
        }
        if(strEventAttribute2 && ![self isNull:strEventAttribute2])
        {
            event.attribute2 = strEventAttribute2;
        }
        if(strEventAttribute3 && ![self isNull:strEventAttribute3])
        {
            event.attribute3 = strEventAttribute3;
        }
        if(strEventAttribute4 && ![self isNull:strEventAttribute4])
        {
            event.attribute4 = strEventAttribute4;
        }
        if(strEventAttribute5 && ![self isNull:strEventAttribute5])
        {
            event.attribute5 = strEventAttribute5;
        }
        if(strRefId && ![self isNull:strRefId])
        {
            event.refId = strRefId;
        }
        if(strCurrency && ![self isNull:strCurrency])
        {
            event.currencyCode = strCurrency;
        }
        
        double revenue = 0;
        if(numRev && ![self isNull:numRev])
        {
            revenue = [numRev doubleValue];
        }
        
        // Ref: https://developer.apple.com/library/mac/documentation/StoreKit/Reference/SKPaymentTransaction_Class/Reference/Reference.html#//apple_ref/c/econst/SKPaymentTransactionStatePurchased
        // default to -1, since valid values start from 0
        int transactionState = -1;
        if(numTransactionState && ![self isNull:numTransactionState])
        {
            transactionState = [numTransactionState intValue];
        }
        
        NSData *receiptData = nil;
        if(strReceipt && ![self isNull:strReceipt])
        {
            receiptData = [[NSData alloc] initWithBase64EncodedString:strReceipt options:0];
        }
        
        // handle null value
        arrItems = [self isNull:arrItems] ? nil : arrItems;
        // convert array of dictionary representations to array of MATEventItem
        arrItems = [self convertToMATEventItems:arrItems];
        
        event.eventItems = arrItems;
        event.revenue = revenue;
        event.transactionState = transactionState;
        event.receipt = receiptData;
    }
    
    return event;
}

- (NSArray *)convertToMATEventItems:(NSArray *)arrDictionaries
{
    NSMutableArray *arrItems = [NSMutableArray array];
    
    for (NSDictionary *dict in arrDictionaries) {
        
        NSString *strName = [dict valueForKey:@"item"];
        if(strName && ![self isNull:strName])
        {
            NSString *name = strName;
        
            NSString *strUnitPrice = [dict valueForKey:@"unit_price"];
            float unitPrice = 0;
            if(strUnitPrice && ![self isNull:strUnitPrice])
            {
                unitPrice = [strUnitPrice floatValue];
            }
            
            NSString *strQuantity = [dict valueForKey:@"quantity"];
            int quantity = 0;
            if(strQuantity && ![self isNull:strQuantity])
            {
                unitPrice = [strQuantity intValue];
            }
            
            NSString *strRevenue = [dict valueForKey:@"revenue"];
            float revenue = 0;
            if(strRevenue && ![self isNull:strRevenue])
            {
                unitPrice = [strRevenue floatValue]
            }
            
            NSString *strAttribute1 = [dict valueForKey:@"attribute1"];
            NSString *attribute1 = nil;
            if(strAttribute1 && ![self isNull:strAttribute1])
            {
                attribute1 = strAttribute1;
            }
            
            NSString *strAttribute2 = [dict valueForKey:@"attribute2"];
            NSString *attribute2 = nil;
            if(strAttribute2 && ![self isNull:strAttribute2])
            {
                attribute2 = strAttribute2;
            }
            
            NSString *strAttribute3 = [dict valueForKey:@"attribute3"];
            NSString *attribute3 = nil;
            if(strAttribute3 && ![self isNull:strAttribute3])
            {
                attribute3 = strAttribute3;
            }
            
            NSString *strAttribute4 = [dict valueForKey:@"attribute4"];
            NSString *attribute4 = nil;
            if(strAttribute4 && ![self isNull:strAttribute4])
            {
                attribute4 = strAttribute4;
            }
            
            NSString *strAttribute5 = [dict valueForKey:@"attribute5"];
            NSString *attribute5 = nil;
            if(strAttribute5 && ![self isNull:strAttribute5])
            {
                attribute5 = strAttribute5;
            }
            
            MATEventItem *item = [MATEventItem eventItemWithName:name
                                                       unitPrice:unitPrice
                                                        quantity:quantity
                                                         revenue:revenue
                                                      attribute1:attribute1
                                                      attribute2:attribute2
                                                      attribute3:attribute3
                                                      attribute4:attribute4
                                                      attribute5:attribute5];
            
            [arrItems addObject:item];
        }
    }
    
    return arrItems;
}

- (MATPreloadData *)convertToMATPreloadData:(NSDictionary *)dict
{
    MATPreloadData *pd = nil;
    
    NSString *publisherId = [dict valueForKey:@"publisherId"];
    
    if(publisherId)
    {
        pd = [MATPreloadData preloadDataWithPublisherId:publisherId];
        
        NSString *advertiserSubAd = [dict valueForKey:@"advertiserSubAd"];
        NSString *advertiserSubAdgroup = [dict valueForKey:@"advertiserSubAdgroup"];
        NSString *advertiserSubCampaign = [dict valueForKey:@"advertiserSubCampaign"];
        NSString *advertiserSubKeyword = [dict valueForKey:@"advertiserSubKeyword"];
        NSString *advertiserSubPublisher = [dict valueForKey:@"advertiserSubPublisher"];
        NSString *advertiserSubSite = [dict valueForKey:@"advertiserSubSite"];
        NSString *agencyId = [dict valueForKey:@"agencyId"];
        NSString *offerId= [dict valueForKey:@"offerId"];
        NSString *publisherReferenceId = [dict valueForKey:@"publisherReferenceId"];
        NSString *publisherSub1 = [dict valueForKey:@"publisherSub1"];
        NSString *publisherSub2 = [dict valueForKey:@"publisherSub2"];
        NSString *publisherSub3 = [dict valueForKey:@"publisherSub3"];
        NSString *publisherSub4 = [dict valueForKey:@"publisherSub4"];
        NSString *publisherSub5 = [dict valueForKey:@"publisherSub5"];
        NSString *publisherSubAd = [dict valueForKey:@"publisherSubAd"];
        NSString *publisherSubAdgroup = [dict valueForKey:@"publisherSubAdgroup"];
        NSString *publisherSubCampaign = [dict valueForKey:@"publisherSubCampaign"];
        NSString *publisherSubKeyword = [dict valueForKey:@"publisherSubKeyword"];
        NSString *publisherSubPublisher = [dict valueForKey:@"publisherSubPublisher"];
        NSString *publisherSubSite = [dict valueForKey:@"publisherSubSite"];
        
        if(advertiserSubAd && ![self isNull:advertiserSubAd])
        {
            pd.advertiserSubAd = advertiserSubAd;
        }
        
        if(advertiserSubAdgroup && ![self isNull:advertiserSubAdgroup])
        {
            pd.advertiserSubAdgroup = advertiserSubAdgroup;
        }
        
        if(advertiserSubCampaign && ![self isNull:advertiserSubCampaign])
        {
            pd.advertiserSubCampaign = advertiserSubCampaign;
        }
        
        if(advertiserSubKeyword && ![self isNull:advertiserSubKeyword])
        {
            pd.advertiserSubKeyword = advertiserSubKeyword;
        }
        
        if(advertiserSubPublisher && ![self isNull:advertiserSubPublisher])
        {
            pd.advertiserSubPublisher = advertiserSubPublisher;
        }
        
        if(advertiserSubSite && ![self isNull:advertiserSubSite])
        {
            pd.advertiserSubSite = advertiserSubSite;
        }
        
        if(agencyId && ![self isNull:agencyId])
        {
            pd.agencyId = agencyId;
        }
        
        if(offerId && ![self isNull:offerId])
        {
            pd.offerId = offerId;
        }
        
        if(publisherReferenceId && ![self isNull:publisherReferenceId])
        {
            pd.publisherReferenceId = publisherReferenceId;
        }
        
        if(publisherSub1 && ![self isNull:publisherSub1])
        {
            pd.publisherSub1 = publisherSub1;
        }
        
        if(publisherSub2 && ![self isNull:publisherSub2])
        {
            pd.publisherSub2 = publisherSub2;
        }
        
        if(publisherSub3 && ![self isNull:publisherSub3])
        {
            pd.publisherSub3 = publisherSub3;
        }
        
        if(publisherSub4 && ![self isNull:publisherSub4])
        {
            pd.publisherSub4 = publisherSub4;
        }
        
        if(publisherSub5 && ![self isNull:publisherSub5])
        {
            pd.publisherSub5 = publisherSub5;
        }
        
        if(publisherSubAd && ![self isNull:publisherSubAd])
        {
            pd.publisherSubAd = publisherSubAd;
        }
        
        if(publisherSubAdgroup && ![self isNull:publisherSubAdgroup])
        {
            pd.publisherSubAdgroup = publisherSubAdgroup;
        }
        
        if(publisherSubCampaign && ![self isNull:publisherSubCampaign])
        {
            pd.publisherSubCampaign = publisherSubCampaign;
        }
        
        if(publisherSubKeyword && ![self isNull:publisherSubKeyword])
        {
            pd.publisherSubKeyword = publisherSubKeyword;
        }
        
        if(publisherSubPublisher && ![self isNull:publisherSubPublisher])
        {
            pd.publisherSubPublisher = publisherSubPublisher;
        }
        
        if(publisherSubSite && ![self isNull:publisherSubSite])
        {
            pd.publisherSubSite = publisherSubSite;
        }
    }
    
    return pd;
}

#pragma mark - Helper Methods

- (void)throwInvalidArgsErrorForCommand:(CDVInvokedUrlCommand*)command
{
    NSString *msg = [NSString stringWithFormat:@"Invalid arguments passed: %@", command.arguments];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:msg];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (BOOL)isNull:(id)obj
{
    return obj == [NSNull null];
}

#pragma mark - MobileAppTrackerDelegate Methods

- (void)mobileAppTrackerDidSucceedWithData:(id)data
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"MATPlugin.matDelegate.success: %@", str);
}

- (void)mobileAppTrackerDidFailWithError:(NSError *)error
{
    NSLog(@"MATPlugin.matDelegate.failure: %@", error);
}

- (void)mobileAppTrackerEnqueuedActionWithReferenceId:(NSString *)referenceId
{
    NSLog(@"MATPlugin.matDelegate.enqueued: %@", referenceId);
}

- (void)mobileAppTrackerDidReceiveDeeplink:(NSString *)deeplink
{
    NSLog(@"MATPlugin.matDelegate.deferredDeeplink: %@", deeplink);
}

@end