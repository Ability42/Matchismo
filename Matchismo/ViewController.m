//
//  ViewController.m
//  Matchismo
//
//  Created by Stepan Paholyk on 8/22/16.
//  Copyright © 2016 Stepan Paholyk. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UIButton *redialCardsButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageBox;

@property (nonatomic) NSInteger numberOfCardsToPlayWith;
@end

@implementation ViewController

- (CardMatchingGame *) game
{
    
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]
                                         andCardsToPlayWith:self.numberOfCardsToPlayWith];
    }
    return _game;

}

- (NSInteger)numberOfCardsToPlayWith
{
    if (!_numberOfCardsToPlayWith) _numberOfCardsToPlayWith = 2;
    return _numberOfCardsToPlayWith;
}

- (IBAction)chooseGameMode:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 1) {
        self.numberOfCardsToPlayWith = 3;
        [self.messageBox setText:@"Mode: 3 match"];
    } else {
        self.numberOfCardsToPlayWith = 2;
        [self.messageBox setText:@"Mode: 2 match"];
    }
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]
                                         andCardsToPlayWith:self.numberOfCardsToPlayWith];// maybe 
}


- (Deck *) createDeck
{
    return nil;
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    if (self.gameModeControl.enabled)  {
       self.gameModeControl.enabled = NO;
    }
    
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}


- (void)updateUI
{
    //NSLog(@"NUMBERS OF CARDS TO PLAY WITH:%ld", (long)self.cardsToPlayWith);
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger index = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:index];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}


- (IBAction)redialCrards:(UIButton *)sender
{
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]
                                         andCardsToPlayWith:self.numberOfCardsToPlayWith];
    if (!self.gameModeControl.enabled) self.gameModeControl.enabled = YES;
    [self updateUI];
}



- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}


- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}




@end
