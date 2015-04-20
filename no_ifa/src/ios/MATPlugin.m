//
//  MATPlugin.m
//
//  Copyright 2015 HasOffers Inc. All rights reserved.
//

#import "MATPlugin.h"

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
        [MobileAppTracker measureAction:eventName];
        
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
        
        [MobileAppTracker measureActionWithEventId:eventId];
        
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
    
    NSString *strEventName = dict[@"name"];
    NSNumber *numEventId = dict[@"id"];
    
    if((strEventName && ![self isNull:strEventName]) || (numEventId && ![self isNull:numEventId]))
    {
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
        NSNumber* numDate1Millis = dict[@"date1"];
        NSNumber* numDate2Millis = dict[@"date2"];
        
        NSArray *arrItems = dict[@"eventItems"];
        
        if(numDate1Millis && ![self isNull:numDate1Millis])
        {
            double dateMillis = [numDate1Millis doubleValue];
            NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:dateMillis / 1000];
            [MobileAppTracker setEventDate1:date1];
        }
        if(numDate2Millis && ![self isNull:numDate2Millis])
        {
            double dateMillis = [numDate2Millis doubleValue];
            NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:dateMillis / 1000];
            [MobileAppTracker setEventDate2:date2];
        }
        if(strContentId && ![self isNull:strContentId])
        {
            [MobileAppTracker setEventContentId:strContentId];
        }
        if(strContentType && ![self isNull:strContentType])
        {
            [MobileAppTracker setEventContentType:strContentType];
        }
        if(strSearchString && ![self isNull:strSearchString])
        {
            [MobileAppTracker setEventSearchString:strSearchString];
        }
        if (numLevel && ![self isNull:numLevel])
        {
            [MobileAppTracker setEventLevel:[numLevel intValue]];
        }
        if (numQuantity && ![self isNull:numQuantity])
        {
            [MobileAppTracker setEventQuantity:[numQuantity intValue]];
        }
        if (numRating && ![self isNull:numRating])
        {
            [MobileAppTracker setEventRating:[numRating doubleValue]];
        }
        if(strEventAttribute1 && ![self isNull:strEventAttribute1])
        {
            [MobileAppTracker setEventAttribute1:strEventAttribute1];
        }
        if(strEventAttribute2 && ![self isNull:strEventAttribute2])
        {
            [MobileAppTracker setEventAttribute2:strEventAttribute2];
        }
        if(strEventAttribute3 && ![self isNull:strEventAttribute3])
        {
            [MobileAppTracker setEventAttribute3:strEventAttribute3];
        }
        if(strEventAttribute4 && ![self isNull:strEventAttribute4])
        {
            [MobileAppTracker setEventAttribute4:strEventAttribute4];
        }
        if(strEventAttribute5 && ![self isNull:strEventAttribute5])
        {
            [MobileAppTracker setEventAttribute5:strEventAttribute5];
        }
        if([self isNull:strRefId])
        {
            strRefId = nil;
        }
        if([self isNull:strCurrency])
        {
            strCurrency = nil;
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
            receiptData = [strReceipt dataUsingEncoding:NSUTF8StringEncoding];
        }
        
        // handle null value
        arrItems = [self isNull:arrItems] ? nil : arrItems;
        // convert array of dictionary representations to array of MATEventItem
        arrItems = [self convertToMATEventItems:arrItems];
        
        if(strEventName && ![self isNull:strEventName])
        {
            [MobileAppTracker measureAction:strEventName
                                 eventItems:arrItems
                                referenceId:strRefId
                              revenueAmount:revenue
                               currencyCode:strCurrency
                           transactionState:transactionState
                                    receipt:receiptData];
        }
        else
        {
            int eventId = [numEventId intValue];
            
            [MobileAppTracker measureActionWithEventId:eventId
                                            eventItems:arrItems
                                           referenceId:strRefId
                                         revenueAmount:revenue
                                          currencyCode:strCurrency
                                      transactionState:transactionState
                                               receipt:receiptData];
        }
        
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

#pragma mark - Getter Methods

- (void)getMatId:(CDVInvokedUrlCommand *)command
{
    NSLog(@"MATPlugin: getMatId");
    
    NSString *matId = [MobileAppTracker matId];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:matId];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getOpenLogId:(CDVInvokedUrlCommand *)command
{
    NSLog(@"MATPlugin: getOpenLogId");
    
    NSString *logId = [MobileAppTracker openLogId];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:logId];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getIsPayingUser:(CDVInvokedUrlCommand *)command
{
    NSLog(@"MATPlugin: getIsPayingUser");
    
    BOOL payingUser = [MobileAppTracker isPayingUser];
    
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

- (NSArray *)convertToMATEventItems:(NSArray *)arrDictionaries
{
    NSMutableArray *arrItems = [NSMutableArray array];
    
    for (NSDictionary *dict in arrDictionaries) {
        
        NSString *name = [dict valueForKey:@"item"];
        NSString *strUnitPrice = [dict valueForKey:@"unit_price"];
        float unitPrice = [NSNull null] == (id)strUnitPrice ? 0 : [strUnitPrice floatValue];
        
        NSString *strQuantity = [dict valueForKey:@"quantity"];
        int quantity = [NSNull null] == (id)strQuantity ? 0 : [strQuantity intValue];
        
        NSString *strRevenue = [dict valueForKey:@"revenue"];
        float revenue = [NSNull null] == (id)strRevenue ? 0 : [strRevenue floatValue];
        
        NSString *attribute1 = [dict valueForKey:@"attribute1"];
        NSString *attribute2 = [dict valueForKey:@"attribute2"];
        NSString *attribute3 = [dict valueForKey:@"attribute3"];
        NSString *attribute4 = [dict valueForKey:@"attribute4"];
        NSString *attribute5 = [dict valueForKey:@"attribute5"];
        
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
    
    return arrItems;
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