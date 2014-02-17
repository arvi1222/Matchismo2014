//
//  SetCardDeck.m
//  Matchismo2014
//
//  Created by Arvi S Punzalan on 2/2/14.
//  Copyright (c) 2014 Arvi S Punzalan. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    
    if(self) {
        for (NSString *shape in [SetCard validShape]) {
            for (NSString *color in [SetCard validColor]) {
                for (NSString *shading in [SetCard validShading]) {
                    for (NSUInteger number=1; number<=[SetCard maxNumber]; number++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.shape = shape;
                        card.color = color;
                        card.shading = shading;
                        card.number = number;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}

@end
