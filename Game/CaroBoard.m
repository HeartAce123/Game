//
//  CaroBoard.m
//  Game
//
//  Created by LieuHaiDang on 1/8/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import "CaroBoard.h"

@implementation CaroBoard
int boardSize = 10;
- (id) initWithLevel:(int)lvl
{
    self.cellArray = [[NSMutableArray alloc] init];
    int x = 9;
    int y = 140;
    for(int i = 0; i < 100; i++)
    {
        x=9+(300/boardSize)*(i%boardSize)+(i%boardSize);
        y=140+(300/boardSize)*(i/boardSize)+(i/boardSize);
        Cell* cell = [[Cell alloc] initWithIndex:i andX:x andY:y];
        [cell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.cellArray addObject:cell];
    }
    [self makeNewGame:lvl];
    return self;
}

- (void) cellClick:(id)sender
{
    Cell* cell = (Cell*)sender;
    int index = [self.cellArray indexOfObject:cell];
    cell.contain = self.currentPlayer;
    if(self.currentPlayer == Circle)
    {
        [cell setBackgroundImage:[UIImage imageNamed:@"Circle.png"] forState:UIControlStateNormal];
    }
    else
    {
        [cell setBackgroundImage:[UIImage imageNamed:@"Cross.png"] forState:UIControlStateNormal];
    }
    [self updateBoard:index];
}

- (void) updateBoard: (int)index
{
    if([self isStopPlaying:index])
    {
        for(Cell* cell in self.cellArray)
        {
            [cell setUserInteractionEnabled:NO];
        }
        NSLog(@"Game over");
    }
    else
    {
        if(self.currentPlayer == Cross)
            self.currentPlayer = Circle;
        else
            self.currentPlayer = Cross;
    }
}

- (void) makeNewGame: (int)lvl
{
    for(Cell* cell in self.cellArray)
    {
        cell.contain = Empty;
        [cell setBackgroundImage:[UIImage imageNamed:@"Empty.png"] forState:UIControlStateNormal];
    }
    self.level = lvl;
    self.gameState = Playing;
    self.currentPlayer = Cross;
}

- (BOOL) isStopPlaying: (int)index
{
    if([self isDraw])
    {
        self.gameState = Draw;
        return YES;
    }
    if([self isWonByLastMove:index])
    {
        if(self.currentPlayer == Cross)
            self.gameState = CrossWon;
        if(self.currentPlayer == Circle)
            self.gameState = CircleWon;
        return YES;
    }
    return NO;
}

- (BOOL) isDraw
{
    for(Cell* cell in self.cellArray)
    {
        if(cell.state != Empty)
        {
            return NO;
        }
    }
    return YES;
}

- (BOOL) isWonByLastMove: (int)index
{
    return (
        [self isWonbyCol:index] ||
        [self isWonByRow:index] ||
        [self isWonByDiagonal:index] ||
        [self isWonByOtherDiagonal:index]
            );
}
- (BOOL) isWonByRow: (int)index
{
    int col = index % boardSize;
    int row = index / boardSize;
    int count  = 1;
    int loop = 0;
    while (col < boardSize - 1 && loop < 5)
    {
        col++;
        Cell* cell = [self.cellArray objectAtIndex:row*boardSize+col];
        if(cell.contain == self.currentPlayer)
            count++;
        else
            break;
        loop++;
    }
    if(count >= 5)
        return YES;
    else
    {
        loop = 0;
        int col = index % boardSize;
        while (col > 0 && loop < 5)
        {
            col--;
            Cell* cell = [self.cellArray objectAtIndex:row*boardSize+col];
            if(cell.contain == self.currentPlayer)
                count++;
            else
                break;
            loop++;
        }
        if(count >= 5)
            return YES;
    }
    return NO;

}
-(BOOL) isWonbyCol: (int)index;
{
    int col = index % boardSize;
    int row = index / boardSize;
    int count  = 1;
    int loop = 0;
    while (row < boardSize - 1 && loop < 5)
    {
        row++;
        Cell* cell = [self.cellArray objectAtIndex:row*boardSize+col];
        if(cell.contain == self.currentPlayer)
            count++;
        else
            break;
        loop++;
    }
    if(count >= 5)
        return YES;
    else
    {
        int row = index / boardSize;
        loop = 0;
        while (row > 0 && loop < 5)
        {
            row--;
            Cell* cell = [self.cellArray objectAtIndex:row*boardSize+col];
            if(cell.contain == self.currentPlayer)
                count++;
            else
                break;
            loop++;
        }
        if(count >= 5)
            return YES;
    }
    return NO;
}
-(BOOL) isWonByDiagonal: (int)index
{
    int col = index % boardSize;
    int row = index / boardSize;
    int count  = 1;
    int loop = 0;
    while (col < boardSize - 1 && row < boardSize - 1 && loop < 5)
    {
        col++;
        row++;
        Cell* cell = [self.cellArray objectAtIndex:row*boardSize+col];
        if(cell.contain == self.currentPlayer)
            count++;
        else
            break;
        loop++;
    }
    if(count >= 5)
        return YES;
    else
    {
        loop = 0;
        int col = index % boardSize;
        int row = index / boardSize;
        int count  = 1;
        while (col > 0 && row > 0 && loop < 5)
        {
            col--;
            row--;
            Cell* cell = [self.cellArray objectAtIndex:row*boardSize+col];
            if(cell.contain == self.currentPlayer)
                count++;
            else
                break;
            loop++;
        }
        if(count >= 5)
            return YES;
    }
    return NO;
}
-(BOOL) isWonByOtherDiagonal: (int)index
{
    int col = index % boardSize;
    int row = index / boardSize;
    int count  = 1;
    int loop = 0;
    while (col < boardSize - 1 && row > 0 && loop < 5)
    {
        col++;
        row--;
        Cell* cell = [self.cellArray objectAtIndex:row*boardSize+col];
        if(cell.contain == self.currentPlayer)
            count++;
        else
            break;
        loop++;
    }
    if(count >= 5)
        return YES;
    else
    {
        loop = 0;
        int col = index % boardSize;
        int row = index / boardSize;
        int count  = 1;
        while (col > 0 && row < boardSize - 1 && loop < 5)
        {
            col--;
            row++;
            Cell* cell = [self.cellArray objectAtIndex:row*boardSize+col];
            if(cell.contain == self.currentPlayer)
                count++;
            else
                break;
            loop++;
        }
        if(count >= 5)
            return YES;
    }
    return NO;

}
@end
