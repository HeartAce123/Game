//
//  PictureBoard.m
//  SimpleGames
//
//  Created by LieuHaiDang on 1/2/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import "PictureBoard.h"
#include <stdlib.h>
@implementation PictureBoard
-(id)initWithLevel:(int)lvl
{
    int count = lvl*lvl;
    int x = 9;
    int y = 140;
    self.level = lvl;
    self.timer = [[MZTimerLabel alloc] initWithFrame:CGRectMake(115, 80, 100, 30)];
    self.timer.font = [UIFont systemFontOfSize:25];
    self.timer.textColor= [UIColor greenColor];
    NSMutableArray *array = [self generateArray:lvl];
    self.cellArray = [[NSMutableArray alloc] init];
    [self makeImageArrayByLevel:lvl];
    for(int i = 0;i < count;i++)
    {
        int index = ((NSNumber*)[array objectAtIndex:i]).intValue;
        x=9+(300/lvl)*(i%lvl)+(i%lvl);
        y=140+(300/lvl)*(i/lvl)+(i/lvl);
        PictureCell* cell = [[PictureCell alloc] initWithIndex:i withImage: (UIImage*)[self.imgArray objectAtIndex:index] andX:x andY:y andLevel:lvl andRealIndex:index];
        [cell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
        if(i == count - 1)
        {
            cell.image = nil;
            [cell setBackgroundImage:nil forState:UIControlStateNormal];
            cell.isEmpty = YES;
        }
        [self.cellArray addObject:cell];
    }
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
            int tempIndex = cell.realIndex;
            UIImage* tempImage = cell.image;
            UIImage* tempImage2 = ((PictureCell*)[self.cellArray objectAtIndex:index]).image;
            ((PictureCell*)[self.cellArray objectAtIndex:currentIndex]).realIndex = ((PictureCell*)[self.cellArray objectAtIndex:index]).realIndex;
            ((PictureCell*)[self.cellArray objectAtIndex:currentIndex]).image = ((PictureCell*)[self.cellArray objectAtIndex:index]).image;
            ((PictureCell*)[self.cellArray objectAtIndex:index]).realIndex = tempIndex;
            ((PictureCell*)[self.cellArray objectAtIndex:index]).image = tempImage;
            [((PictureCell*)[self.cellArray objectAtIndex:index]) setBackgroundImage:tempImage forState:UIControlStateNormal];
            [((PictureCell*)[self.cellArray objectAtIndex:currentIndex]) setBackgroundImage:tempImage2 forState:UIControlStateNormal];
            cell.isEmpty = YES;
            ((PictureCell*)[self.cellArray objectAtIndex:index]).isEmpty = NO;
            return;
        }
    }
}
-(NSMutableArray*)generateArray: (int)lvl
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    int count = lvl*lvl-1;
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
    for(PictureCell* cell in self.cellArray)
    {
        [cell setUserInteractionEnabled:NO];
    }
    PictureCell* cell = (PictureCell*)[self.cellArray lastObject];
    cell.image = (UIImage*)[self.imgArray lastObject];
    [cell setBackgroundImage:cell.image forState:UIControlStateNormal];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"You Won!!" message:[@"Your record: " stringByAppendingString:record] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Play again", @"Make it harder!", @"No way", nil];
    [alert show];
}
-(void)makeImageArrayByLevel: (int)lvl;
{
    self.imgArray = [[NSMutableArray alloc] init];
    [self.imgArray removeAllObjects];
    UIImage* image = [UIImage imageNamed:@"testImg.jpg"];
    CGSize imageSize = [image size];
    for(int i = 0;i < lvl*lvl;i++)
    {
        int temp = (int)imageSize.height;
        int x = (imageSize.width / lvl)*(i%lvl);
        int y = (temp / lvl)*(i/lvl);
        CGRect area = CGRectMake(x, y, imageSize.width / lvl, imageSize.height / lvl);
        CGImageRef crop = CGImageCreateWithImageInRect([image CGImage], area);
        UIImage* piece = [UIImage imageWithCGImage:crop];
        CGImageRelease(crop);
        [self.imgArray addObject:piece];
    }
}
@end
