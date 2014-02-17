//
//  PlayingCard.m
//  Matchismo2014
//
//  Created by Arvi S Punzalan on 12/31/13.
//  Copyright (c) 2013 Arvi S Punzalan. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
    }
    else {
        PlayingCard *otherCard1 = [otherCards firstObject];
        PlayingCard *otherCard2 = [otherCards lastObject];
        if (self.rank == otherCard1.rank && self.rank == otherCard2.rank) {
            score = 10;
            NSLog(@"matched 3 ranks");
        } else if ([self.suit isEqualToString:otherCard1.suit] &&
                          [self.suit isEqualToString:otherCard2.suit]) {
            score = 6;
            NSLog(@"matched 3 suits");
        } else if (self.rank == otherCard1.rank ||
                    self.rank == otherCard2.rank ||
                    otherCard1.rank == otherCard2.rank)  {
            score += 3;
            NSLog(@"matched 2 ranks");
        } else if ([self.suit isEqualToString:otherCard1.suit] ||
                   [self.suit isEqualToString:otherCard2.suit] ||
                   [otherCard1.suit isEqualToString:otherCard2.suit]) {
            score += 2;
            NSLog(@"matched 2 suits");
        }
    }
    
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits {
    return @[@"♣", @"♠", @"♦", @"♥"];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9" ,@"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
