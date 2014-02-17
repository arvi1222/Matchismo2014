//
//  CardMatchingGame.h
//  Matchismo2014
//
//  Created by Arvi S Punzalan on 1/7/14.
//  Copyright (c) 2014 Arvi S Punzalan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer hbjhgjgh 

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger cardsToMatch;
@property (nonatomic, readonly) NSInteger lastScore;
@property (nonatomic) BOOL gameInProgress;
@property (nonatomic, strong, readonly) NSArray *matchedCards; //if count == 1, then no match, content is the flipped card

@end
