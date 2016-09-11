//
//  SecondCardMatchingGame.m
//  Matchismo
//
//  Created by Stepan Paholyk on 9/10/16.
//  Copyright © 2016 Stepan Paholyk. All rights reserved.
//

#import "SecondCardMatchingGame.h"

@implementation SecondCardMatchingGame

- (void) chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            <#statements#>
        }
    }
}

@end
