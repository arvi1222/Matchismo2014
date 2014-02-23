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
@property (nonatomic, strong) NSMutableAttributedString *tempHistory;

@end

@implementation HistoryViewController

- (void)setHistory:(NSMutableAttributedString *)history
{
    _history = history;
    if (self.view.window) [self updateUI]; //check to see if on screen to updateUI, ow viewWillAppear will updateUI
}

- (NSMutableAttributedString *)tempHistory
{
    if (!_tempHistory) {
        _tempHistory = [[NSMutableAttributedString alloc] init];
    }
    return _tempHistory;
}

- (NSMutableArray *)historyArray
{
    if (!_historyArray) _historyArray = [[NSMutableArray alloc] init];
    return _historyArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
    for (NSAttributedString *result in self.historyArray) {
        [self.tempHistory appendAttributedString:result];
    }
    self.historyTextView.attributedText = self.tempHistory;
    NSLog(@"tempHistory has %d", [self.tempHistory length]);
    NSLog(@"historyArray has %d", [self.historyArray count]);
}

@end

