//
//  PlayScreen.m
//  Game
//
//  Created by LieuHaiDang on 1/11/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import "PlayScreen.h"

@interface PlayScreen ()

@end

@implementation PlayScreen

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
    self.board = [[CaroBoard alloc] initWithLevel:11];
    [self initGameScreen];
    // Do any additional setup after loading the view from its nib.
}
- (void) initGameScreen
{
    for(CaroCell* cell in self.board.cellArray)
    {
        [self.view addSubview:cell];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
