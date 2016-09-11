//
//  ViewController.m
//  Matchismo
//
//  Created by Stepan Paholyk on 8/22/16.
//  Copyright © 2016 Stepan Paholyk. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"
#import "SecondCardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISwitch *gameMode;
@end

@implementation ViewController

- (CardMatchingGame *) game
{
    if (!_game) {
        if ([self.gameMode isOn]) {
            // 2 match mod
            _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                      usingDeck:[self createDeck]];
        } else if (![self.gameMode isOn]) {
            // 3 match mode
            _game = [[SecondCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                            usingDeck:[self createDeck]];
        }
    }
    return _game;

}

- (Deck *) createDeck
{
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void)updateUI
{
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
    self.scoreLabel.text = @"You start's a new game!";
    self.game = nil;
    for (UIButton *cardButton in self.cardButtons) {
        [cardButton setTitle:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardBack"] forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
    [self game];
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
