//
//  IFAWrapperPlugin.m
//
//  Copyright 2013 HasOffers Inc. All rights reserved.
//

#import "IFAWrapperPlugin.h"
#import <AdSupport/AdSupport.h>

@implementation IFAWrapperPlugin

- (void)getAppleAdvertisingIdentifier:(CDVInvokedUrlCommand*)command
{
    NSLog(@"IFAWrapperPlugin: getAppleAdvertisingIdentifier");
    
    [self.commandDelegate runInBackground:^{
        
        id classASI = NSClassFromString(@"ASIdentifierManager");
        
        CDVPluginResult* pluginResult = nil;
        
        if(classASI)
        {
            NSString *ifa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
            
            NSNumber *trackingEnabled = [NSNumber numberWithBool:[[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]];
            
            NSDictionary *dict = @{@"ifa":ifa, @"trackingEnabled":trackingEnabled};
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
        }
        else
        {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ASIdentifierManager class not found"];
        }
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
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

@end