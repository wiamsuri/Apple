//
//  ScrollViewLayer.m
//  GreenApple
//
//  Created by Watt Iamsuri on 8/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ScrollViewLayer.h"
#import "TweetLayer.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@implementation ScrollViewLayer{
    CCNode *_page1;
    CCNode *_page2;
    CCNode *_page3;
    CCNode *_page4;
    CCNode *_page5;
    CCNode *_page6;
    CCNode *_ratingNode;
    CCNode *_nodeForStars;
    CCSprite *_star1;
    CCSprite *_star2;
    CCSprite *_star3;
    CCSprite *_star4;
    CCSprite *_star5;
    int stars;

    CCLabelTTF *_labelPage1;
    CCLabelTTF *_labelPage2;
    CCLabelTTF *_labelPage3;
    CCLabelTTF *_labelPage4;
    CCLabelTTF *_labelPage5;
    NSDictionary *dict;
    CCNodeGradient* _gradient1;
}

- (void) didLoadFromCCB{
    // Path to the plist (in the application bundle)
    NSString *path = [[NSBundle mainBundle] pathForResource:@"item003" ofType:@"plist"];
    dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    _labelPage1.string = [dict objectForKey:@"page1"];
    _labelPage2.string = [dict objectForKey:@"page2"];
    _labelPage3.string = [dict objectForKey:@"page3"];
    _labelPage4.string = [dict objectForKey:@"page4"];
    _labelPage5.string = [dict objectForKey:@"page5"];
    self.userInteractionEnabled = true;
    
    stars = 5;
}

- (void) shrinkGradient:(float) scale{
    _page1.scale = scale;
    _page2.scale = scale;
    _page3.scale = scale;
    _page4.scale = scale;
    _page5.scale = scale;
    _page6.scale = scale;
}

- (void) ratingButton{
    NSLog(@"rate %i", stars);
    NSDictionary *dimensions = @{@"item": [NSString stringWithFormat:@"%i",3],@"rating": [NSString stringWithFormat:@"%i",stars]};
    [PFAnalytics trackEvent:@"itemandrating" dimensions:dimensions];
    _ratingNode.visible = false;
}

- (void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint pos = [touch locationInNode:_nodeForStars];
    //NSLog(@"%f",pos.x);
    [self determineStars:pos];
}

- (void) determineStars:(CGPoint) location{
    if(location.x > 0 && location.x < 250){
        if(location.y >0 && location.y < 50){
            stars = (int)(location.x / 50) +1;
            NSLog(@"%i", stars);
            int s = 1;
            for(CCSprite *st in _nodeForStars.children){
                if(s<=stars){
                    [st setColor:[CCColor colorWithRed:1 green:1 blue:1]];
                }
                else{
                    [st setColor:[CCColor colorWithRed:0.5 green:0.5 blue:0.5]];
                }
                s++;
            }
        }
    }
}

#pragma mark Facebook

- (void) facebookButton{
    //facbook button pushed
    if([PFUser currentUser] == nil){
        //no username
        NSArray *permissions = @[@"publish_actions"];
        [PFFacebookUtils logInWithPermissions:permissions block:^(PFUser *user, NSError *error) {
            if (!user) {
                //cancelled login :(
            } else if (user.isNew) {
                //signed up and logged in through Facebook
                [self postAShareFacebook];
            } else {
                //logged in through Facebook
                [self postAShareFacebook];
            }
        }];
    }
    else{
        //username exist
        if([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]){
            //share on fb
            [self postAShareFacebook];
        }
        else{
            //not link is impossible but its here anw incase
            
            //******************************************************************************
            //add getting friend list permission? it cannot suggust friend to tag right now
            //******************************************************************************
            NSArray *permissions = @[@"publish_actions"];
            [PFFacebookUtils linkUser:[PFUser currentUser] permissions:permissions block:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [self postAShareFacebook];
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
    
    NSString *stringforurl = [dict objectForKey:@"URLString1"];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Sharing Title", @"name",
                                   @"Caption", @"caption",
                                   @"Description", @"description",
                                   stringforurl, @"link",
                                   @"", @"picture",
                                   nil];
    
    // Show the feed dialog
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                  if (error) {
                                                      // An error occurred, we need to handle the error
                                                      // See: https://developers.facebook.com/docs/ios/errors
                                                      //NSLog(@"Error publishing story: %@", error.description);
                                                  } else {
                                                      if (result == FBWebDialogResultDialogNotCompleted) {
                                                          // User cancelled.
                                                          //NSLog(@"User cancelled.");
                                                      } else {
                                                          // Handle the publish feed callback
                                                          NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                          
                                                          if (![urlParams valueForKey:@"post_id"]) {
                                                              // User cancelled.
                                                              //NSLog(@"User cancelled.");
                                                              
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
    //twitter
    if([PFUser currentUser] == nil){
        [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
            if (!user) {
                //cancelled the Twitter login
                return;
            } else if (user.isNew) {
                //signed up and logged in
                [self tweetKrub];
            } else {
                //loged in
                [self tweetKrub];
            }     
        }];
    }
    else{
        if([PFTwitterUtils isLinkedWithUser:[PFUser currentUser]]){
            //tweet
            [self tweetKrub];
        }
        else{
            if (![PFTwitterUtils isLinkedWithUser:[PFUser currentUser]]) {
                [PFTwitterUtils linkUser:[PFUser currentUser] block:^(BOOL succeeded, NSError *error) {
                    if ([PFTwitterUtils isLinkedWithUser:[PFUser currentUser]]) {
                        //linked
                        [self tweetKrub];
                    }
                }];
            }
        }
    }
}

- (void) tweetKrub{
    //int xpos = [[CCDirector sharedDirector] viewSize].width * 4;
    TweetLayer *newLayer = (TweetLayer*)[CCBReader load:@"TweetLayer"];
    newLayer.position = ccp(0,0);
    [_page5 addChild:newLayer];
}

#pragma mark reading button

- (void) forMoreReading{
    //For more reading
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dict objectForKey:@"URLString1"]]];
}

@end