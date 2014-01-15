//
//  Cell.m
//  Game
//
//  Created by LieuHaiDang on 1/8/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
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
- (id)initWithIndex:(int)index andX:(int)x andY:(int)y
{
    self = [[Cell alloc] initWithFrame:CGRectMake(x, y, 30, 30)];
    self.index = index;
    self.contain = Empty;
    [self setBackgroundImage:[UIImage imageNamed:@"Empty.png"] forState:UIControlStateNormal];
    //[self addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    return self;
}
- (void)cellClick:(id)sender
{
    
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
