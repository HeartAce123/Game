//
//  ScoreBoard.m
//  Minesweeper
//
//  Created by DucNM-Mac on 1/19/14.
//  Copyright (c) 2014 DucNM-Mac. All rights reserved.
//

#import "ScoreBoard.h"
#import "Score.h"
@implementation ScoreBoard

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)loadDataOfGame:(NSString *)game andLevel:(int)lvl
{
    self.dataSource = [[DataHandler alloc]initWithCoder];
    [self.dataSource loadScoreOfGame:game withLevel:lvl];
    int y = 0;
    self.cellArray = [[NSMutableArray alloc] init];
    for(Score* score in self.dataSource.scoreList)
    {
        NSString* time = score.time;
        ScoreCell *cell = [[ScoreCell alloc]initWithFrame:CGRectMake(0, y, 180, 30)];
        [cell setCellIndex:[self.dataSource.scoreList indexOfObject:score] + 1];
        [cell setCellScore:time];
        [self.cellArray addObject:cell];
        y += 30;
    }
    for(ScoreCell* cell in self.cellArray)
    {
        [self addSubview:cell];
    }
    self.frame = CGRectMake(0, 0, 180, 30 * [self.dataSource.scoreList count]);
}

-(void)resetData
{
    for(ScoreCell* cell in self.cellArray)
    {
        [cell removeFromSuperview];
    }
    [self.cellArray removeAllObjects];
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
