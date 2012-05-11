//
//  PSClient.m
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PSClient.h"

@implementation PSClient

#pragma mark - Initialization

+ (id) initWithServiceProvider:(id <PSServiceProvider>) provider {
    PSClient *client = [[[PSClient alloc] init] autorelease];
    [client setProvider:provider];
    return client;
}

- (void) setProvider:(id <PSServiceProvider>) provider {
    _serviceProvider = provider;
}

#pragma mark - PubSub client

- (void) connect {

}

- (void) disconnect {
    
}

- (void) subscribeToChannel:(NSString *) channelName 
               successBlock:(void (^) (PSChannel *channel)) success 
               failureBlock:(void (^) (NSString *channelName, NSError *error)) failure {
    
}

- (void) unsubscribeFromChannel:(NSString *) channelName
                   successBlock:(void (^) (NSString *channelName)) success 
                   failureBlock:(void (^) (NSString *channelName, NSError *error)) failure {
    
}

- (void) addConnectionObserver:(id <PSConnectionObserver>) observer {
    
}

#pragma mark - Memory management

- (void) dealloc {
    _serviceProvider = nil;
    [super dealloc];
}

@end
