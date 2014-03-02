//
//  SetCardGameViewController.m
//  Matchismo2014
//
//  Created by Arvi S Punzalan on 2/9/14.
//  Copyright (c) 2014 Arvi S Punzalan. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "HistoryViewController.h"

@interface SetCardGameViewController ()
@property (strong, nonatomic) NSDictionary *shapes;
@property (strong, nonatomic) NSDictionary *colors;
@property (strong, nonatomic) NSDictionary *shadedColors;

@end

@implementation SetCardGameViewController

- (NSDictionary *)shapes
{
    if (!_shapes) {
        _shapes = [[NSDictionary alloc] initWithObjects:@[@"▲", @"●", @"■"] forKeys:@[@"shape1", @"shape2", @"shape3"]];
    }
    return _shapes;
}

- (NSDictionary *)colors
{
    if (!_colors) {
        _colors = [[NSDictionary alloc]initWithObjects:@[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]]
                                               forKeys:@[@"color1", @"color2", @"color3"]];
    }
    return _colors;
}

- (NSDictionary *)shadedColors
{
    if (!_shadedColors) {
        _shadedColors = [[NSDictionary alloc]initWithObjects:@[[[UIColor redColor] colorWithAlphaComponent:0.3],
                                                               [[UIColor greenColor] colorWithAlphaComponent:0.3],
                                                               [[UIColor purpleColor] colorWithAlphaComponent:0.3]]
                                                     forKeys:@[@"color1", @"color2", @"color3"]];
    }
    return _shadedColors;
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Set History"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *hvc = (HistoryViewController *)segue.destinationViewController;
            hvc.historyArray = self.resultHistory;
        }
    }
}

- (NSAttributedString *)cardAttributedContents:(Card *)card
{
    return [self titleForCard:card];
}

- (NSAttributedString *)titleForCard:(Card *)card
{    
    //create string with correct # of shapes
    SetCard *theCard = (SetCard *)card;
    
    NSMutableString *shapes = [[NSMutableString alloc]init];
    if (theCard.number <= [SetCard maxNumber]) {
        for (int i=0; i<theCard.number; i++) {
            [shapes appendString:self.shapes[theCard.shape]];
        }
    }
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString: shapes];

    [title addAttributes:@{NSStrokeWidthAttributeName:@-5, NSStrokeColorAttributeName:self.colors[theCard.color]}
                   range:NSMakeRange(0, [title length])];
    if ([theCard.shading isEqualToString:@"solid"]) {
        [title addAttribute:NSForegroundColorAttributeName value:self.colors[theCard.color]
                      range:NSMakeRange(0, [title length])];
    } else if ([theCard.shading isEqualToString:@"striped"]) {
        [title addAttribute:NSForegroundColorAttributeName value:self.shadedColors[theCard.color]
                      range:NSMakeRange(0, [title length])];
    } else {
        [title addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]
                      range:NSMakeRange(0, [title length])];
    }
    
    return title;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    UIImage *chosenImage = [self imageByApplyingAlpha:0.5 forImage:[UIImage imageNamed:@"cardfront"]];
    return card.isChosen ? chosenImage : [UIImage imageNamed:@"cardfront"];
}

- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha forImage:(UIImage *) image{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
