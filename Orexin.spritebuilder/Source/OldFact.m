//
//  OldFact.m
//  Orexin
//
//  Created by Watt Iamsuri on 11/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "OldFact.h"
#import "Item.h"
#import "LayerForOldFact.h"

@implementation OldFact{
    CCScrollView * _scrollView;
    LayerForOldFact * _layer;
    
}

- (void) didLoadFromCCB{
    _layer = (LayerForOldFact*) _scrollView.contentNode;
    _scrollView.delegate = self;
}

- (void) backbutton{
    CCScene * newscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:newscene];
}

- (void) tonext{
    Item * temp = [[Item alloc] init];
    [temp changeToNextItem];
}

@end
