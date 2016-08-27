//
//  Card.m
//  Matchismo
//
//  Created by Stepan Paholyk on 8/22/16.
//  Copyright © 2016 Stepan Paholyk. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

@end
