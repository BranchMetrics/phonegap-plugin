//  SWTrigger.h
//  SmartWhere
//
//  Copyright (c) 2014-2016 smartWhere llc. All rights reserved.
//


typedef enum SWTriggerType : NSInteger {
    swNfcTap = 0,
    swQRScan = 1,
    swBleEnter = 10,
    swBleHover = 11,
    swBleDwell = 12,
    swBleExit = 13,
    swGeoFenceEnter = 20,
    swGeoFenceDwell = 21,
    swGeoFenceExit = 22,
    swWifiEnter = 30,
    swWifiDwell = 31,
    swWifiExit = 32,
    swWifiConnect = 33,
    swWifiDisconnect = 34,
} SWTriggerType;
