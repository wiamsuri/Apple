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
}

- (void) didLoadFromCCB{
    // Path to the plist (in the application bundle)
    NSString *path = [[NSBundle mainBundle] pathForResource:@"item2" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    _labelPage1.string = [dict objectForKey:@"page1"];
    _labelPage2.string = [dict objectForKey:@"page2"];
    _labelPage3.string = [dict objectForKey:@"page3"];
    _labelPage4.string = [dict objectForKey:@"page4"];
    _labelPage5.string = [dict objectForKey:@"page5"];
}

@end
