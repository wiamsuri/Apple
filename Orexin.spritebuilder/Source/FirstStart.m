//
//  FirstStart.m
//  Orexin
//
//  Created by Watt Iamsuri on 10/18/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "FirstStart.h"
//#import "Item.h"

@implementation FirstStart{
    CCNodeColor * _nodecolor1;
    CCNodeColor * _nodecolor2;
    CCNodeColor * _nodecolor3;
    CCNodeColor * _nodecolor4;
    CCNodeColor * _nodecolor5;
    CCNodeColor * _nodecolor6;
    CCButton * _bu1;
    CCButton * _bu2;
    CCButton * _bu3;
    CCButton * _bu4;
    CCButton * _bu5;
    CCButton * _bu6;
    CCNodeColor * _layerPleaseSelect;
    CCLabelTTF * _textPlease;
    bool onetime;
}

- (void) didLoadFromCCB{
    self.userInteractionEnabled = true;
    onetime = true;
    [self setupForpush];
    
}

- (void) setupForpush{
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"topic0"];
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"topic1"];
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"topic2"];
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"topic3"];
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"topic4"];
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"topic5"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_bu1 setEnabled:false];
    [_bu2 setEnabled:false];
    [_bu3 setEnabled:false];
    [_bu4 setEnabled:false];
    [_bu5 setEnabled:false];
    [_bu6 setEnabled:false];
    [_bu1 setVisible:false];
    [_bu2 setVisible:false];
    [_bu3 setVisible:false];
    [_bu4 setVisible:false];
    [_bu5 setVisible:false];
    [_bu6 setVisible:false];
}

- (void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    //NSLog(@"lol" );
    if(onetime){
        [_layerPleaseSelect runAction:[CCActionSpawn actions:[CCActionFadeOut actionWithDuration:1],[CCActionMoveBy actionWithDuration:1 position:ccp(0,-500)], nil]];
        [_textPlease runAction:[CCActionSpawn actions:[CCActionFadeOut actionWithDuration:1],[CCActionMoveBy actionWithDuration:1 position:ccp(0,-500)], nil]];
        onetime = false;
        [self enableButtons];
    }
}

- (void) enableButtons{
    [_bu1 setEnabled:true];
    [_bu2 setEnabled:true];
    [_bu3 setEnabled:true];
    [_bu4 setEnabled:true];
    [_bu5 setEnabled:true];
    [_bu6 setEnabled:true];
    [_bu1 setVisible:true];
    [_bu2 setVisible:true];
    [_bu3 setVisible:true];
    [_bu4 setVisible:true];
    [_bu5 setVisible:true];
    [_bu6 setVisible:true];
}

- (void) button1{
    //NSLog(@"button1");
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"topic0"]){
        [_nodecolor1 setOpacity:0.2];
        [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"topic0"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        [_nodecolor1 setOpacity:0.4];// opacity = 0.4;
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"topic0"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void) button2{
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"topic1"]){
        [_nodecolor2 setOpacity:0.2];
        [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"topic1"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        [_nodecolor2 setOpacity:0.4];// opacity = 0.4;
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"topic1"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void) button3{
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"topic2"]){
        [_nodecolor3 setOpacity:0.2];
        [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"topic2"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        [_nodecolor3 setOpacity:0.4];// opacity = 0.4;
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"topic2"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void) button4{
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"topic3"]){
        [_nodecolor4 setOpacity:0.2];
        [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"topic3"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        [_nodecolor4 setOpacity:0.4];// opacity = 0.4;
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"topic3"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void) button5{
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"topic4"]){
        [_nodecolor5 setOpacity:0.2];
        [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"topic4"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        [_nodecolor5 setOpacity:0.4];// opacity = 0.4;
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"topic4"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void) button6{
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"topic5"]){
        [_nodecolor6 setOpacity:0.2];
        [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"topic5"];
        //[[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        [_nodecolor6 setOpacity:0.4];// opacity = 0.4;
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"topic5"];
        //[[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void) startButton{
    //NSLog(@"start");
    
    
    NSInteger i = 0;
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"topic0"]){
        i = 0;
    }else {
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"topic1"]){
            i = 1;
        }
        else{
            if([[NSUserDefaults standardUserDefaults] boolForKey:@"topic2"]){
                i = 2;
            }
            else{
                if([[NSUserDefaults standardUserDefaults] boolForKey:@"topic3"]){
                    i = 3;
                }
                else{
                    if([[NSUserDefaults standardUserDefaults] boolForKey:@"topic4"]){
                        i = 4;
                    }
                    else{
                        if([[NSUserDefaults standardUserDefaults] boolForKey:@"topic5"]){
                            i = 5;
                            
                        }
                        else{
                            //invalid!!
                            //NSLog(@"NOTHING AT ALL");
                            CCScene * newscene = [CCBReader loadAsScene:@"FirstStart"];
                            [[CCDirector sharedDirector] replaceScene:newscene];
                            return;
                        }
                    }
                }
            }
        }
    }
    NSInteger j = 0;
    //NSString * temp = [NSString stringWithFormat:@"item%i-%i", i,j];
    //NSLog(temp);
    //[[NSUserDefaults standardUserDefaults] setValue:temp forKey:@"CurrentItem"];
    //NSInteger int1 = i;

    [[NSUserDefaults standardUserDefaults] setInteger:i forKey:@"ITEM INT I"];
    [[NSUserDefaults standardUserDefaults] setInteger:j forKey:@"ITEM INT J"];
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"FirstStartpaileaw"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    CCScene * newscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:newscene];
}

@end
