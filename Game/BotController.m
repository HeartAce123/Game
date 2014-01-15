//
//  BotController.m
//  Game
//
//  Created by LieuHaiDang on 1/11/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import "BotController.h"
#import "Seed.h"
#import "Cell.h"
@implementation BotController
- (void) evalScoreBoardWithPlayer: (Seed)player inCurrentBoard: (NSMutableArray*) board
{
    NSArray* dScore = [NSArray arrayWithObjects:0, 1, 9, 81, 729, nil];
    NSArray* aScore = [NSArray arrayWithObjects:0, 2, 18, 162, 1458, nil];
    Seed opp;
    if(player == Cross)
    {
        opp = Circle;
    }
    else
    {
        opp = Cross;
    }
    self.currentBoard = board;
    int eOpp = 0, ePlayer = 0;
    for(Cell* cell in self.currentBoard)
    {
        cell.score = 0;
    }
    //evaluate row
    for(int row = 0; row < 10; row++)
        for(int col = 0; col < 6; col++)
        {
            eOpp = 0;
            ePlayer = 0;
            for(int i = 0; i < 5; i++)
            {
                Cell* cell = (Cell*)[self.currentBoard objectAtIndex:row*10+col+i];
                if(cell.contain == opp)
                    eOpp++;
                if(cell.contain == player)
                    ePlayer++;
            }
            if(eOpp * ePlayer == 0 && eOpp != ePlayer)
            {
                for(int i = 0; i < 5; i++)
                {
                    Cell* cell = (Cell*)[self.currentBoard objectAtIndex:row*10+col+i];
                    if(cell.contain == Empty)
                    {
                        if(ePlayer == 0)
                        {
                            //add defense score
                            cell.score += (int)[dScore objectAtIndex:eOpp];
                        }
                        if(eOpp == 0)
                        {
                            //add attack score
                            cell.score += (int)[aScore objectAtIndex:ePlayer];
                        }
                        if(eOpp == 4 || ePlayer == 4)
                        {
                            cell.score *= 2;
                        }
                    }
                }
            }
        }
    //evaluate col
    for(int col = 0; col < 10; col++)
        for(int row = 0; row < 6; row++)
        {
            eOpp = 0;
            ePlayer = 0;
            for(int i = 0; i < 5; i++)
            {
                Cell* cell = (Cell*)[self.currentBoard objectAtIndex:(row+i)*10+col];
                if(cell.contain == opp)
                    eOpp++;
                if(cell.contain == player)
                    ePlayer++;
            }
            if(eOpp * ePlayer == 0 && eOpp != ePlayer)
            {
                for(int i = 0; i < 5; i++)
                {
                    Cell* cell = (Cell*)[self.currentBoard objectAtIndex:(row+i)*10+col];
                    if(cell.contain == Empty)
                    {
                        if(ePlayer == 0)
                        {
                            //add defense score
                            cell.score += (int)[dScore objectAtIndex:eOpp];
                        }
                        if(eOpp == 0)
                        {
                            //add attack score
                            cell.score += (int)[aScore objectAtIndex:ePlayer];
                        }
                        if(eOpp == 4 || ePlayer == 4)
                        {
                            cell.score *= 2;
                        }
                    }
                }
            }
        }
    //evaluate diagonal
    for(int row = 0; row < 6; row++)
        for(int col = 0; col < 6; col++)
        {
            eOpp = 0;
            ePlayer = 0;
            for(int i = 0; i < 5; i++)
            {
                Cell* cell = (Cell*)[self.currentBoard objectAtIndex:(row+i)*10+col+i];
                if(cell.contain == opp)
                    eOpp++;
                if(cell.contain == player)
                    ePlayer++;
            }
            if(eOpp * ePlayer == 0 && eOpp != ePlayer)
            {
                for(int i = 0; i < 5; i++)
                {
                    Cell* cell = (Cell*)[self.currentBoard objectAtIndex:(row+i)*10+col+i];
                    if(cell.contain == Empty)
                    {
                        if(ePlayer == 0)
                        {
                            //add defense score
                            cell.score += (int)[dScore objectAtIndex:eOpp];
                        }
                        if(eOpp == 0)
                        {
                            //add attack score
                            cell.score += (int)[aScore objectAtIndex:ePlayer];
                        }
                        if(eOpp == 4 || ePlayer == 4)
                        {
                            cell.score *= 2;
                        }
                    }
                }
            }
        }
    //evaluate alternate diagonal
    for(int row = 4; row < 6; row++)
        for(int col = 0; col < 6; col++)
        {
            eOpp = 0;
            ePlayer = 0;
            for(int i = 0; i < 5; i++)
            {
                Cell* cell = (Cell*)[self.currentBoard objectAtIndex:(row-i)*10+col+i];
                if(cell.contain == opp)
                    eOpp++;
                if(cell.contain == player)
                    ePlayer++;
            }
            if(eOpp * ePlayer == 0 && eOpp != ePlayer)
            {
                for(int i = 0; i < 5; i++)
                {
                    Cell* cell = (Cell*)[self.currentBoard objectAtIndex:(row-i)*10+col+i];
                    if(cell.contain == Empty)
                    {
                        if(ePlayer == 0)
                        {
                            //add defense score
                            cell.score += (int)[dScore objectAtIndex:eOpp];
                        }
                        if(eOpp == 0)
                        {
                            //add attack score
                            cell.score += (int)[aScore objectAtIndex:ePlayer];
                        }
                        if(eOpp == 4 || ePlayer == 4)
                        {
                            cell.score *= 2;
                        }
                    }
                }
            }
        }
}
@end
