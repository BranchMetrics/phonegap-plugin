//
//  SWNotification.h
//  SmartWhere
//
//  Copyright (c) 2014-2016 smartwhere llc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWAction.h"
#import "SWTrigger.h"

NS_ASSUME_NONNULL_BEGIN
@interface SWNotification : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * message;
@property (nonatomic) SWAction * action;
@property (nonatomic) NSDictionary* proximityObjectProperties;
@property (nonatomic) NSDictionary* eventProperties;
@property (nonatomic) SWTriggerType triggerType;

@end
NS_ASSUME_NONNULL_END
