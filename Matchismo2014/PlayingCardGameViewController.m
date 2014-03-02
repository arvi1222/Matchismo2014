//
//  PlayingCardGameViewController.m
//  Matchismo2014
//
//  Created by Arvi S Punzalan on 1/26/14.
//  Copyright (c) 2014 Arvi S Punzalan. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "HistoryViewController.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show History"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            //Put history info here
            HistoryViewController *hvc = (HistoryViewController *)segue.destinationViewController;
            hvc.historyArray = self.resultHistory;
            NSLog(@"Playing prepare for segue happened");
        }
    }
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
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}



@end
