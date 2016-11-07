//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Stepan Paholyk on 8/27/16.
//  Copyright © 2016 Stepan Paholyk. All rights reserved.
//

#import "CardMatchingGame.h"


static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, assign) NSInteger numberOfCardsToPlayWith;
@property (nonatomic) NSMutableString *flipResult;
@end

@implementation CardMatchingGame

#pragma mark - Some init methods

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}


- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
               andCardsToPlayWith:(NSInteger)numberOdCardsToPlayWith
{
    self = [super init];
    if (self) {
        self.numberOfCardsToPlayWith = numberOdCardsToPlayWith;
        NSLog(@"NUMBERS OF CARDS TO PLAY WITH: %ld", (long)self.numberOfCardsToPlayWith);
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

#pragma mark - Operation on Card

- (Card*) cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}



- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isChosen) {
        NSLog(@"You choose %@", card.contents); //
    }

    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            NSLog(@"You unchoose %@", card.contents);
            
        } else {
            // match against other card
            NSArray *currentChosenCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {

                if (otherCard.isChosen && !otherCard.isMatched) {
                    [currentChosenCards addObject:otherCard];
                }
            }
            if ([currentChosenCards count] == self.numberOfCardsToPlayWith-1) {
                int matchScore = [card match:currentChosenCards];
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    for (Card *otherCard in currentChosenCards) {
                        otherCard.matched = YES;
                    }
                    card.matched = YES;

                } else {
                    NSLog(@"Didn't matched cards");
                    self.score -= MISMATCH_PENALTY;
                    for (Card *otherCard in currentChosenCards) {
                        otherCard.chosen = NO;
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
            // if card is NOT chosen
            card.chosen = YES;
        }
    }
    [self shouldDisableGame];
}


- (void) shouldDisableGame {
    NSMutableArray *remaningCards = [[NSMutableArray alloc] init];
    for (Card *otherCard in self.cards) {
        if (!otherCard.isMatched) {
            [remaningCards addObject:otherCard];
            
        }
    }
    if ([remaningCards count] && [remaningCards count] <= self.numberOfCardsToPlayWith) {
        Card *firstCard = [remaningCards firstObject];
        NSMutableArray *cardsToMatch = [[NSMutableArray alloc] initWithArray:remaningCards];
        [cardsToMatch removeObjectAtIndex:0];
        
        int possibleMatchScore = [firstCard match:cardsToMatch];
        if (!possibleMatchScore) {
            for (Card *card in cardsToMatch) {
                card.matched = YES;
                NSLog(@"Remaining cards: %@", card.contents);
            }
        }
    }
}






@end
