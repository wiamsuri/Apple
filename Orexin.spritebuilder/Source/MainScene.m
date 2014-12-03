//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "ScrollViewLayer.h"
#import "Item.h"

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
    
    Item * item = [[Item alloc] init];
    
    NSString * name;
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"vergin start"]){
        
        name =[item getCurrentItemName];
    }
    else{
        NSInteger i = [[NSUserDefaults standardUserDefaults] integerForKey:@"verginx"];
        NSInteger j = [[NSUserDefaults standardUserDefaults] integerForKey:@"verginy"];
        NSInteger jnow = j % [item numItemInSec:(int)i];
        
        name = [NSString stringWithFormat:@"item%li-%li", i,jnow];
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    
    //set this item to seen
    NSDictionary * dicttochange = [[NSUserDefaults standardUserDefaults] objectForKey:name];
    NSDictionary * newdict = [[NSDictionary alloc] initWithObjectsAndKeys:[dicttochange objectForKey:@"name"],@"name",[dicttochange objectForKey:@"i-factor"],@"i-factor",[dicttochange objectForKey:@"j-factor"],@"j-factor",[NSNumber numberWithBool:true], @"seen",[dicttochange objectForKey:@"bookmarked"], @"bookmarked",nil];
    [[NSUserDefaults standardUserDefaults] setObject:newdict forKey:name];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSNumber * numbpages = [dict objectForKey:@"numberOfPage"];
    int x = numbpages.intValue+2;
    [self setUpDotsInit:x];
    _currentScrollView = (ScrollViewLayer*)_scrollView.contentNode;
    _scrollView.delegate = self;
    [self setupDots:_scrollView.horizontalPage];
    
    //[UIApplication sharedApplication].scheduledLocalNotifications = nil;
    self.userInteractionEnabled = true;
}

- (void) setUpDotsInit:(int) numDots{
    //CCNodeColor * theDot =  _nodeForDots.children.firstObject;
    //[_nodeForDots removeAllChildren];
    int totalspace = (numDots-1) *16;
    for(int i = 0; i < numDots ; i++){
        //CCNodeColor * temp = [CCNodeColor init];
        //temp.color = theDot.color;
        //temp.contentSize = theDot.contentSize;
        //temp.opacity = theDot.opacity;
        //[temp setPosition:CGPointMake(-20, 0)];
        CCNode * temp = [CCBReader load:@"SmallBox"];
        [temp setPosition:CGPointMake((i*16) - (totalspace /2), 23)];
        [_nodeForDots addChild:temp];
    }
}


- (void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    
}

- (void) touchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    
}

- (void) scrollViewDidEndDecelerating:(CCScrollView *)scrollView{
    int currentPage = scrollView.horizontalPage;
    [self setupDots:currentPage];
}

- (void) scrollViewDidScroll:(CCScrollView *)scrollView{
    CGPoint pos = scrollView.scrollPosition;
    //NSLog(@"%f and %f", pos.x, pos.y);
    float screenSizeW = [[CCDirector sharedDirector] viewSize].width;
    float relative = abs( (int)pos.x % (int)screenSizeW);
    float temp = 1 + ((relative*(relative - screenSizeW))/(screenSizeW*150));
    [_currentScrollView shrinkGradient:temp];
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
