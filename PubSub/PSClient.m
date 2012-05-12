//
//  PSClient.m
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PSClient.h"
#import "PSServiceProvider.h"
#import "PSChannel.h"

@implementation PSClient

#pragma mark - Initialization

+ (id) initWithServiceProvider:(id <PSServiceProvider>) provider {
    PSClient *client = [[[PSClient alloc] init] autorelease];
    [client setProvider:provider];
    return client;
}

- (id) init {
    self = [super init];
    _subscriberMap = [[NSMutableDictionary alloc] init];
    return self;
}

- (void) setProvider:(id <PSServiceProvider>) provider {
    _serviceProvider = provider;
}

#pragma mark - PubSub client

- (void) connect {
    [_serviceProvider connect];
}

- (void) disconnect {
    [_serviceProvider disconnect];
}

- (void) subscribeToChannel:(NSString *) channelName 
                    success:(PSChannelSuccessBlock) successBlock 
                    failure:(PSChannelFailureBlock) failureBlock {
    //TODO: optimization -- check if already subscribed then return immediately
    PSChannelEntry *entry = [PSChannelEntry initWithChannelName:channelName success:successBlock failure:failureBlock];
    entry.state = kChannelStatePending;
    
    [self addToPendingSubcriberList:entry];
    [_serviceProvider subscribeToChannel:channelName];
}

- (void) unsubscribeFromChannel:(NSString *) channelName
                        success:(PSChannelSuccessBlock) successBlock 
                        failure:(PSChannelFailureBlock) failureBlock {
    [_serviceProvider unsubscribeFromChannel:channelName];
}

- (void) addConnectionObserver:(id <PSConnectionObserver>) observer {
    
}

- (void) addToPendingSubcriberList:(PSChannelEntry *) entry {
    NSMutableArray *list = [_subscriberMap objectForKey:entry.channelName];
    
    if (!list) {
        list = [[NSMutableArray alloc] init];
        [_subscriberMap setObject:list forKey:entry.channelName];
    }
    
    [list addObject:entry];
}

#pragma mark - PSServiceMonitorDelegate

- (void) didConnectProvider: (PSPusherServiceProvider *) provider {
    
}

- (void) didDisconnectProvider: (PSPusherServiceProvider *) provider {
    
}

- (void) didSubscribeChannel: (PSChannel *) channel withProvider:(PSPusherServiceProvider *) provider {
    NSMutableArray *list = [_subscriberMap objectForKey:channel.channelName];
    
    if (list) {
        for (int i = 0; i < [list count]; i++) {
            PSChannelEntry *entry = [list objectAtIndex:i];
            
            if (entry.state == kChannelStatePending) {
                entry.state = kChannelStateSubscribed;
                entry.successBlock(channel);
            }
        }
    }
    
    //TODO: optimization - remove empty list
}

- (void) didUnSubscribeChannel: (PSChannel *) channel withProvider:(PSPusherServiceProvider *) provider {
    
}

- (void) didFailSubscribeChannel:(PSChannel *) channel withError:(NSError *) error {
    NSMutableArray *list = [_subscriberMap objectForKey:channel.channelName];
    
    if (list) {
        for (int i = 0; i < [list count]; i++) {
            PSChannelEntry *entry = [[list objectAtIndex:i] retain];
            entry.state = kChannelStateInvalid;
            entry.failureBlock(channel.channelName, error);
        }
    }
    
    //TODO: optimization - remove channel entry
}

#pragma mark - Memory management

- (void) dealloc {
    _serviceProvider = nil;
    [super dealloc];
}

@end

@implementation PSChannelEntry

@synthesize channelName = _channelName;
@synthesize successBlock = _successBlock;
@synthesize failureBlock = _failureBlock;
@synthesize state;

+ (id) initWithChannelName:(NSString *) channelName 
                   success:(PSChannelSuccessBlock) successBlock
                   failure:(PSChannelFailureBlock) failureBlock {
    PSChannelEntry *entry = [[PSChannelEntry alloc] init];
    entry->_channelName = channelName;
    entry->_successBlock = successBlock;
    entry->_failureBlock = failureBlock;
    
    return entry;
}

@end