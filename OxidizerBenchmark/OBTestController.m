//
//  OBTestController.m
//  OxidizerBenchmark
//
//  Created by Sumeet Parmar on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "OBTestController.h"
#import "Oxidizer.h"
#import "OXChannel.h"

typedef enum {
    kHandshakeButton,
    kConsoleTextView,
    kChannelInputField,
    kChannelSubscribeButton
} OBTag;

@implementation OBTestController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Oxidizer Benchmark";
    self.navigationController.toolbarHidden = NO;
    
    _fpsItem = [[UIBarButtonItem alloc] initWithTitle:@"fps:" style:UIBarButtonItemStylePlain target:nil action:nil];
    _mpsItem = [[UIBarButtonItem alloc] initWithTitle:@"mps:" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.toolbarItems = [NSArray arrayWithObjects:_fpsItem, _mpsItem, nil];

    [self makeHandshakeButton];
    [self makeChannelSubscribeButton];
    [self makeChannelSendButton];
    [self makeChannelInputField];
    [self makeConsoleTextView];
    
    _fpsItem.title = @"fps:0";
    _mpsItem.title = @"mps:0";
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"hh:mm:ss a"];
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(calculateFps:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    [self consoleLog:@"System Ready."];
}

- (void) calculateFps:(CADisplayLink *)sender {
    double fps = ceil(1 / sender.duration);
    _fpsItem.title = [NSString stringWithFormat:@"fps:%.02f", fps];
}

- (void) makeHandshakeButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTag:kHandshakeButton];
    [button setTitle:@"Handshake" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleHandshake:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect frame = self.view.frame;
    button.frame = CGRectMake(10.0f, frame.size.height - 40.0f - 10 - 90.0f, frame.size.width/3 - 2 * 10.0f, 44.0f);
    [self.view addSubview:button]; 
}

- (void) makeChannelSubscribeButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTag:kChannelSubscribeButton];
    [button setTitle:@"Subscribe" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleSubscribe:) forControlEvents:UIControlEventTouchUpInside];    
    
    CGRect frame = self.view.frame;
    button.frame = CGRectMake(frame.size.width/3, frame.size.height - 40.0f - 10 - 90.0f, frame.size.width/3 - 2 * 10.0f, 44.0f);
    [self.view addSubview:button]; 
}

- (void) makeChannelSendButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Send" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleSend:) forControlEvents:UIControlEventTouchUpInside];    
    
    CGRect frame = self.view.frame;
    button.frame = CGRectMake(frame.size.width * 2/3, frame.size.height - 40.0f - 10 - 90.0f, frame.size.width/3 - 2 * 10.0f, 44.0f);
    [self.view addSubview:button]; 
}

- (void) makeChannelInputField {
    CGRect frame = self.view.frame;
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 10.0f, frame.size.width - 2 * 10.0f, 40)];
    field.delegate = self;
    [field setTag:kChannelInputField];
    
    field.borderStyle = UITextBorderStyleRoundedRect;
    field.font = [UIFont systemFontOfSize:15];
    field.placeholder = @"Enter Channel Name";
    field.autocorrectionType = UITextAutocorrectionTypeNo;
    field.returnKeyType = UIReturnKeyDone;
    field.enablesReturnKeyAutomatically = YES;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [self.view addSubview:field];
}

- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    [sender resignFirstResponder];
    return YES;
}

- (void) makeConsoleTextView {
    CGRect frame = self.view.frame;
    
    _consoleTextView = [[UITextView alloc] init];
    [_consoleTextView setTag:kConsoleTextView];
    _consoleTextView.editable = NO;
    _consoleTextView.frame = CGRectMake(5.0f, 50.0f, frame.size.width, frame.size.height - 240.0f);
    _consoleTextView.font = [UIFont fontWithName:@"Courier" size:12.0f];
    
    [self.view addSubview:_consoleTextView];
}

- (void) consoleLog:(NSString *) message {
    _consoleTextView.text = [NSString stringWithFormat:@"%@%@| %@\n", _consoleTextView.text, [_formatter stringFromDate:[NSDate date]], message];
    [_consoleTextView scrollRangeToVisible:NSMakeRange([_consoleTextView.text length], 0)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Oxidizer delegate

- (IBAction)handleHandshake:(id)sender {
    [self consoleLog:@"Handshake requested"];
    Oxidizer *ox = [Oxidizer connector];
    ox.delegate = self;
    [ox handshakeWithUrl:@"http://lvho.st:8080/tophatter/cometd"];
}

- (void) didHandshakeForConnector:(Oxidizer *)connector withResult:(BOOL)result withParams:(NSDictionary *)params {
    dispatch_async(dispatch_get_main_queue(), ^ {
        [self consoleLog:[NSString stringWithFormat:@"handshake result = %d, params = %@", result, params]];
    });
}

- (void) didConnectForConnector:(Oxidizer *)connector withResult:(BOOL)result {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self consoleLog:[NSString stringWithFormat:@"connect result = %d", result]];
    });
}

- (IBAction)handleSubscribe:(id)sender {
    UITextField *field = (UITextField *) [self.view viewWithTag:kChannelInputField];
    NSString *channelName = field.text;
    [self consoleLog:[NSString stringWithFormat:@"subscribe request = %@", channelName]];
    [[Oxidizer connector] subscribeToChannel:channelName 
                                     success:^(OXChannel *channel) {
                                         _channel = channel;
                                         _channel.delegate = self;
                                         [self consoleLog:[NSString stringWithFormat:@"subscribed to %@", channel.subscription]];
                                     }
                                     failure:nil];
}

- (IBAction)handleSend:(id)sender {
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"hello world" forKey:@"message"];
    
    UITextField *field = (UITextField *) [self.view viewWithTag:kChannelInputField];
    NSString *channelName = field.text;
    
    [[Oxidizer connector] publishMessageToChannel:channelName withData:dict];
}

#pragma mark - OXChannel delegate 

- (void) didReceiveMessage:(id)JSON fromChannel:(OXChannel *)channel {
    NSLog(@"channel = %@, says = %@", channel.subscription, JSON);
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        [self consoleLog:[NSString stringWithFormat:@"%@", JSON]];
    });
}

@end
