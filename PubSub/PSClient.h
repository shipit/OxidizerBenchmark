//
//  PSClient.h
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSServiceMonitorDelegate.h"
#import "PSClientObserver.h"

@class PSChannel;
@protocol PSServiceProvider;

typedef void (^PSChannelSuccessBlock) (PSChannel *channel);
typedef void (^PSChannelFailureBlock) (NSString *channelName, NSError *error);

@interface PSClient : NSObject <PSServiceMonitorDelegate> {
    @private
    id <PSServiceProvider> _serviceProvider;
    NSMutableDictionary *_subscriberMap;
    NSMutableArray *_connectionObservers;
}

+ (id) initWithServiceProvider:(id <PSServiceProvider>) provider;

- (void) connect;
- (void) disconnect;

- (void) subscribeToChannel:(NSString *) channelName 
                    success:(PSChannelSuccessBlock) successBlock 
                    failure:(PSChannelFailureBlock) failureBlock;

- (void) unsubscribeFromChannel:(NSString *) channelName
                        success:(PSChannelSuccessBlock) successBlock
                        failure:(PSChannelFailureBlock) failureBlock;

- (void) addConnectionObserver:(id <PSClientObserver>) observer;

@end

typedef enum {
    kChannelStatePending,
    kChannelStateSubscribed,
    kChannelStateInvalid
} PSChannelState;

@interface PSChannelEntry : NSObject {
    @private
    NSString *_channelName;
    PSChannelSuccessBlock _successBlock;
    PSChannelFailureBlock _failureBlock;
}

@property (retain,readonly,nonatomic) NSString *channelName;
@property (retain,readonly,nonatomic) PSChannelSuccessBlock successBlock;
@property (retain,readonly,nonatomic) PSChannelFailureBlock failureBlock;
@property (readwrite,atomic) PSChannelState state;

+ (id) initWithChannelName:(NSString *) channelName 
                   success:(PSChannelSuccessBlock) successBlock
                   failure:(PSChannelFailureBlock) failureBlock;
@end