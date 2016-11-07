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
    
    for (PlayingCard *otherCard in otherCards) {
        if (otherCard.rank == self.rank) {
            score += 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score += 1;
        }
    }
    
    /*
     * Used for comparing the contents of otherCards to match against each other
     * For Example: in 3 card match, let's assume
     *      self.rank = J♠
     *      otherCards = [4♦, 8♦]
     * In the match test block above J♠ doesn't match either 4♦ or 8♦
     * But 4♦ matches the suit of 8♦ - the following code block address that
     */
    NSMutableArray *otherCardsCollectionForComparison = [otherCards mutableCopy];
    for (PlayingCard *otherCard in otherCards) {
        [otherCardsCollectionForComparison removeObject:otherCard];
        for (PlayingCard *otherCardInOtherCardsColleciton in otherCardsCollectionForComparison) {
            if (otherCard.rank == otherCardInOtherCardsColleciton.rank) {
                score += 4;
            } else if ([otherCard.suit isEqualToString:otherCardInOtherCardsColleciton.suit]) {
                score += 1;
            }
        }
    }
    
    // Recursive function for matching cards with array of cards
/*
    int score = 0;
    if ([otherCards count] != 0) {
        if ([otherCards count] == 1) {
            PlayingCard *otherCard = [otherCards firstObject];
            if (otherCard.rank == self.rank) {
                score = 4;
            } else if ([otherCard.suit isEqualToString:self.suit]) {
                score = 1;
            } else {score = 0;}
        } else {
            for (Card *otherCard in otherCards) score += [self match:@[otherCard]];
            PlayingCard *otherCard = [otherCards firstObject];
            score += [otherCard match:[otherCards subarrayWithRange:NSMakeRange(1, [otherCards count] - 1)]];
        }
    }
*/
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
