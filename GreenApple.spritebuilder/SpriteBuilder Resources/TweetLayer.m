//
//  TweetLayer.m
//  GreenApple
//
//  Created by Watt Iamsuri on 8/12/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "TweetLayer.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@implementation TweetLayer{
    CCTextField *_textField;
    CCLabelTTF *_warningText;
}

-(void)onEnter{
    [super onEnter];
    _textField.string = [NSString stringWithFormat:@"Did you know that...?"];
}

- (void) tweetThis{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"item3" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSString *bodyString = @"status=";
    NSString *url = @" ";
    url = [url stringByAppendingString:[dict objectForKey:@"URLString1"]];
    
    int urlLength = (int)[url length];
    NSString *fromTextField = [_textField string];
    int textLength = (int)[fromTextField length];
    
    if(urlLength + textLength > 100){//urlLength + textLength > 100
        NSLog(@"toolong %i" , (urlLength + textLength));
        [_warningText runAction:[CCActionJumpBy actionWithDuration:0.8 position:ccp(0,0) height:10 jumps:2]];
    }
    else{
        
        //not too long
        bodyString = [bodyString stringByAppendingString:fromTextField];
        bodyString = [bodyString stringByAppendingString:url];
        bodyString = [bodyString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        NSURL *tweetTweet = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/update.json"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:tweetTweet];
        
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
        [[PFTwitterUtils twitter] signRequest:request];
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];
        if (!error) {
            NSLog(@"Response: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        } else {
            NSLog(@"Error: %@", error);
        }
        [self removeFromParent];
    }
}

- (void) close{
    [self removeFromParent];
}

@end
