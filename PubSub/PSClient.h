//
//  PSClient.h
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSChannel;

@protocol PSConnectionObserver;
@protocol PSServiceProvider;

@interface PSClient : NSObject {
    @private
    id <PSServiceProvider> _serviceProvider;
}

+ (id) initWithServiceProvider:(id <PSServiceProvider>) provider;

- (void) connect;
- (void) disconnect;

- (void) subscribeToChannel:(NSString *) channelName 
               successBlock:(void (^) (PSChannel *channel)) success 
               failureBlock:(void (^) (NSString *channelName, NSError *error)) failure;

- (void) unsubscribeFromChannel:(NSString *) channelName
                   successBlock:(void (^) (NSString *channelName)) success 
                   failureBlock:(void (^) (NSString *channelName, NSError *error)) failure;

- (void) addConnectionObserver:(id <PSConnectionObserver>) observer;

@end