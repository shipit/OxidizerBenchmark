//
//  PSConnectionObserver.h
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PSClient;

@protocol PSConnectionObserver <NSObject>

- (void) didConnectWithClient:(PSClient *);
- (void) didDisconnectWithClient:(PSClient *);

@end
