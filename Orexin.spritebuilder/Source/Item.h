//
//  item.h
//  Orexin
//
//  Created by Watt Iamsuri on 11/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

//- (instancetype) initWithName:(NSString*) name1 andCallUpName:(NSString*) name2;


- (void) setName:(NSString*) st;
- (void) setcallupname:(NSString*) st;
- (void) setBookmarked:(bool) toSet;
- (void) setSeen:(bool) toSet;
- (NSString*) getName;
- (NSString*) getCallUpName;
- (bool) getSeen;
- (bool) getBookmarked;

@end
