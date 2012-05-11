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

@class PTPusher;

@interface PSPusherServiceProvider : NSObject <PSServiceProvider, PTPusherDelegate> {
    @private
    PTPusher *_pusher;
}

@end
