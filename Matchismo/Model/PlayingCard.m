//
//  PlayingCard.m
//  Matchismo
//
//  Created by Stepan Paholyk on 8/23/16.
//  Copyright © 2016 Stepan Paholyk. All rights reserved.
//

#import "PlayingCard.h"


@implementation PlayingCard

- (int)match:(NSArray *)otherCards {
    
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
    }
    if ([otherCards count] == 2) {
        // compare to 2 another card
        PlayingCard *firstCard = [otherCards objectAtIndex:0];
        PlayingCard *secondCard = [otherCards objectAtIndex:1];
        
        if (firstCard.rank == secondCard.rank == self.rank) {
            
            score = 16;
            
        } else if ([firstCard.suit isEqualToString:self.suit] &&
                   [secondCard.suit isEqualToString:self.suit]) {
            
            score = 4;
            
        } else if ((firstCard.rank == secondCard.rank) ||
                   (firstCard.rank == self.rank) ||
                   (secondCard.rank == self.rank)) {
            
            score = 3;
            
        } else if ([firstCard.suit isEqualToString:self.suit] ||
                   [secondCard.suit isEqualToString:self.suit] ||
                   [firstCard.suit isEqualToString:secondCard.suit]) {
            
            score = 1;
        }
    }
    
    return score;
}

- (NSString *) contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)validSuits
{
    return @[@"♣️",@"♠️",@"♦️",@"♥️"];
}

+ (NSArray *) rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"3",@"4",@"5",@"6",@"7",@"8",@"9",
      @"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [[self rankStrings] count]-1; }

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    } }
@end
