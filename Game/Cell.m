//
//  Cell.m
//  Minesweeper
//
//  Created by DucNM-Mac on 1/2/14.
//  Copyright (c) 2014 DucNM-Mac. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(id)initWithIndex:(int)index andMine:(bool)mine andFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.index = index;
    [self setMine:mine];
    self.neighbourCells = [[NSMutableArray alloc]init];
    [self setState:Hidden];
//    [self setBackgroundImage:[UIImage imageNamed:@"grass.png"] forState:UIControlStateNormal];
    return self;
}

-(void)setMine:(bool)mine
{
    self.isMine = mine;
}

-(void)setState:(CellState)state
{
    self.cellState = state;
    if (self.cellState == Flag) {
        [self setBackgroundImage:[UIImage imageNamed:@"flag.png"] forState:UIControlStateNormal];
    }
    if (self.cellState == Hidden) {
        [self setBackgroundImage:[UIImage imageNamed:@"grass.png"] forState:UIControlStateNormal];
    }
    if (self.cellState == Reveal) {
        self.userInteractionEnabled = NO;
    }
}

@end
