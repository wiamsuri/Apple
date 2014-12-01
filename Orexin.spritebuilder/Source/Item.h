//
//  item.h
//  Orexin
//
//  Created by Watt Iamsuri on 11/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

- (NSString*) getCurrentItemName;

- (void) setCurrentItem:(int) i andNumber:(int) j;

- (void) changeToNextItem;

- (int) numItemInSec:(int) x;

@end
