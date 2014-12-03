//
//  ToOldFactButton.m
//  Orexin
//
//  Created by Watt Iamsuri on 11/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ToOldFactButton.h"
#import "Item.h"

@implementation ToOldFactButton{
    CCLabelTTF * _lableForButton;
    int i;
    int j;
}

- (void) didLoadFromCCB{
    i = 0;
    j = 0;
}

- (void) setLable:(NSString*) str{
    _lableForButton.string = str;
}

- (void) setIJ:(int) ii and:(int) jj{
    i = ii;
    j = jj;
}

- (void) pushed{
    Item * it = [[Item alloc] init];
    [it setCurrentItem:i andNumber:j];
    CCScene * newscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:newscene];
}

@end
