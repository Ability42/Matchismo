//
//  ViewController.m
//  Matchismo
//
//  Created by Stepan Paholyk on 8/22/16.
//  Copyright © 2016 Stepan Paholyk. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface ViewController ()
@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageBox;

@property (weak, nonatomic) IBOutlet UILabel *flipResult;

@property (nonatomic) NSInteger numberOfCardsToPlayWith;
@end

@implementation ViewController


#pragma mark - Lazy

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

#pragma mark - IBActions

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


- (Deck*) createDeck {
    return [[PlayingCardDeck alloc] init];
}


- (IBAction)redealCardsAlert:(UIButton *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Matchismo"
                                                                   message:@"Are you sure to redial cards?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self redialCards];
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
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

#pragma mark - UpdateUI

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
    
//    self.flipResult.text = 
}

#pragma mark - Card Staff

- (void)redialCards
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
