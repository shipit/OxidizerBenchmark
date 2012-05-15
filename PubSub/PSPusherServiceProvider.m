//
//  PSPusherServiceProvider.m
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PSPusherServiceProvider.h"
#import "PTPusherChannel.h"
#import "PTPusherDelegate.h"
#import "PSServiceMonitorDelegate.h"
#import "PSPTPusherChannelWrapper.h"

#define kPusherAppId @"19971"
#define kPusherKey @"b544840b710d36ac22a8"
#define kPusherSecret @"1aecd3d53bade6c66777"

@implementation PSPusherServiceProvider

@synthesize delegate;

#pragma mark - Initialization

- (id) init {
    self = [super init];
    _channelMap = [[[NSMutableDictionary alloc] init] autorelease];
    return self;
}

#pragma mark - PSServiceProvider

- (void) connect {
    _pusher = [[PTPusher pusherWithKey:kPusherKey connectAutomatically:NO encrypted:NO] retain];
    _pusher.delegate = self;
    [_pusher connect];
}

- (void) disconnect {
    [_pusher disconnect];
}

- (void) subscribeToChannel:(NSString *) channelName {
    [_pusher subscribeToChannelNamed:channelName];
}

- (void) unsubscribeFromChannel:(NSString *) channelName {
    PSPTPusherChannelWrapper *wrapper = [_channelMap objectForKey:channelName];
    
    if (wrapper) {
        if (wrapper.channel) {
            [wrapper.channel unsubscribe];
        }
    }
}

- (void) setServiceMonitorDelegate:(id <PSServiceMonitorDelegate>) serviceMonitorDelegate {
    self.delegate = serviceMonitorDelegate;
}

#pragma mark - PTPusherDelegate

- (void)pusher:(PTPusher *)pusher connectionDidConnect:(PTPusherConnection *)connection {
    _connection = connection;
    
    if (self.delegate) {
        [self.delegate didConnectProvider:self];
    }
}

- (void)pusher:(PTPusher *)pusher connection:(PTPusherConnection *)connection didDisconnectWithError:(NSError *)error {
    _connection = nil;
    
    if (self.delegate) {
        [self.delegate didDisconnectProvider:self];
    }
}

- (void)pusher:(PTPusher *)pusher connection:(PTPusherConnection *)connection failedWithError:(NSError *)error {
    
}

- (void)pusher:(PTPusher *)pusher connectionWillReconnect:(PTPusherConnection *)connection afterDelay:(NSTimeInterval)delay {
    
}

- (void)pusher:(PTPusher *)pusher willAuthorizeChannelWithRequest:(NSMutableURLRequest *)request {
    
}

- (void)pusher:(PTPusher *)pusher didSubscribeToChannel:(PTPusherChannel *)channel {
    PSPTPusherChannelWrapper *wrapper = [PSPTPusherChannelWrapper initWithPTPusherChannel:channel];
    [_channelMap setObject:wrapper forKey:wrapper.channelName];
    
    if (self.delegate) {
        [self.delegate didSubscribeChannel:wrapper withProvider:self];
    }
}

- (void)pusher:(PTPusher *)pusher didUnsubscribeFromChannel:(PTPusherChannel *)channel {
    PSPTPusherChannelWrapper *wrapper = [_channelMap objectForKey:channel.name];
    
    if (wrapper) {
        if (self.delegate) {
            [self.delegate didUnSubscribeChannel:wrapper withProvider:self];
            [_channelMap removeObjectForKey:channel.name];
        }
    }
}

- (void)pusher:(PTPusher *)pusher didFailToSubscribeToChannel:(PTPusherChannel *)channel withError:(NSError *)error {
    PSPTPusherChannelWrapper *wrapper = [[_channelMap objectForKey:channel.name] retain];
    
    if (wrapper) {
        if (self.delegate) {
            [self.delegate didFailSubscribeChannel:wrapper withError:error];
        }
        
        [_channelMap removeObjectForKey:wrapper];
        [wrapper release];
    }
}

- (void)pusher:(PTPusher *)pusher didReceiveErrorEvent:(PTPusherErrorEvent *)errorEvent {
    
}

@end
