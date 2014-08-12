//
//  ScrollViewLayer.m
//  GreenApple
//
//  Created by Watt Iamsuri on 8/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ScrollViewLayer.h"

@implementation ScrollViewLayer{
    CCLabelTTF *_labelPage1;
    CCLabelTTF *_labelPage2;
    CCLabelTTF *_labelPage3;
    CCLabelTTF *_labelPage4;
    CCLabelTTF *_labelPage5;
    NSDictionary *dict;
}

- (void) didLoadFromCCB{
    // Path to the plist (in the application bundle)
    NSString *path = [[NSBundle mainBundle] pathForResource:@"item1" ofType:@"plist"];
    dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    _labelPage1.string = [dict objectForKey:@"page1"];
    _labelPage2.string = [dict objectForKey:@"page2"];
    _labelPage3.string = [dict objectForKey:@"page3"];
    _labelPage4.string = [dict objectForKey:@"page4"];
    _labelPage5.string = [dict objectForKey:@"page5"];
}

#pragma mark Facebook

- (void) facebookButton{
    NSLog(@"facebook");
    if([PFUser currentUser] == nil){
        NSLog(@"no username");
        NSArray *permissions = @[@"publish_actions"];
        [PFFacebookUtils logInWithPermissions:permissions block:^(PFUser *user, NSError *error) {
            if (!user) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else if (user.isNew) {
                NSLog(@"User signed up and logged in through Facebook!");
                [self postAShareFacebook];
            } else {
                NSLog(@"User logged in through Facebook!");
                [self postAShareFacebook];
            }
        }];
    }
    else{
        NSLog(@"yes username");
        if([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]){
            NSLog(@"Linked");
            [self postAShareFacebook];
        }
        else{
            NSLog(@"Not Linked");
            //not link is impossible but its here anw incase
            NSArray *permissions = @[@"publish_actions"];
            [PFFacebookUtils linkUser:[PFUser currentUser] permissions:permissions block:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    
                }
            }];
        }
    }
}

// A function for parsing URL parameters returned by the Feed Dialog.
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

- (void) postAShareFacebook{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Sharing Title", @"name",
                                   @"Caption", @"caption",
                                   @"Description", @"description",
                                   @"https://www.google.com", @"link",
                                   @"", @"picture",
                                   nil];
    
    // Show the feed dialog
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                  if (error) {
                                                      // An error occurred, we need to handle the error
                                                      // See: https://developers.facebook.com/docs/ios/errors
                                                      NSLog(@"Error publishing story: %@", error.description);
                                                  } else {
                                                      if (result == FBWebDialogResultDialogNotCompleted) {
                                                          // User cancelled.
                                                          NSLog(@"User cancelled.");
                                                      } else {
                                                          // Handle the publish feed callback
                                                          NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                          
                                                          if (![urlParams valueForKey:@"post_id"]) {
                                                              // User cancelled.
                                                              NSLog(@"User cancelled.");
                                                              
                                                          } else {
                                                              // User clicked the Share button
                                                              NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                              NSLog(@"result %@", result);
                                                          }
                                                      }
                                                  }
                                              }];
}

#pragma mark Twitter

- (void) twitterButton{
    NSLog(@"twitter");
}

#pragma mark reading button

- (void) forMoreReading{
    NSLog(@"reading");
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dict objectForKey:@"URLString1"]]];
}

@end
