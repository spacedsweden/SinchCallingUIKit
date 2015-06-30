//
//  CallingManager.m
//  SinchCallingUIKit
//
//  Created by christian jensen on 2/24/15.
//  Copyright (c) 2015 christian jensen. All rights reserved.
//

#import "CallingManager.h"
#import <Sinch/Sinch.h>
#import "ClientDelegate.h"
#import "CallScreenViewController.h"
#import "ResourceLoader.h"

@interface CallingManager() <SINServiceDelegate>
{
    id<SINService> service;
    id<SINCall> currentCall;
    id<SINCallClientDelegate> callClientDelegate;
}

@end

@implementation CallingManager
+ (CallingManager*)sharedManager {
    static CallingManager *sharedManagerInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManagerInstance = [[self alloc] init];
        
        //        sharedManagerInstance.logLevel = SINLogSeverityCritical;
    });
    return sharedManagerInstance;
}

-(void)showCallController
{
    
   
    
//    NSBundle* bundle = [NSBundle bundleWithIdentifier:@"SinchCallingUIKit"];
    
    CallScreenViewController *vc = [[CallScreenViewController alloc] initWithNibName:@"CallScreenViewController" bundle:[ResourceLoader loadBundle]];
    currentCall.delegate = vc;
    vc.currentCall = currentCall;
    vc.audioController = [service audioController];
    UIWindow* window  = [[[UIApplication sharedApplication] delegate] window];
    [[window rootViewController] presentViewController:vc animated:true completion:^{
        NSLog(@"presented");
    }];
    
    
}
-(void)callUser:(NSString*)userName
{
    currentCall = [[service callClient] callUserWithId:userName];
    [self showCallController];
}

-(void)callNumber:(NSString *)phoneNumber
{
//    if (![service isStarted])
//    {
//        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please start the sinch client before making a call" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
//        return;
//    }
    
    currentCall = [[service callClient] callPhoneNumber:phoneNumber];
    [self showCallController];
    
}

- (SINLocalNotification *)client:(id<SINClient>)client localNotificationForIncomingCall:(id<SINCall>)call {
    SINLocalNotification *notification = [[SINLocalNotification alloc] init];
    notification.alertAction = @"Answer";
    notification.alertBody = [NSString stringWithFormat:@"Incoming call from %@", [call remoteUserId]];
    return notification;
}


- (void)service:(id<SINService>)service didFailWithError:(NSError *)error
{
}

- (void)service:(id<SINService>)service
     logMessage:(NSString *)message
           area:(NSString *)area
       severity:(SINLogSeverity)severity
      timestamp:(NSDate *)timestamp;
{
    NSLog(@"%@", message);
}

/// public Methods
-(void)startClientWithKey:(NSString*)appKey secret:(NSString*)secret userName:(NSString*)userName sandbox:(bool)sandbox launchOptions:(NSDictionary*)launchOptions
{
    
    NSString* url = sandbox ? @"sandbox.sinch.com" : @"sandbox.sinch.com";
    id config = [[SinchService configWithApplicationKey:appKey
                                      applicationSecret:secret
                                        environmentHost:url]
                 pushNotificationsWithEnvironment:SINAPSEnvironmentAutomatic];
    service = [SinchService serviceWithConfig:config];
    service.delegate = self;
    callClientDelegate= [[ClientDelegate alloc] init];
    service.callClient.delegate = callClientDelegate;
    [service logInUserWithId:userName];
    [service.push registerUserNotificationSettings];
}

@end