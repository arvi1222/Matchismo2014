//
//  PlayingCardGameViewController.m
//  Matchismo2014
//
//  Created by Arvi S Punzalan on 1/26/14.
//  Copyright (c) 2014 Arvi S Punzalan. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (NSMutableAttributedString *)cardAttributedContents:(Card *)card
{
    return [[NSMutableAttributedString alloc] initWithString: card.contents];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    NSString *title = card.isChosen ? card.contents : @"";
    return [[NSAttributedString alloc]initWithString:title];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    //make backgroundImage the same for setCards
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}



@end
