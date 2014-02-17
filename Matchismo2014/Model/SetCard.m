//
//  SetCard.m
//  Matchismo2014
//
//  Created by Arvi S Punzalan on 1/26/14.
//  Copyright (c) 2014 Arvi S Punzalan. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards
{
    //not sure if score should be a different number
    int score = 0;
    
    SetCard *otherCard1 = [otherCards firstObject];
    SetCard *otherCard2 = [otherCards lastObject];
    
    if ((([self.color isEqualToString:otherCard1.color] && [self.color isEqualToString:otherCard2.color])
        || (![self.color isEqualToString:otherCard1.color] && ![self.color isEqualToString:otherCard2.color] && ![otherCard1.color isEqualToString:otherCard2.color]))
        &&
        (([self.shape isEqualToString:otherCard1.shape] && [self.shape isEqualToString:otherCard2.shape])
        || (![self.shape isEqualToString:otherCard1.shape] && ![self.shape isEqualToString:otherCard2.shape] && ![otherCard1.shape isEqualToString:otherCard2.shape]))
        &&
        (([self.shading isEqualToString:otherCard1.shading] && [self.shading isEqualToString:otherCard2.shading])
        || (![self.shading isEqualToString:otherCard1.shading] && ![self.shading isEqualToString:otherCard2.shading] && ![otherCard1.shading isEqualToString:otherCard2.shading]))
        &&
        ((self.number == otherCard1.number && self.number == otherCard2.number)
         || (self.number != otherCard1.number && self.number != otherCard2.number && otherCard1.number != otherCard2.number)))
    {
        score = score + 5;
    }
    
    return score;
}

- (NSAttributedString *)contents
{
    return nil;
}

+ (NSArray *) validShape
{
    return @[@"shape1", @"shape2", @"shape3"];
}

+ (NSArray *) validColor
{
    return @[@"color1", @"color2", @"color3"];
}

+ (NSArray *) validShading
{
    return @[@"open", @"striped", @"solid"];
}

+ (NSUInteger) maxNumber
{
    return 3;
}

@end
