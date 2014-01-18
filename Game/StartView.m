//
//  StartView.m
//  Minesweeper
//
//  Created by DucNM-Mac on 1/16/14.
//  Copyright (c) 2014 DucNM-Mac. All rights reserved.
//

#import "StartView.h"
#import "StartScreen.h"
@interface StartView ()

@end

@implementation StartView

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
    
    self.gameId = 1;
    
    // draw game title label
    self.gameLabel = [[FXLabel alloc]initWithFrame:CGRectMake(100, 100, 180, 40)];
    [self setGameTitle];
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
    
    // draw button to start chosen game
    self.startButton = [KHFlatButton buttonWithFrame:CGRectMake(100, self.gameLabel.frame.origin.y + self.gameLabel.frame.size.height + 30, 150, 40) withTitle:@"Start" backgroundColor:[UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0]];
    self.startButton.center = [self.view convertPoint:self.view.center fromView:self.view];
    [self.startButton setFrame:CGRectMake(self.startButton.frame.origin.x, self.gameLabel.frame.origin.y + self.gameLabel.frame.size.height + 30, 150, 40)];
    [self.startButton addTarget:self action:@selector(startGame:) forControlEvents:UIControlEventTouchUpInside];
    
    // draw button to see chosen game high score
    self.highscoreButton = [KHFlatButton buttonWithFrame:CGRectMake(self.startButton.frame.origin.x, self.startButton.frame.origin.y + self.startButton.frame.size.height + 30, 150, 40) withTitle:@"Highscore" backgroundColor:[UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0]];
    [self.highscoreButton addTarget:self action:@selector(highscore:) forControlEvents:UIControlEventTouchUpInside];
    
    // draw button to share via social network
    self.shareButton = [KHFlatButton buttonWithFrame:CGRectMake(self.startButton.frame.origin.x, self.highscoreButton.frame.origin.y + self.highscoreButton.frame.size.height + 30, 150, 40) withTitle:@"Share" backgroundColor:[UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0]];
    [self.shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    // draw button to show credit
    self.aboutButton = [KHFlatButton buttonWithFrame:CGRectMake(self.startButton.frame.origin.x, self.shareButton.frame.origin.y + self.shareButton.frame.size.height + 30, 150, 40) withTitle:@"About" backgroundColor:[UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0]];
    [self.aboutButton addTarget:self action:@selector(about:) forControlEvents:UIControlEventTouchUpInside];
    
    // add to view
    [self.view addSubview:self.gameLabel];
    [self.view addSubview:self.prevButton];
    [self.view addSubview:self.nextButton];
    [self.view addSubview:self.startButton];
    [self.view addSubview:self.highscoreButton];
    [self.view addSubview:self.shareButton];
    [self.view addSubview:self.aboutButton];
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
}

-(void)setGameTitle
{
    switch (self.gameId) {
        case 0:
            [self.gameLabel setText:@"Photo Puzzle"];
            break;
        case 1:
            [self.gameLabel setText:@"Minesweeper"];
            break;
        default:
            break;
    }
}

-(void)startGame:(id)sender
{
    // open view of chosen game
    switch(self.gameId)
    {
        case 0:
        {
            StartScreen* mainView = [[StartScreen alloc] initWithNibName:@"StartScreen" bundle:nil];
            [self.navigationController pushViewController:mainView animated:YES];
            break;
        }
        case 1:
        {
            MainViewController *mainView = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
            [self.navigationController pushViewController:mainView animated:YES];
            break;
        }
        default:
        {
            NSLog(@"do nothing");
            break;
        }
    }
}

-(void)highscore:(id)sender
{
    // open view to show high score of chosen game
    HighScoreView *score = [[HighScoreView alloc]initWithNibName:@"HighScoreView" bundle:nil];
    score.gameId = self.gameId;
    [self.navigationController pushViewController:score animated:YES];
}

-(void)share:(id)sender
{
    // items to share
    NSArray *activityItem;
    NSString * mes = @"Sharing is caring";
    activityItem = @[mes];
    
    // init view for sharing
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:activityItem applicationActivities:nil];
    
    // open view for sharing
    [self presentViewController:activityViewController animated:YES completion:nil];
}

-(void)about:(id)sender
{
    // show about, credit
    NSString *mes = @"Author : Liễu Hải Đăng\nNguyễn Minh Đức\nCopyright: 2013\n";
    UIAlertView *aboutView = [[UIAlertView alloc]initWithTitle:@"Simple Games" message: mes delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [aboutView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

