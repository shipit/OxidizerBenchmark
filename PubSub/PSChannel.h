//
//  PSChannel.h
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSChannel : NSObject {
    
}

@property (retain,readonly,nonatomic) NSString *channelName;

- (void) sendMessage:(id) message;
- (void) addChannelObserver:(id) observer;

@end