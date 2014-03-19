//
//  GAIDWrapperPlugin.h
//
//  Copyright 2013 HasOffers Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface GAIDWrapperPlugin : CDVPlugin
{
    // empty
}

- (void)getGAID:(CDVInvokedUrlCommand*)command;

@end