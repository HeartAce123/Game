//
//  MainViewController.m
//  Minesweeper
//
//  Created by DucNM-Mac on 1/2/14.
//  Copyright (c) 2014 DucNM-Mac. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.game = [[GameBoard alloc]initWithWidth:8 withHeight:8 andMines:10];
    [self.view setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:150.0/255.0 alpha:1.0]];
    [[self.navigationController navigationBar] setBarTintColor:[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:150.0/255.0 alpha:1.0]];
    
    // draw gameboard
    self.gameBoard = [self.game gameBoard];
    self.gameBoard.center = [self.view convertPoint:self.view.center fromView:self.view];
    [self.gameBoard setFrame:CGRectMake(self.gameBoard.frame.origin.x, 150, self.game.width * 30 + (self.game.width - 1), self.game.height * 30 + (self.game.height - 1))];
    
    // draw clock
    self.game.clock.frame = CGRectMake(self.gameBoard.frame.origin.x,self.gameBoard.frame.origin.y - 50, 100, 50);
    [self.game.clock setTextColor:[UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0]];
    
    // draw total mine label
    self.game.mineLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.gameBoard.frame.origin.x + self.gameBoard.frame.size.width - 100, self.gameBoard.frame.origin.y - 50, 100, 50)];
    [self.game.mineLabel setText: [NSString stringWithFormat:@"Mines : %d",self.game.totalMines]];
    [self.game.mineLabel setTextColor:[UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0]];
    [self.game.mineLabel setTextAlignment:NSTextAlignmentRight];
    
    // draw start button
    self.startButton = [KHFlatButton buttonWithFrame:CGRectMake(self.gameBoard.frame.origin.x, self.gameBoard.frame.origin.y + self.gameBoard.frame.size.height + 20, 100, 40) withTitle:@"New Game" backgroundColor:[UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0]];
    [self.startButton addTarget:self action:@selector(newGame:) forControlEvents:UIControlEventTouchUpInside];
    
    // draw flag button
    self.flagButton = [KHFlatButton buttonWithFrame:CGRectMake(self.gameBoard.frame.origin.x + self.gameBoard.frame.size.width - 100, self.gameBoard.frame.origin.y + self.gameBoard.frame.size.height + 20, 100, 40) withTitle:@"Flag Off" backgroundColor:[UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0]];
    [self.flagButton addTarget:self action:@selector(flagMode:) forControlEvents:UIControlEventTouchUpInside];
    
    // add to view
    [self.view addSubview:self.gameBoard];
    [self.view addSubview:self.game.clock];
    [self.view addSubview:self.game.mineLabel];
    [self.view addSubview:self.startButton];
    [self.view addSubview:self.flagButton];
    
    // start game clock
    [self.game.clock start];
}

-(void)newGame:(id)sender
{
    // remove gameboard
    [self.gameBoard removeFromSuperview];
    [self.game.board removeAllObjects];
    
    // make new gameboard
    [self.game generateBoard];
    [self.game.clock reset];
    [self.game.mineLabel setText: [NSString stringWithFormat:@"Mines : %d",self.game.totalMines]];
    [self.flagButton setTitle:@"Flag Off" forState:UIControlStateNormal];
    
    // draw new gameboard
    self.gameBoard = [self.game gameBoard];
    self.gameBoard.center = [self.view convertPoint:self.view.center fromView:self.view];
    [self.gameBoard setFrame:CGRectMake(self.gameBoard.frame.origin.x, 100, self.game.width * 30 + (self.game.width - 1), self.game.height * 30 + (self.game.height - 1))];
    
    // add to view
    [self.view addSubview:self.gameBoard];
    
    // start game clock
    [self.game.clock start];
}

-(void)flagMode:(id)sender
{
    UIButton *flagButton = (UIButton*)sender;
    // set flag mode on/off
    if (self.game.isFlag)
    {
        self.game.isFlag = NO;
        [flagButton setTitle:@"Flag Off" forState:UIControlStateNormal];
    } else {
        self.game.isFlag = YES;
        [flagButton setTitle:@"Flag On" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
