//
//  IFAWrapperPlugin.h
//
//  Copyright 2013 HasOffers Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface IFAWrapperPlugin : CDVPlugin
{
    // empty
}

- (void)getAppleAdvertisingIdentifier:(CDVInvokedUrlCommand*)command;

@end