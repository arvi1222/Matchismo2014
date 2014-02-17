//
//  CardGameViewController.h
//  Matchismo2014
//
//  Created by Arvi S Punzalan on 12/31/13.
//  Copyright (c) 2013 Arvi S Punzalan. All rights reserved.
//
//  Abstract class. Must implement methods as described below.

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

//  protected
//for subclasses
- (Deck *)createDeck; //abstract
- (NSAttributedString *)createTitle:(NSString *)title; //abstract

@end
