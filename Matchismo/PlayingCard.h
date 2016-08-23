//
//  PlayingCard.h
//  Matchismo
//
//  Created by Stepan Paholyk on 8/23/16.
//  Copyright © 2016 Stepan Paholyk. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;


@end
