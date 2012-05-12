//
//  PSPTPusherChannelWrapper.h
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PSChannel.h"

@class PTPusherChannel;

@interface PSPTPusherChannelWrapper : PSChannel {
    @private
    PTPusherChannel *_channel;
}

@property (retain,readonly) PTPusherChannel *channel;

+ (id) initWithPTPusherChannel: (PTPusherChannel *) channel;

@end
