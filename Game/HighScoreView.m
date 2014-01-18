//
//  HighScoreView.m
//  Minesweeper
//
//  Created by DucNM-Mac on 1/19/14.
//  Copyright (c) 2014 DucNM-Mac. All rights reserved.
//

#import "HighScoreView.h"

@interface HighScoreView ()

@end

@implementation HighScoreView

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
    [self.view setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:150.0/255.0 alpha:1.0]];
    [[self.navigationController navigationBar] setBarTintColor:[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:150.0/255.0 alpha:1.0]];
    
    self.gameLabel = [[FXLabel alloc]initWithFrame:CGRectMake(100, 100, 180, 40)];
    [self.gameLabel setTextAlignment:NSTextAlignmentCenter];
    [self.gameLabel setFont:[UIFont fontWithName:@"Helvetica" size:30]];
    [self.gameLabel setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:150.0/255.0 alpha:1.0]];
    self.gameLabel.center = [self.view convertPoint:self.view.center fromView:self.view];
    [self.gameLabel setFrame:CGRectMake(self.gameLabel.frame.origin.x, 100, 180, 40)];
    self.gameLabel.shadowColor = [UIColor blackColor];
    self.gameLabel.shadowOffset = CGSizeZero;
    self.gameLabel.shadowBlur = 2.0f;
    self.gameLabel.innerShadowBlur = 1.0f;
    self.gameLabel.innerShadowColor = [UIColor yellowColor];
    self.gameLabel.innerShadowOffset = CGSizeMake(1.0f, 1.0f);
    self.gameLabel.gradientStartColor = [UIColor greenColor];
    self.gameLabel.gradientEndColor = [UIColor orangeColor];
    self.gameLabel.gradientStartPoint = CGPointMake(0.0f, 0.5f);
    self.gameLabel.gradientEndPoint = CGPointMake(1.0f, 0.5f);
    self.gameLabel.oversampling = 2;
    
    // draw button to navigate between games
    self.prevButton = [KHFlatButton buttonWithFrame:CGRectMake(self.gameLabel.frame.origin.x - 20 - 20, self.gameLabel.frame.origin.y, 20, 40) withTitle:@"" backgroundColor:[UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0]];
    [self.prevButton setBackgroundImage:[UIImage imageNamed:@"prev.png"] forState:UIControlStateNormal];
    self.prevButton.tag = 0;
    [self.prevButton addTarget:self action:@selector(navigateBetweenGame:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextButton = [KHFlatButton buttonWithFrame:CGRectMake(self.gameLabel.frame.origin.x + self.gameLabel.frame.size.width + 20, self.gameLabel.frame.origin.y, 20, 40) withTitle:@"" backgroundColor:[UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0]];
    [self.nextButton setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    self.nextButton.tag = 1;
    [self.nextButton addTarget:self action:@selector(navigateBetweenGame:) forControlEvents:UIControlEventTouchUpInside];
    
    // draw button to choose level
    self.gameLevel = 1;
    self.levelButton = [KHFlatButton buttonWithFrame:CGRectMake(100, self.gameLabel.frame.origin.y + self.gameLabel.frame.size.height + 30, 150, 40) withTitle:@"Normal" backgroundColor:[UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0]];
    self.levelButton.center = [self.view convertPoint:self.view.center fromView:self.view];
    [self.levelButton setFrame:CGRectMake(self.levelButton.frame.origin.x, self.gameLabel.frame.origin.y + self.gameLabel.frame.size.height + 30, 150, 40)];
    [self.levelButton addTarget:self action:@selector(changeLevel:) forControlEvents:UIControlEventTouchUpInside];
    // draw score view
    self.scoreView = [[ScoreBoard alloc]init];
    [self loadScoreBoard];
    
    
    [self setGameTitle];
    // add to view
    [self.view addSubview:self.gameLabel];
    [self.view addSubview:self.prevButton];
    [self.view addSubview:self.nextButton];
    [self.view addSubview:self.levelButton];
    [self.view addSubview:self.scoreView];
}

-(void) loadScoreBoard
{
    [self.scoreView removeFromSuperview];
    [self.scoreView resetData];
    NSString* gameName;
    int lvl = 0;
    switch(self.gameId)
    {
        case 0:
        {
            gameName = @"PicturePuzzle";
            lvl = self.gameLevel + 3;
            break;
        }
        case 1:
        {
            gameName = @"Minesweeper";
            lvl = 0;
            break;
        }
    }
    [self.scoreView loadDataOfGame:gameName andLevel:lvl];
    self.scoreView.frame = CGRectMake(self.gameLabel.frame.origin.x, self.levelButton.frame.origin.y + self.levelButton.frame.size.height + 30, self.scoreView.frame.size.width, self.scoreView.frame.size.height);
    [self.scoreView setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:150.0/255.0 alpha:1.0]];
    self.scoreView.layer.borderWidth = 1.5;
    self.scoreView.layer.borderColor = [UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0].CGColor;
    [self.view addSubview:self.scoreView];
}
-(void)navigateBetweenGame:(id)sender
{
    UIButton * button = (UIButton*)sender;
    switch (button.tag) {
        case 0:
            self.gameId = (self.gameId + 2 - 1) % 2;
            break;
        case 1:
            self.gameId = (self.gameId + 1) % 2;
            break;
        default:
            break;
    }
    [self setGameTitle];
    [self loadScoreBoard];
}

-(void)setGameTitle
{
    switch (self.gameId) {
        case 0:
            [self.gameLabel setText:@"Photo Puzzle"];
            self.levelButton.userInteractionEnabled = YES;
            [self.levelButton setBackgroundColor:[UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0]];
            break;
        case 1:
            [self.gameLabel setText:@"Minesweeper"];
            self.levelButton.userInteractionEnabled = NO;
            [self.levelButton setBackgroundColor:[UIColor grayColor]];
            break;
        default:
            break;
    }
}

-(void)changeLevel:(id)sender
{
    self.gameLevel = (self.gameLevel + 1) % 3;
    switch (self.gameLevel) {
        case 0:
            [self.levelButton setTitle:@"Easy" forState:UIControlStateNormal];
            break;
        case 1:
            [self.levelButton setTitle:@"Normal" forState:UIControlStateNormal];
            break;
        case 2:
            [self.levelButton setTitle:@"Hard" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    [self loadScoreBoard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
