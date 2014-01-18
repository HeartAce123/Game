//
//  ScoreCell.m
//  Minesweeper
//
//  Created by DucNM-Mac on 1/19/14.
//  Copyright (c) 2014 DucNM-Mac. All rights reserved.
//

#import "ScoreCell.h"

@implementation ScoreCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setCellIndex:(int)index
{
    self.index = index;
    self.indexLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.indexLabel setText:[NSString stringWithFormat:@"%d", self.index]];
    [self.indexLabel setTextAlignment:NSTextAlignmentCenter];
    self.indexLabel.layer.borderWidth = 0.5;
    self.indexLabel.layer.borderColor = [UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0].CGColor;
    [self addSubview:self.indexLabel];
}

-(void)setCellScore:(NSString *)score
{
    self.score = score;
    self.scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, self.frame.size.width - 30, 30)];
    [self.scoreLabel setText:self.score];
    [self.scoreLabel setTextAlignment:NSTextAlignmentCenter];
    self.scoreLabel.layer.borderWidth = 0.5;
    self.scoreLabel.layer.borderColor = [UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0].CGColor;
    [self addSubview:self.scoreLabel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
