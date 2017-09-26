//
//  SWTag.h
//  SmartWhere
//
//  Copyright (c) 2014-2016 smartWhere llc. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

typedef enum SWScanType : NSInteger {
    SWTagTypeTap = 0,
    SWTagTypeScan = 1
} SWTagType;

@interface SWTag : NSObject

@property NSString* code;
@property SWTagType type;
@property NSDictionary * properties;
@property NSTimeInterval created;

@end

NS_ASSUME_NONNULL_END
