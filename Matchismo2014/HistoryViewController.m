//
//  HistoryViewController.m
//  Matchismo2014
//
//  Created by Arvi S Punzalan on 2/18/14.
//  Copyright (c) 2014 Arvi S Punzalan. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
@property (nonatomic, strong) NSMutableAttributedString *history;

@end

@implementation HistoryViewController

@synthesize historyArray = _historyArray;

- (NSMutableAttributedString *)history
{
    if (!_history) {
        _history = [[NSMutableAttributedString alloc] init];
    }
    return _history;
}

- (NSMutableArray *)historyArray
{
    if (!_historyArray) _historyArray = [[NSMutableArray alloc] init];
    return _historyArray;
}

- (void)setHistoryArray:(NSMutableArray *)historyArray
{
    _historyArray = historyArray;
    if (self.view.window) [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
    for (NSAttributedString *result in self.historyArray) {
        [self.history appendAttributedString:result];
        [self.history appendAttributedString:[[NSAttributedString alloc]initWithString:@"\r"]];
    }
    self.historyTextView.attributedText = self.history;
    NSLog(@"history has %d", [self.history length]);
    NSLog(@"historyArray has %d", [self.historyArray count]);
}

@end

