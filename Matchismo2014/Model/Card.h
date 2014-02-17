//
//  Card.h
//  Matchismo2014
//
//  Created by Arvi S Punzalan on 12/31/13.
//  Copyright (c) 2013 Arvi S Punzalan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
