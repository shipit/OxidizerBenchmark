//
//  PSClient.m
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PSClient.h"

@implementation PSClient

- (void) connectToUrl:(NSString *) url {
    
}

- (void) disconnectFromUrl:(NSString *) url {
    
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

@end