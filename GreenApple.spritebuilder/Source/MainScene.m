//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "ScrollViewLayer.h"

@implementation MainScene{
    CCScrollView *_scrollView;
    ScrollViewLayer *_currentScrollView;
    CCNode *_nodeForSprite;
    CCNode *_nodeForDots;
    
    CCSprite *_sprite1;
    CCSprite *_sprite2;
    CCSprite *_sprite3;
    CCSprite *_sprite4;
}

- (void) didLoadFromCCB{
    _currentScrollView = (ScrollViewLayer*)_scrollView.contentNode;
    _scrollView.delegate = self;
    [self setupDots:_scrollView.horizontalPage];
}

- (void) scrollViewDidEndDecelerating:(CCScrollView *)scrollView{
    int currentPage = scrollView.horizontalPage;
    [self setupDots:currentPage];
}

- (void) onEnter{
    [super onEnter];
    
    [self repeatingBackground];
}

- (void) setupDots:(int) dotnum{
    for(CCNodeColor *dot in _nodeForDots.children){
        dot.scaleX = 1;
        dot.scaleY = 1;
    }
    [[_nodeForDots.children objectAtIndex:dotnum] setScaleX:1.5];
    [[_nodeForDots.children objectAtIndex:dotnum] setScaleY:1.5];
}

- (void) repeatingBackground{
    CCActionFadeIn *fadein = [CCActionFadeIn actionWithDuration:1];
    CCActionFadeOut *fadeout = [CCActionFadeOut actionWithDuration:1];
    [_sprite4 runAction:[CCActionRepeatForever actionWithAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:17],[CCActionMoveBy actionWithDuration:1 position:ccp(-175, 0)],[CCActionSpawn actions:fadein,[CCActionMoveBy actionWithDuration:1 position:ccp(25,0)], nil],[CCActionMoveBy actionWithDuration:5 position:ccp(125,0)],[CCActionSpawn actions:fadeout,[CCActionMoveBy actionWithDuration:1 position:ccp(25,0)], nil], nil]]];
    
    [_sprite3 runAction:[CCActionRepeatForever actionWithAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:12],[CCActionSpawn actions:fadein,[CCActionMoveBy actionWithDuration:1 position:ccp(-25,0)], nil],[CCActionMoveBy actionWithDuration:5 position:ccp(-125,0)],[CCActionSpawn actions:fadeout,[CCActionMoveBy actionWithDuration:1 position:ccp(-25,0)], nil],[CCActionMoveBy actionWithDuration:1 position:ccp(175, 0)],[CCActionDelay actionWithDuration:5], nil]]];
    
    [_sprite2 runAction:[CCActionRepeatForever actionWithAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:6],[CCActionSpawn actions:fadein,[CCActionMoveBy actionWithDuration:1 position:ccp(20,-10)], nil],[CCActionMoveBy actionWithDuration:5 position:ccp(100, -50)],[CCActionSpawn actions:fadeout,[CCActionMoveBy actionWithDuration:1 position:ccp(20,-10)], nil],[CCActionMoveBy actionWithDuration:1 position:ccp(-140, 70)],[CCActionDelay actionWithDuration:11], nil]]];//6+6 12
    
    [_sprite1 runAction:[CCActionRepeatForever actionWithAction:[CCActionSequence actions:[CCActionSpawn actions:fadein,[CCActionMoveBy actionWithDuration:1 position:ccp(-20,-10)], nil],[CCActionMoveBy actionWithDuration:5 position:ccp(-100, -50)],[CCActionSpawn actions:fadeout,[CCActionMoveBy actionWithDuration:1 position:ccp(-20,-10)], nil],[CCActionMoveBy actionWithDuration:1 position:ccp(140, 70)],[CCActionDelay actionWithDuration:17], nil]]];
}

@end
