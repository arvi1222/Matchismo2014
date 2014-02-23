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

@end

@implementation HistoryViewController

- (void)setHistory:(NSAttributedString *)history
{
    _history = history;
    if (self.view.window) [self updateUI]; //check to see if on screen to updateUI, ow viewWillAppear will updateUI
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
    //not sure if this is needed, can be simpler
}

@end

//continue video at 59 minutes