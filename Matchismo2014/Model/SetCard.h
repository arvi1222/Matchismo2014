//
//  SetCard.h
//  Matchismo2014
//
//  Created by Arvi S Punzalan on 1/26/14.
//  Copyright (c) 2014 Arvi S Punzalan. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger number;


+ (NSArray *) validShape;
+ (NSArray *) validColor;
+ (NSArray *) validShading;
+ (NSUInteger) maxNumber;


@end
