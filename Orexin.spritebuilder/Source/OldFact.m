//
//  OldFact.m
//  Orexin
//
//  Created by Watt Iamsuri on 11/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "OldFact.h"
#import "LayerForOldFact.h"

@implementation OldFact{
    CCScrollView * _scrollView;
    LayerForOldFact * _layer;
    
}

- (void) didLoadFromCCB{
    _layer = (LayerForOldFact*) _scrollView.contentNode;
    _scrollView.delegate = self;
}

@end
