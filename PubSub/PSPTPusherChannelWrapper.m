//
//  PSPTPusherChannelWrapper.m
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PTPusherChannel.h"
#import "PSPTPusherChannelWrapper.h"

@implementation PSPTPusherChannelWrapper

@synthesize channel = _channel;

+ (id) initWithPTPusherChannel: (PTPusherChannel *) channel {
    PSPTPusherChannelWrapper *wrapper = [[PSPTPusherChannelWrapper alloc] init];
    wrapper->_channel = channel;
    return wrapper;
}

- (NSString *) channelName {
    return _channel ? _channel.name : nil;
}

@end
