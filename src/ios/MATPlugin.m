//
//  MATPlugin.m
//
//  Copyright 2013 HasOffers Inc. All rights reserved.
//

#import "MATPlugin.h"

@implementation MATPlugin

- (void)initTracker:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: initTracker start");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString* advid = [arguments objectAtIndex:0];
        NSString* convkey = [arguments objectAtIndex:1];
        
        NSLog(@"MATPlugin: initTracker: adv id = %@, conv key = %@", advid, convkey);
        
        CDVPluginResult* pluginResult = nil;
        if (advid == nil || convkey == nil || 0 == [advid length] || 0 == [convkey length])
        {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Advertiser Id and Conversion Key cannot be nil"];
        }
        else
        {
            [[MobileAppTracker sharedManager] startTrackerWithMATAdvertiserId:advid
                                                             MATConversionKey:convkey];
            [[MobileAppTracker sharedManager] setPluginName:@"phonegap"];
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)setDebugMode:(CDVInvokedUrlCommand*)command
{
	NSLog(@"MATPlugin: setDebugMode");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        
        NSString* strEnable = [arguments objectAtIndex:0];
        
        if (![self isNull:strEnable])
        {
            BOOL enable = [strEnable boolValue];
            
            [[MobileAppTracker sharedManager] setDebugMode:enable];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setDelegate:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setDelegate");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        
        NSString* strEnable = [arguments objectAtIndex:0];
        
        if (![self isNull:strEnable])
        {
            BOOL enable = [strEnable boolValue];
            
            [[MobileAppTracker sharedManager] setDelegate:enable ? self : nil];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)sdkDataParameters:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: sdkDataParameters");
    
    [self.commandDelegate runInBackground:^{
        
        NSDictionary *dictParams = [[MobileAppTracker sharedManager] sdkDataParameters];
        
        NSLog(@"MAT SDK Data Params: %@", dictParams);
        
        CDVPluginResult* pluginResult = nil;
        
        if (dictParams != nil) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dictParams];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)trackInstall:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: trackInstall");
    
    NSArray* arguments = command.arguments;
    
    NSString *refId = nil;
    
    if ([NSNull null] != (id)arguments && [arguments count] == 1)
    {
        refId = [arguments objectAtIndex:0];
    }
    
    [self.commandDelegate runInBackground:^{
        [[MobileAppTracker sharedManager] trackInstallWithReferenceId:refId];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)trackUpdate:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: trackUpdate");
    
    NSArray* arguments = command.arguments;
    
    NSString *refId = nil;
    
    if ([NSNull null] != (id)arguments && [arguments count] == 1)
    {
        refId = [arguments objectAtIndex:0];
    }
    
    [self.commandDelegate runInBackground:^{
        [[MobileAppTracker sharedManager] trackUpdateWithReferenceId:refId];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)trackAction:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: trackAction");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        
        NSString *strEvent = [arguments objectAtIndex:0];
        NSString* strIsId = [arguments objectAtIndex:1];
        NSString *strRefId = [arguments objectAtIndex:2];
        NSNumber* numRev = [arguments objectAtIndex:3];
        NSString *strCurrency = [arguments objectAtIndex:4];
        
        if (![self isNull:strEvent]
            && ![self isNull:strIsId]
            && ![self isNull:numRev])
        {
            BOOL isId = [strIsId boolValue];
            
            double revenue = [numRev doubleValue];
            
            if([self isNull:strRefId])
            {
                strRefId = nil;
            }
            
            if([self isNull:strCurrency])
            {
                strCurrency = nil;
            }
            
            [[MobileAppTracker sharedManager] trackActionForEventIdOrName:strEvent
                                                                eventIsId:isId
                                                              referenceId:strRefId
                                                            revenueAmount:revenue
                                                             currencyCode:strCurrency];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)trackActionWithItems:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: trackActionWithItems");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        
        NSString *strEvent = [arguments objectAtIndex:0];
        NSNumber* strIsId = [arguments objectAtIndex:1];
        NSArray *arrItems = [arguments objectAtIndex:2];
        NSString *strRefId = [arguments objectAtIndex:3];
        NSNumber* numRev = [arguments objectAtIndex:4];
        NSString *strCurrency = [arguments objectAtIndex:5];
        
        if(![self isNull:strEvent]
           && ![self isNull:strIsId]
           && ![self isNull:numRev])
        {
            BOOL isId = [strIsId boolValue];
            
            arrItems = [NSNull null] == (id)arrItems ? nil : arrItems;
            arrItems = [self convertToMATEventItems:arrItems];
            
            double revenue = [numRev doubleValue];
            
            if([self isNull:strRefId])
            {
                strRefId = nil;
            }
            
            if([self isNull:strCurrency])
            {
                strCurrency = nil;
            }
            
            [[MobileAppTracker sharedManager] trackActionForEventIdOrName:strEvent
                                                                eventIsId:isId
                                                               eventItems:arrItems
                                                              referenceId:strRefId
                                                            revenueAmount:revenue
                                                             currencyCode:strCurrency];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)trackActionWithReceipt:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: trackActionWithReceipt");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        
        NSString *strEvent = [arguments objectAtIndex:0];
        NSNumber *strIsId = [arguments objectAtIndex:1];
        NSArray *arrItems = [arguments objectAtIndex:2];
        NSString *strRefId = [arguments objectAtIndex:3];
        NSNumber *numRev = [arguments objectAtIndex:4];
        NSString *strCurrency = [arguments objectAtIndex:5];
        NSNumber *numTransactionState = [arguments objectAtIndex:6];
        NSString *strReceipt = [arguments objectAtIndex:7];
        
        if(![self isNull:strEvent]
           && ![self isNull:strIsId]
           && ![self isNull:numRev]
           && ![self isNull:numTransactionState])
        {
            BOOL isId = [strIsId boolValue];
            
            arrItems = [NSNull null] == (id)arrItems ? nil : arrItems;
            arrItems = [self convertToMATEventItems:arrItems];
            
            double revenue = [numRev doubleValue];
            
            int transactionState = [numTransactionState intValue];
            
            if([self isNull:strRefId])
            {
                strRefId = nil;
            }
            
            if([self isNull:strCurrency])
            {
                strCurrency = nil;
            }
            
            NSData *receiptData = nil;
            
            if(![self isNull:strReceipt])
            {
                receiptData = [strReceipt dataUsingEncoding:NSUTF8StringEncoding];
            }
            
            [[MobileAppTracker sharedManager] trackActionForEventIdOrName:strEvent
                                                                eventIsId:isId
                                                               eventItems:arrItems
                                                              referenceId:strRefId
                                                            revenueAmount:revenue
                                                             currencyCode:strCurrency
                                                         transactionState:transactionState
                                                                  receipt:receiptData];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setAllowDuplicates:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setAllowDuplicates");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString *strEnable = [arguments objectAtIndex:0];
        
        if(![self isNull:strEnable])
        {
            [[MobileAppTracker sharedManager] setAllowDuplicateRequests:[strEnable boolValue]];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setPackageName:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setPackageName");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString *packageName = [arguments objectAtIndex:0];
        
        if(![self isNull:packageName])
        {
            [[MobileAppTracker sharedManager] setPackageName:packageName];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setSiteId:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setSiteId");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString *siteId = [arguments objectAtIndex:0];
        
        if(![self isNull:siteId])
        {
            [[MobileAppTracker sharedManager] setSiteId:siteId];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setCurrencyCode:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setCurrencyCode");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString *currencyCode = [arguments objectAtIndex:0];
        
        if(![self isNull:currencyCode])
        {
            [[MobileAppTracker sharedManager] setCurrencyCode:currencyCode];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setUIID:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setUIID");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString *uiid = [arguments objectAtIndex:0];
        
        if(![self isNull:uiid])
        {
            [[MobileAppTracker sharedManager] setUIID:uiid];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setMACAddress:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setMACAddress");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString *mac = [arguments objectAtIndex:0];
        
        if(![self isNull:mac])
        {
            [[MobileAppTracker sharedManager] setMACAddress:mac];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setAppleAdvertisingIdentifier:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setAppleAdvertisingIdentifier");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString *strAppleAdvId = [arguments objectAtIndex:0];
        
        id classNSUUID = NSClassFromString(@"NSUUID");
        
        CDVPluginResult* pluginResult = nil;
        
        if(classNSUUID)
        {
            if(![self isNull:strAppleAdvId])
            {
                [[MobileAppTracker sharedManager] setAppleAdvertisingIdentifier:[[classNSUUID alloc] initWithUUIDString:strAppleAdvId]];
                
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
    }];
}

- (void)setAppleVendorIdentifier:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setAppleVendorIdentifier");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString *strAppleVendorId = [arguments objectAtIndex:0];
        
        id classNSUUID = NSClassFromString(@"NSUUID");
        
        CDVPluginResult* pluginResult = nil;
        
        if(classNSUUID)
        {
            if(![self isNull:strAppleVendorId])
            {
                [[MobileAppTracker sharedManager] setAppleVendorIdentifier:[[classNSUUID alloc] initWithUUIDString:strAppleVendorId]];
                
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
    }];
}

- (void)setMATAdvertiserId:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setMATAdvertiserId");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString *advId = [arguments objectAtIndex:0];
        
        if(![self isNull:advId])
        {
            [[MobileAppTracker sharedManager] setMATAdvertiserId:advId];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setMATConversionKey:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setMATConversionKey");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString *convKey = [arguments objectAtIndex:0];
        
        if(![self isNull:convKey])
        {
            [[MobileAppTracker sharedManager] setMATConversionKey:convKey];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setOpenUDID:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setOpenUDID");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString *openUDID = [arguments objectAtIndex:0];
        
        if(![self isNull:openUDID])
        {
            [[MobileAppTracker sharedManager] setOpenUDID:openUDID];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setODIN1:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setODIN1");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        
        NSString *odin1 = [arguments objectAtIndex:0];
        
        if(![self isNull:odin1])
        {
            [[MobileAppTracker sharedManager] setODIN1:odin1];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setTrusteTPID:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setTrusteTPID");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString *tpid = [arguments objectAtIndex:0];
        
        if(![self isNull:tpid])
        {
            [[MobileAppTracker sharedManager] setTrusteTPID:tpid];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setUserId:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setUserId");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString *userId = [arguments objectAtIndex:0];
        
        if(![self isNull:userId])
        {
            [[MobileAppTracker sharedManager] setUserId:userId];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setFacebookUserId:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setFacebookUserId");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString *userId = [arguments objectAtIndex:0];
        
        if(![self isNull:userId])
        {
            [[MobileAppTracker sharedManager] setFacebookUserId:userId];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setTwitterUserId:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setTwitterUserId");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString *userId = [arguments objectAtIndex:0];
        
        if(![self isNull:userId])
        {
            [[MobileAppTracker sharedManager] setTwitterUserId:userId];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setGoogleUserId:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setGoogleUserId");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString *userId = [arguments objectAtIndex:0];
        
        if(![self isNull:userId])
        {
            [[MobileAppTracker sharedManager] setGoogleUserId:userId];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setJailbroken:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setJailbroken");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString* strJailbroken = [arguments objectAtIndex:0];
        
        if(![self isNull:strJailbroken])
        {
            BOOL jailbroken = [strJailbroken boolValue];
            
            [[MobileAppTracker sharedManager] setJailbroken:jailbroken];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setAge:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setAge");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString* strAge = [arguments objectAtIndex:0];
        
        if(![self isNull:strAge])
        {
            int age = [strAge intValue];
            
            [[MobileAppTracker sharedManager] setGender:age];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setLocation:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setLocation");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        
        NSNumber* numLat = [arguments objectAtIndex:0];
        NSNumber* numLon = [arguments objectAtIndex:1];
        
        if(![self isNull:numLat]
           && ![self isNull:numLon])
        {
            CGFloat lat = [numLat doubleValue];
            CGFloat lon = [numLon doubleValue];
            
            [[MobileAppTracker sharedManager] setLatitude:lat longitude:lon];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setLocationWithAltitude:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setLocationWithAltitude");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
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
            
            [[MobileAppTracker sharedManager] setLatitude:lat longitude:lon altitude:alt];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setUseCookieTracking:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setUseCookieTracking");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString* strUseCookie = [arguments objectAtIndex:0];
        
        if(![self isNull:strUseCookie])
        {
            BOOL useCookie = [strUseCookie boolValue];
            
            [[MobileAppTracker sharedManager] setUseCookieTracking:useCookie];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setShouldAutoDetectJailbroken:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setShouldAutoDetectJailbroken");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString* strAutoDetect = [arguments objectAtIndex:0];
        
        if(![self isNull:strAutoDetect])
        {
            BOOL autoDetect = [strAutoDetect boolValue];
            
            [[MobileAppTracker sharedManager] setShouldAutoDetectJailbroken:autoDetect];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setShouldAutoGenerateAppleAdvertisingIdentifier:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setShouldAutoGenerateAppleAdvertisingIdentifier");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString* strAutoGen = [arguments objectAtIndex:0];
        
        if(![self isNull:strAutoGen])
        {
            BOOL autoGen = [strAutoGen boolValue];
            
            [[MobileAppTracker sharedManager] setShouldAutoGenerateAppleAdvertisingIdentifier:autoGen];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setShouldAutoGenerateAppleVendorIdentifier:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setShouldAutoGenerateAppleVendorIdentifier");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString* strAutoGen = [arguments objectAtIndex:0];
        
        if(![self isNull:strAutoGen])
        {
            BOOL autoGen = [strAutoGen boolValue];
            
            [[MobileAppTracker sharedManager] setShouldAutoGenerateAppleVendorIdentifier:autoGen];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setAppAdTracking:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setAppAdTracking");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString* strEnable = [arguments objectAtIndex:0];
        
        if(![self isNull:strEnable])
        {
            BOOL enable = [strEnable boolValue];
            
            [[MobileAppTracker sharedManager] setAppAdTracking:enable];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setGender:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setGender");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString* strGender = [arguments objectAtIndex:0];
        
        if(![self isNull:strGender])
        {
            int gender = [strGender intValue];
            
            [[MobileAppTracker sharedManager] setGender:gender];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)applicationDidOpenURL:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: applicationDidOpenURL");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString* strURL = [arguments objectAtIndex:0];
        NSString* strSource = [arguments objectAtIndex:1];
        
        if(![self isNull:strURL]
           && ![self isNull:strSource])
        {
            [[MobileAppTracker sharedManager] applicationDidOpenURL:strURL sourceApplication:strSource];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
}

- (void)setTracking:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setTracking");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
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
            
            [[MobileAppTracker sharedManager] setTracking:strTargetAppPackageName
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
    }];
}

- (void)setRedirectUrl:(CDVInvokedUrlCommand*)command
{
    NSLog(@"MATPlugin: setRedirectUrl");
    
    NSArray* arguments = command.arguments;
    
    [self.commandDelegate runInBackground:^{
        NSString* strURL = [arguments objectAtIndex:0];
        
        if(![self isNull:strURL])
        {
            [[MobileAppTracker sharedManager] setRedirectUrl:strURL];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else
        {
            [self throwInvalidArgsErrorForCommand:command];
        }
    }];
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

- (void)mobileAppTracker:(MobileAppTracker *)tracker didSucceedWithData:(id)data
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"MATPlugin.matDelegate.success: %@", str);
}

- (void)mobileAppTracker:(MobileAppTracker *)tracker didFailWithError:(NSError *)error
{
    NSLog(@"MATPlugin.matDelegate.failure: %@", error);
}

@end