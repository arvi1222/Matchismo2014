//
//  CardMatchingGame.m
//  Matchismo2014
//
//  Created by Arvi S Punzalan on 1/7/14.
//  Copyright (c) 2014 Arvi S Punzalan. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong, readwrite) NSArray *matchedCards;
@property (nonatomic, readwrite) NSInteger lastScore;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSArray *)matchedCards
{
    if (!_matchedCards) {
        _matchedCards = [[NSMutableArray alloc] init];
    }
    return _matchedCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i=0;  i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    self.cardsToMatch = 3;
    self.gameInProgress = NO;
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4
#define FLIP_PENALTY 1

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            //match against other chosen cards
            if (self.cardsToMatch == 2) {
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            otherCard.matched = YES;
                            card.matched = YES;
                            self.matchedCards = @[card, otherCard];
                            self.lastScore = matchScore * MATCH_BONUS;
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                            self.matchedCards = @[card];
                        }
                        break; //can only choose 2 cards for now
                    } else self.matchedCards = @[card];
                }
                self.score -= FLIP_PENALTY;
                card.chosen = YES;
                
            }
            else {
                //match more than 2 cards
                NSMutableArray *chosenCards = [[NSMutableArray alloc]init];
                for (Card *otherCard in self.cards) {
                    //make array of chosencards
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        [chosenCards addObject:otherCard];
                    }
                }
                if ([chosenCards count] == self.cardsToMatch-1) {
                    int matchScore = [card match:chosenCards];
                    if (matchScore) {
                        self.score += matchScore *MATCH_BONUS;
                        for (Card *matchedCard in chosenCards) matchedCard.matched = YES;
                        card.matched = YES;
                        NSMutableArray *temp = [[NSMutableArray alloc] init];
                        [temp addObject:card];
                        for (Card *matchedCard in chosenCards) [temp addObject:matchedCard];
                        self.matchedCards = [temp copy];
                        self.lastScore = matchScore * MATCH_BONUS;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        for (Card *matchedCard in chosenCards) matchedCard.chosen = NO;
                        self.matchedCards = @[card];
                    }
                } else self.matchedCards = @[card];
                self.score -= FLIP_PENALTY;
                card.chosen = YES;
            }
        }
    }
}


@end
