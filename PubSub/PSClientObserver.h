//
//  PSClientObserver.h
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PSClient;

@protocol PSClientObserver <NSObject>

- (void) didConnectWithClient:(PSClient *) client;
- (void) didDisconnectWithClient:(PSClient *) client;

@end
