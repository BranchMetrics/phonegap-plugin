//
//  SWAction.h
//  SmartWhere
//
//  Copyright (c) 2014-2016 smartwhere llc. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef EventActionType_Defined
#define EventActionType_Defined

NS_ASSUME_NONNULL_BEGIN

typedef enum EventActionType : NSInteger {
    EventActionTypeUnknown = -1,
    EventActionTypeUrl = 0,
    EventActionTypeUri = 1,
    EventActionTypeCall = 2,
    EventActionTypeSMS = 3,
    EventActionTypePlainText = 4,
    EventActionTypeEmail = 5,
    EventActionTypeContact = 6,
    EventActionTypeBluetooth = 7,
    EventActionTypeWifi = 8,
    EventActionTypeMarket = 9,
    EventActionTypeFacebook = 10,
    EventActionTypeFoursquare = 11,
    EventActionTypeCoupon = 12,
    EventActionTypeTwitter = 13,
    EventActionTypeYoutube = 14,
    EventActionTypeHTML = 16,
    EventActionTypeNewAction = 126,
    EventActionTypeCustom = 127
} EventActionType;

#endif

@interface SWAction : NSObject<NSCoding>

@property (nonatomic) EventActionType actionType;
@property (nonatomic) NSDictionary * values;

@end
NS_ASSUME_NONNULL_END
