//
//  LayerForOldFact.m
//  Orexin
//
//  Created by Watt Iamsuri on 11/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "LayerForOldFact.h"
#import "ToOldFactButton.h"
#import "Item.h"

@implementation LayerForOldFact

- (void) didLoadFromCCB{
    [self setUpButtons];
}

- (void) setUpButtons{
    int counter = 0;
    for(int i = 0; i < 6; i++){
        Item * hehe = [[Item alloc] init];
        int maxInsection = [hehe numItemInSec:i];
        for(int j = 0; j < maxInsection; j++){
            
            NSString * temp = [NSString stringWithFormat:@"item%i-%i", i,j];
            //NSLog(@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:temp] objectForKey:@"seen"]);
            if([[[[NSUserDefaults standardUserDefaults] objectForKey:temp] objectForKey:@"seen"] boolValue]){
                ToOldFactButton * newbutton = (ToOldFactButton*)[CCBReader load:@"ToOldFactButton"];
                [newbutton setPositionType:CCPositionTypeMake(CCPositionUnitPoints, CCPositionUnitPoints, CCPositionReferenceCornerTopLeft)];
                [newbutton setPosition:CGPointMake(10, 15+ (counter * 35))];
                [newbutton setLable:[[[NSUserDefaults standardUserDefaults] objectForKey:temp] objectForKey:@"name"]];
                [newbutton setIJ:i and:j];
                [self addChild:newbutton];
                counter++;
            }
        }
    }

}

@end
