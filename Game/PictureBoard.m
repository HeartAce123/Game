//
//  PictureBoard.m
//  SimpleGames
//
//  Created by LieuHaiDang on 1/2/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import "PictureBoard.h"
#import "PictureHandler.h"
#import "Cell.h"
#include <stdlib.h>
@implementation PictureBoard
-(id)initWithLevel:(int)lvl
{
    self.level = lvl;
    int count = lvl*lvl;
    int x = 0;
    int y = 0;
    self.level = lvl;
    self.timer = [[MZTimerLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.timer.font = [UIFont systemFontOfSize:25];
    self.timer.textColor= [UIColor colorWithRed:120.0/255 green:190.0/255 blue:50.0/255 alpha:1.0];
    NSMutableArray *array = [self generateArray];
    self.cellArray = [[NSMutableArray alloc] init];
    [PictureHandler createPieceArrayBy:[PictureHandler gamePictureByImageOrDefault:nil] andLevel:lvl];
    for(int i = 0;i < count;i++)
    {
        int index = ((NSNumber*)[array objectAtIndex:i]).intValue;
        x=(300/lvl)*(i%lvl)+(i%lvl);
        y=(300/lvl)*(i/lvl)+(i/lvl);
        PictureCell* cell = [[PictureCell alloc] initWithIndex:i withImage: (UIImage*)[[PictureHandler pieceArray] objectAtIndex:index] andX:x andY:y andLevel:lvl andRealIndex:index];
        [cell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
        if(i == count - 1)
        {
            [cell setBackgroundImage:nil forState:UIControlStateNormal];
            cell.isEmpty = YES;
        }
        [self.cellArray addObject:cell];
    }
    self.highScore = [[DataHandler alloc] initWithCoder];
    [self.highScore loadScoreOfGame:@"PicturePuzzle" withLevel:self.level];
    return self;
}

-(void)cellClick:(id)sender
{
    PictureCell* cell = (PictureCell*)sender;
    NSMutableArray* adjustedCell = [[NSMutableArray alloc] init];
    int currentIndex = cell.index;
    if(cell.isEmpty)
        return;
    int row = cell.index / self.level;
    int col = cell.index % self.level;
    if(row > 0)
    {
        NSNumber* index = [NSNumber numberWithInt:currentIndex - self.level];
        [adjustedCell addObject:index];
    }
    if(row < self.level - 1)
    {
        NSNumber* index = [NSNumber numberWithInt:currentIndex + self.level];
        [adjustedCell addObject:index];
    }
    if(col > 0)
    {
        NSNumber* index = [NSNumber numberWithInt:currentIndex - 1];
        [adjustedCell addObject:index];
    }
    if(col < self.level - 1)
    {
        NSNumber* index = [NSNumber numberWithInt:currentIndex + 1];
        [adjustedCell addObject:index];
    }
    [self trySwapCell:currentIndex withEachOf:adjustedCell];
    if([self isWon])
    {
        [self wonAction];
    }
}
-(void)trySwapCell:(int)currentIndex withEachOf: (NSMutableArray*)adjustedCell
{
    for(NSNumber* number in adjustedCell)
    {
        int index = number.intValue;
        if(((PictureCell*)[self.cellArray objectAtIndex:index]).isEmpty)
        {
            PictureCell* cell = ((PictureCell*)[self.cellArray objectAtIndex:currentIndex]);
            PictureCell* emptyCell = ((PictureCell*)[self.cellArray objectAtIndex:index]);
            int tempIndex = cell.realIndex;
            UIImage* tempImage = cell.image;
            cell.realIndex = emptyCell.realIndex;
            cell.image = emptyCell.image;
            emptyCell.realIndex = tempIndex;
            emptyCell.image = tempImage;
            [emptyCell setBackgroundImage:emptyCell.image forState:UIControlStateNormal];
            [cell setBackgroundImage:nil forState:UIControlStateNormal];
            cell.isEmpty = YES;
            emptyCell.isEmpty = NO;
            return;
        }
    }
}
-(NSMutableArray*)generateArray
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    int count = self.level * self.level - 1;
    int inversion = 0;
    do
    {
        [array removeAllObjects];
        inversion = 0;
        while(array.count < count)
        {
            int r = arc4random() % count;
            NSNumber* index = [NSNumber numberWithInt:r];
            if(![array containsObject:index])
            {
                [array addObject:index];
            }
        }
        [array addObject:[NSNumber numberWithInt:count]];
        for(int i = 0; i < array.count; i++)
        {
            for(int j = i+1; j<array.count; j++)
            {
                int a = ((NSNumber*)[array objectAtIndex:i]).intValue;
                int b = ((NSNumber*)[array objectAtIndex:j]).intValue;
                if(a > b)
                    inversion++;
            }
        }
    }
    while(inversion % 2 != 0);
    return array;
}
-(BOOL) isWon
{
    for(PictureCell* cell in self.cellArray)
    {
        if(cell.index != cell.realIndex)
            return NO;
    }
    return YES;
}
-(void) wonAction
{
    [self.timer pause];
    NSString* record = self.timer.text;
    BOOL isBreak = [self.highScore updateScoreList:record inGame:@"PicturePuzzle" withLevel:self.level];
    for(PictureCell* cell in self.cellArray)
    {
        [cell setUserInteractionEnabled:NO];
    }
    PictureCell* cell = (PictureCell*)[self.cellArray lastObject];
    [cell setBackgroundImage:cell.image forState:UIControlStateNormal];
    UIAlertView* alert;
    if(!isBreak)
    {
        alert = [[UIAlertView alloc] initWithTitle:@"You Won!!" message:[@"Your record: " stringByAppendingString:record] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
    else
    {
        alert = [[UIAlertView alloc] initWithTitle:@"You got into highscore board!!" message:[@"Your record: " stringByAppendingString:record] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
    [alert show];
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int index = (int)buttonIndex;
    switch (index)
    {
        case 0:
        {
            NSLog(@"0");
            break;
        }
        case 1:
        {
            NSLog(@"1");
            break;
        }
        case 2:
        {
            NSLog(@"2");
            break;
        }
    }
}
- (UIView*) boardGame
{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300 + self.level - 1, 300 + self.level - 1)];
    for(Cell* cell in self.cellArray)
    {
        [view addSubview:cell];
    }
    return view;
}
@end
