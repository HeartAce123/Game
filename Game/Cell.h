//
//  Cell.h
//  Minesweeper
//
//  Created by DucNM-Mac on 1/2/14.
//  Copyright (c) 2014 DucNM-Mac. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CellState.h"

@interface Cell : UIButton

@property int index;
@property bool isMine;
@property CellState cellState;
@property (strong, nonatomic) NSMutableArray *neighbourCells;

-(id)initWithIndex:(int) index andMine:(bool)mine andFrame:(CGRect)frame;
-(void) setMine:(bool)mine;
-(void) setState:(CellState)state;
@end
