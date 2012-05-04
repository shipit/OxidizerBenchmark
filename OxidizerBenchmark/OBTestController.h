//
//  OBTestController.h
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OxidizerDelegate;

@interface OBTestController : UIViewController <OxidizerDelegate,UITextFieldDelegate> {
    
    @private
    UIBarButtonItem *_fpsItem;
    UIBarButtonItem *_mpsItem;
    UITextView *_consoleTextView;
    NSDateFormatter *_formatter;
}

@end
