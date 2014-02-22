//
//  CardGameViewController.m
//  Matchismo2014
//
//  Created by Arvi S Punzalan on 12/31/13.
//  Copyright (c) 2013 Arvi S Punzalan. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeSegmentControl;

@end

@implementation CardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
    self.resultLabel.adjustsFontSizeToFitWidth = YES;
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck //abstract
{
    return nil;
}

- (NSAttributedString *)createTitle:(NSString *)title //abstract
{
    return nil;
}

- (IBAction)touchNewGameButton:(UIButton *)sender {
    self.game = nil;
    [self updateUI];
    [self.matchModeSegmentControl setEnabled:YES forSegmentAtIndex:0];
    [self.matchModeSegmentControl setEnabled:YES forSegmentAtIndex:1];
    self.resultLabel.text = @"";

    self.matchModeSegmentControl.selectedSegmentIndex = 0;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    self.game.gameInProgress = YES;
    [self updateUI];
}

#define SEGMENT_INDEX_ADJUSTER 2

- (IBAction)touchMatchModeControl:(UISegmentedControl *)sender {
    self.game.cardsToMatch = sender.selectedSegmentIndex + SEGMENT_INDEX_ADJUSTER;
    NSLog(@"Cards to Match is %d", self.game.cardsToMatch);
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

    if (self.game.gameInProgress) {
        [self.matchModeSegmentControl setEnabled:NO forSegmentAtIndex:0];
        [self.matchModeSegmentControl setEnabled:NO forSegmentAtIndex:1];
    }
    
    if ([self.game.matchedCards count] == 1) {
        NSMutableAttributedString *resultMessage = [[NSMutableAttributedString alloc] initWithString:@"You flipped the "];
        [resultMessage appendAttributedString: [self cardAttributedContents:((Card *)self.game.matchedCards[0])]];
        self.resultLabel.attributedText = resultMessage;
    } else {
        NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
        for (Card *matchedCard in self.game.matchedCards) {
            [result appendAttributedString:[self cardAttributedContents:matchedCard]];
        }
        NSMutableAttributedString *resultMessage = [[NSMutableAttributedString alloc] initWithString:@"You matched: "];
        [resultMessage appendAttributedString:result];
        self.resultLabel.attributedText = resultMessage;
    }
}

- (NSAttributedString *)cardAttributedContents:(Card *)card //abstract
{
    return nil;
}

- (NSAttributedString *)titleForCard:(Card *)card //abstract
{
    return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card //abstract
{
    return nil;
}

@end
