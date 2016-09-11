//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Stepan Paholyk on 9/8/16.
//  Copyright © 2016 Stepan Paholyk. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck*) createDeck {
    return [[PlayingCardDeck alloc] init];
}


@end
