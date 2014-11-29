//
//  item.m
//  Orexin
//
//  Created by Watt Iamsuri on 11/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Item.h"

@implementation Item{
    NSString * name;
    NSString * callUpName;
    bool seen;
    bool bookmarked;
}

/*- (instancetype) initWithName:(NSString*) name1 andCallUpName:(NSString*) name2{
    name = name1;
    callUpName = name2;
    seen = false;
    bookmarked = false;
    return self;
}*/

- (void) setName:(NSString*) st{
    name = st;
}

- (void) setcallupname:(NSString*) st{
    callUpName = st;
}

- (void) setBookmarked:(bool) toSet{
    bookmarked = toSet;
}

- (void) setSeen:(bool) toSet{
    seen = toSet;
}

- (NSString*) getName{
    return name;
}

- (NSString*) getCallUpName{
    return callUpName;
}

- (bool) getSeen{
    return seen;
}

- (bool) getBookmarked{
    return bookmarked;
}

@end
