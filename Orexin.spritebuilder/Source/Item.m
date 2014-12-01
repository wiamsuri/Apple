//
//  item.m
//  Orexin
//
//  Created by Watt Iamsuri on 11/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Item.h"

@implementation Item{
    
}

- (NSString*) getCurrentItemName{
    NSInteger i = [[NSUserDefaults standardUserDefaults] integerForKey:@"ITEM INT I"];
    NSInteger j = [[NSUserDefaults standardUserDefaults] integerForKey:@"ITEM INT J"];
    NSInteger jnow = j % [self numItemInSec:(int)i];
    
    NSString * temp = [NSString stringWithFormat:@"item%li-%li", i,jnow];
    NSLog(temp);
    return temp;
}

- (void) setCurrentItem:(int) i andNumber:(int) j{
    //[[NSUserDefaults standardUserDefaults] setValue:set forKey:@"CurrentItem"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) changeToNextItem{
    //NSString * temp = [[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentItem"];
    NSInteger i = [[NSUserDefaults standardUserDefaults] integerForKey:@"ITEM INT I"];
    NSInteger j = [[NSUserDefaults standardUserDefaults] integerForKey:@"ITEM INT J"];
    
    //if([self numItemInSec:(int)i] >= j){
    //while loop to get to next selected in option
    bool check = true;
    while(check){
        i++;
        if(i>=6){
            i = 0;
            j++;
            //j = j % [self numItemInSec:<#(int)#>];
        }
        NSString * temp = [NSString stringWithFormat:@"topic%li", i];
        //NSLog(temp);
        if([[NSUserDefaults standardUserDefaults] boolForKey:temp]){
            check = false;
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:i forKey:@"ITEM INT I"];
    [[NSUserDefaults standardUserDefaults] setInteger:j forKey:@"ITEM INT J"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //}
    //else{
    //    j++;
    //}
}

- (int) numItemInSec:(int) x{
    switch (x) {
        case 0:
            return 2;
            break;
            
        case 1:
            return 2;
            break;
            
        case 2:
            return 2;
            break;
            
        case 3:
            return 2;
            break;
            
        case 4:
            return 2;
            break;
            
        case 5:
            return 2;
            break;
            
        default:
            return 0;
            break;
    }
    return 0;
}

@end
