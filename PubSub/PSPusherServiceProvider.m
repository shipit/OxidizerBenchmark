//
//  PSPusherServiceProvider.m
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PSPusherServiceProvider.h"
#import "PTPusher.h"
#import "PTPusherDelegate.h"

#define kPusherAppId @"19971"
#define kPusherKey @"b544840b710d36ac22a8"
#define kPusherSecret @"1aecd3d53bade6c66777"

@implementation PSPusherServiceProvider

#pragma mark - PSServiceProvider

- (void) connect {
    _pusher = [PTPusher pusherWithKey:kPusherKey connectAutomatically:NO encrypted:NO];
    _pusher.delegate = self;
    [_pusher connect];
}

- (void) disconnect {
    
}

- (void) subscribeToChannel:(NSString *) channelName {
    
}

- (void) unsubscribeFromChannel:(NSString *) channelName {
    
}

- (void) setServiceMonitorDelegate:(id <PSServiceMonitorDelegate>) delegate {
    
}

#pragma mark - PTPusherDelegate

- (void)pusher:(PTPusher *)pusher connectionDidConnect:(PTPusherConnection *)connection {
    
}

- (void)pusher:(PTPusher *)pusher connection:(PTPusherConnection *)connection didDisconnectWithError:(NSError *)error {
    
}

- (void)pusher:(PTPusher *)pusher connection:(PTPusherConnection *)connection failedWithError:(NSError *)error {
    
}

- (void)pusher:(PTPusher *)pusher connectionWillReconnect:(PTPusherConnection *)connection afterDelay:(NSTimeInterval)delay {
    
}

- (void)pusher:(PTPusher *)pusher willAuthorizeChannelWithRequest:(NSMutableURLRequest *)request {
    
}

- (void)pusher:(PTPusher *)pusher didSubscribeToChannel:(PTPusherChannel *)channel {
    
}

- (void)pusher:(PTPusher *)pusher didUnsubscribeFromChannel:(PTPusherChannel *)channel {
    
}

- (void)pusher:(PTPusher *)pusher didFailToSubscribeToChannel:(PTPusherChannel *)channel withError:(NSError *)error {
    
}

- (void)pusher:(PTPusher *)pusher didReceiveErrorEvent:(PTPusherErrorEvent *)errorEvent {
    
}

@end
