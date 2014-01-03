//
//  StartScreen.m
//  SimpleGames
//
//  Created by LieuHaiDang on 1/2/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import "StartScreen.h"
#import "PictureBoard.h"
@interface StartScreen ()

@end

@implementation StartScreen
UIButton* start;
UIButton* level;
int lvl = 1;
bool isIntialize = false;
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
    [self initMenu];
}
-(void) initMenu
{
    start = [[UIButton alloc] initWithFrame:CGRectMake(20, 450, 100, 30)];
    start.tag = 0;
    level = [[UIButton alloc] initWithFrame:CGRectMake(170, 450, 150, 30)];
    level.tag = 1;
    //[start setBackgroundImage:[UIImage imageNamed:@"StartButton.PNG"] forState:UIControlStateNormal];
    [start setTitle:@"New Game" forState:UIControlStateNormal];
    [start setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [start setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [level setTitle:@"Level: Normal" forState:UIControlStateNormal];
    [level setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [level setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [level addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [start addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];
    [self.view addSubview:level];
}
-(void) buttonClick: (id)sender
{
//    [start removeFromSuperview];
//    [level removeFromSuperview];
    UIButton* button = (UIButton*) sender;
    switch(button.tag)
    {
        case 0:
        {
            if(isIntialize)
            {
                for(PictureCell* cell in self.game.cellArray)
                {
                    [cell removeFromSuperview];
                }
                [self.game.cellArray removeAllObjects];
                [self.game.timer removeFromSuperview];
            }
            self.game = [[PictureBoard alloc] initWithLevel:lvl + 3];
            for(PictureCell* cell in self.game.cellArray)
            {
                [self.view addSubview:cell];
            }
            [self.view addSubview:self.game.timer];
            isIntialize = true;
            [self.game.timer start];
            break;
        }
        case 1:
        {
            switch (lvl)
            {
                case 0:
                {
                    [button setTitle:@"Level: Normal" forState:UIControlStateNormal];
                    break;
                }
                case 1:
                {
                    [button setTitle:@"Level: Hard" forState:UIControlStateNormal];
                    break;
                }
                case 2:
                {
                    [button setTitle:@"Level: Easy" forState:UIControlStateNormal];
                    break;
                }
            }
            lvl++;
            lvl = lvl % 3;
            break;
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
