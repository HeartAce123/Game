//
//  StartView.h
//  Minesweeper
//
//  Created by DucNM-Mac on 1/16/14.
//  Copyright (c) 2014 DucNM-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHFlatButton.h"
#import "FXLabel.h"
#import "MainViewController.h"
#import "HighScoreView.h"

@interface StartView : UIViewController

@property int gameId;
@property (strong, nonatomic) FXLabel *gameLabel;
@property (strong, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) UIButton *prevButton;
@property (strong, nonatomic) UIButton *startButton;
@property (strong, nonatomic) UIButton *highscoreButton;
@property (strong, nonatomic) UIButton *shareButton;
@property (strong, nonatomic) UIButton *aboutButton;

-(void)navigateBetweenGame:(id)sender;
-(void)startGame:(id)sender;
-(void)highscore:(id)sender;
-(void)share:(id)sender;
-(void)about:(id)sender;
@end
