//
//  HighScoreView.h
//  Minesweeper
//
//  Created by DucNM-Mac on 1/19/14.
//  Copyright (c) 2014 DucNM-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXLabel.h"
#import "KHFlatButton.h"
#import "ScoreBoard.h"

@interface HighScoreView : UIViewController

@property int gameId;
@property int gameLevel;
@property (strong, nonatomic) ScoreBoard *scoreView;
@property (strong, nonatomic) FXLabel *gameLabel;
@property (strong, nonatomic) UIButton *levelButton;
@property (strong, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) UIButton *prevButton;

-(void)navigateBetweenGame:(id)sender;
-(void)changeLevel:(id)sender;
@end
