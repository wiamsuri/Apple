//
//  Page.m
//  Orexin
//
//  Created by Watt Iamsuri on 11/26/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Page.h"

@implementation Page{
    CCLabelTTF * _lableInPage;
}

- (void) setlable:(NSString*) input{
    _lableInPage.string = input;
}

@end
