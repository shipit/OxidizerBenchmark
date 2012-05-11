//
//  PSServiceProvider.h
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PSServiceMonitorDelegate;

@protocol PSServiceProvider <NSObject>

- (void) connect;
- (void) disconnect;

- (void) subscribeToChannel:(NSString *) channelName;
- (void) unsubscribeFromChannel:(NSString *) channelName;

- (void) setServiceMonitorDelegate:(id <PSServiceMonitorDelegate>) delegate;

@end
