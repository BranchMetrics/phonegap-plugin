//
//  GAIDWrapperPlugin.m
//
//  Copyright 2013 HasOffers Inc. All rights reserved.
//

#import "GAIDWrapperPlugin.h"

@implementation GAIDWrapperPlugin

- (void)getGAID:(CDVInvokedUrlCommand*)command
{
    NSLog(@"GAIDWrapperPlugin: getGAID");
    
    [self.commandDelegate runInBackground:^{
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        
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