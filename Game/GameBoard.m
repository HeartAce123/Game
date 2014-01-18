//
//  GameBoard.m
//  Minesweeper
//
//  Created by DucNM-Mac on 1/2/14.
//  Copyright (c) 2014 DucNM-Mac. All rights reserved.
//

#import "GameBoard.h"
#include <stdlib.h>

@implementation GameBoard

-(id)initWithWidth:(int) width withHeight:(int) height andMines:(int) totalMines
{
    self = [super init];
    self.data = [[DataHandler alloc] initWithCoder];
    if (self) {
        self.width = width;
        self.height = height;
        self.totalMines = totalMines;
        self.board = [[NSMutableArray alloc]init];
    }
    
    [self generateBoard];
    
    self.clock = [[MZTimerLabel alloc]init];
    return self;
}

-(void)generateBoard
{
    // generate new gameboard
    int total = self.width * self.height;
    self.safeZones = total - self.totalMines;
    self.flaged = 0;
    self.isFlag = NO;
    for (int i = 0; i < total; i++) {
        Cell *cell = [[Cell alloc]initWithIndex:i andMine:NO andFrame:CGRectMake(0, 0, 30, 30)];
        [cell addTarget:self action:@selector(CellClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.board addObject:cell];
    }
    
    int mine = 0;
    
    while (mine < self.totalMines) {
        int index = arc4random() % total;
        Cell *cell = (Cell*)[self.board objectAtIndex:index];
        if (cell.isMine == NO) {
            [cell setMine:YES];
            mine ++;
        }
    }
    [self.data loadScoreOfGame:@"Minesweeper" withLevel:0];
}

-(UIView*)gameBoard
{
    // draw gameboard
    int x = 0;
    int y = 0;
    UIView *boardView = [[UIView alloc]init];
    for (int i = 0; i < self.width * self.height; i++) {
        Cell *cell = (Cell*)[self.board objectAtIndex:i];
        [cell setFrame:CGRectMake(x, y, 30, 30)];
        [boardView addSubview:cell];
        if ((cell.index + 1)  % self.width) {
            x = x + 30 + 1;
        } else {
            x = 0;
            y = y + 30 + 1;
        }
    }
    boardView.frame = CGRectMake(0, 0, self.width * 30 + (self.width - 1), self.height * 30 + (self.height - 1));
    return boardView;
}

-(void)CellClick:(id) sender
{
    Cell *cell = (Cell*) sender;
    if (self.isFlag) {
        if (cell.cellState == Flag) {
            [cell setState:Hidden];
            self.flaged --;
        } else {
        [cell setState:Flag];
            self.flaged ++;
        }
        [self.mineLabel setText: [NSString stringWithFormat:@"Mines : %d",self.totalMines - self.flaged]];
    } else {
        if (cell.cellState == Hidden) {
            [self revealCellAtIndex:cell.index];
        }
    }
}

-(void)revealCellAtIndex:(int)index
{
    Cell *cell = (Cell*)[self.board objectAtIndex:index];
    if (cell.isMine) {
        [self setResult:NO];
    } else {
        // set number of mines found
        int mine = [self numberOfMinesAroundCellAtIndex:cell.index];
        [cell setTitle:[NSString stringWithFormat:@"%d",mine] forState:UIControlStateNormal];
        [cell setState:Reveal];
        self.safeZones --;
        if (mine == 0) {
            for (NSNumber *i in cell.neighbourCells) {
                int d = i.intValue;
                Cell *newCell = (Cell*)[self.board objectAtIndex:d];
                if (!newCell.isMine && newCell.cellState == Hidden) {
                    [self revealCellAtIndex:newCell.index];
                }
            }
        }
        if (self.safeZones == 0) {
            [self setResult:YES];
        }
    }
}

-(void)setResult:(bool) result
{
    [self.clock pause];
    NSString *time = self.clock.text;
    BOOL isBreak = NO;
    if(result)
    {
        isBreak= [self saveHighScore:time];
    }
    for (Cell *cell in self.board) {
        [cell setState:Reveal];
    }
    NSString *mes = @"You Win";
    if (!result) {
        mes = @"You Lose";
        for (Cell *cell in self.board) {
            if (cell.isMine) {
                [cell setBackgroundImage:[UIImage imageNamed:@"mine.png"] forState:UIControlStateNormal];
            }
        }
    }
    UIAlertView *alert;
    if(isBreak && result)
    {
        alert = [[UIAlertView alloc]initWithTitle:@"Result" message:[mes stringByAppendingString:@"\nNew record!!"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
    else
    {
        alert = [[UIAlertView alloc]initWithTitle:@"Result" message:mes delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
    [alert show];
}

-(bool)saveHighScore:(NSString*) score
{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"HH:mm:ss"];
//    NSDate *currentDate = [dateFormatter dateFromString:score];
//    NSTimeInterval interval = [currentDate timeIntervalSince1970];
//    NSInteger i = interval;
//    NSString *time = [NSString stringWithFormat:@"%d", i];
    if([self.data updateScoreList:score inGame:@"Minesweeper" withLevel:0])
        return YES;
    return NO;
}

-(int)numberOfMinesAroundCellAtIndex:(int)index
{
    int mine = 0;
    Cell *cell = (Cell*)[self.board objectAtIndex:index];
    int i = -1;
    int j = 1;
    // check if last col
    if ((cell.index + 1) % self.width != 0) {
        int newIndex = cell.index + 1;
        Cell *adjustedRightCell = (Cell*)[self.board objectAtIndex:newIndex];
        if (adjustedRightCell.isMine) {
            mine ++;
        }
        [cell.neighbourCells addObject:[NSNumber numberWithInt:newIndex ]];
    } else {
        j = 0;
    }
    // check if first col
    if ((cell.index) % self.width != 0) {
        int newIndex = cell.index - 1;
        Cell *adjustedLeftCell = (Cell*)[self.board objectAtIndex:newIndex];
        if (adjustedLeftCell.isMine) {
            mine ++;
        }
        [cell.neighbourCells addObject:[NSNumber numberWithInt:newIndex ]];
    } else {
        i = 0;
    }
    // check if last row
    if (cell.index < (self.width * self.height)-self.width) {
        for (; i <= j; i++) {
            int newIndex = cell.index + self.width + i;
            Cell *adjustedBelowCell = (Cell*)[self.board objectAtIndex:newIndex];
            if (adjustedBelowCell.isMine) {
                mine ++;
            }
            [cell.neighbourCells addObject:[NSNumber numberWithInt:newIndex ]];
        }
    }
    
    if ((cell.index + 1) % self.width != 0) {
        j = 1;
    } else {
        j = 0;
    }
    
    if ((cell.index) % self.width != 0) {
        i = -1;
    } else {
        i = 0;
    }
    // check if first row
    if (cell.index > self.width - 1) {
        for (; i <= j; i++) {
            int newIndex = cell.index - self.width + i;
            Cell *adjustedAboveCell = (Cell*)[self.board objectAtIndex:newIndex];
            if (adjustedAboveCell.isMine) {
                mine ++;
            }
            [cell.neighbourCells addObject:[NSNumber numberWithInt:newIndex ]];
        }
    }
    return mine;
}

@end
