//
//  PSPusherServiceProvider.h
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSServiceProvider.h"
#import "PTPusherDelegate.h"

@protocol PSServiceMonitorDelegate;

@class PTPusher;
@class PTPusherConnection;

@interface PSPusherServiceProvider : NSObject <PSServiceProvider, PTPusherDelegate> {
    @private
    PTPusher *_pusher;
    PTPusherConnection *_connection;
    NSMutableDictionary *_channelMap;
}

@property (nonatomic,assign) id <PSServiceMonitorDelegate> delegate;

@end
