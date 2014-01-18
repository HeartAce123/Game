//
//  MainViewController.h
//  Minesweeper
//
//  Created by DucNM-Mac on 1/2/14.
//  Copyright (c) 2014 DucNM-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameBoard.h"

@interface MainViewController : UIViewController

@property (strong, nonatomic) GameBoard *game;
@property (strong, nonatomic) UIView *gameBoard;
@property (strong, nonatomic) UIButton *startButton;
@property (strong, nonatomic) UIButton *flagButton;
-(void)newGame:(id) sender;
-(void)flagMode:(id)sender;
@end
