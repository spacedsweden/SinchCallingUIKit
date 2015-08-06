//
//  ClientDelegate.m
//  SinchCallingUIKit
//
//  Created by christian jensen on 2/25/15.
//  Copyright (c) 2015 christian jensen. All rights reserved.
//

#import "ClientDelegate.h"

@implementation ClientDelegate
{
    id<SINAudioController> audioController;
}



-(void)client:(id<SINCallClient>)client didReceiveIncomingCall:(id<SINCall>)call
{
   
    
//    if ([UIApplication sharedApplication].applicationState != UIApplicationStateBackground)
//    {
        NSBundle* bundle = [NSBundle bundleWithIdentifier:@"com.sinch.SinchCallingUIKit"];
        CallScreenViewController *vc = [[CallScreenViewController alloc] initWithNibName:@"CallScreenViewController" bundle:bundle];
        vc.currentCall = call;
        call.delegate = vc;

        vc.audioController = audioController;
        UIWindow* window  = [[[UIApplication sharedApplication] delegate] window];
        [[window rootViewController] presentViewController:vc animated:true completion:^{
            NSLog(@"presented");
        }];
//    }
  
    
}

-(SINLocalNotification *)client:(id<SINCallClient>)client localNotificationForIncomingCall:(id<SINCall>)call
{
          SINLocalNotification *notification = [[SINLocalNotification alloc] init];
        notification.alertAction = @"Answer";
        notification.alertBody = [NSString stringWithFormat:@"Incoming call from %@", [call remoteUserId]];
    notification.soundName = @"incoming.wav";
        return notification;
}
@end
