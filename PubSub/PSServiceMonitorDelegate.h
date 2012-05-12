//
//  PSServiceMonitorDelegate.h
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PSPusherServiceProvider;
@class PSChannel;

@protocol PSServiceMonitorDelegate <NSObject>

- (void) didConnectProvider: (PSPusherServiceProvider *) provider;
- (void) didDisconnectProvider: (PSPusherServiceProvider *) provider;

- (void) didSubscribeChannel: (PSChannel *) channel withProvider:(PSPusherServiceProvider *) provider;
- (void) didUnSubscribeChannel: (PSChannel *) channel withProvider:(PSPusherServiceProvider *) provider;

- (void) didFailSubscribeChannel:(PSChannel *) channel withError:(NSError *) error;

@end
