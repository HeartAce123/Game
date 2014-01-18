//
//  GameBoard.h
//  Minesweeper
//
//  Created by DucNM-Mac on 1/2/14.
//  Copyright (c) 2014 DucNM-Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"
#import "MZTimerLabel.h"
#import "KHFlatButton.h"
#import "DataHandler.h"

@interface GameBoard : NSObject <UIAlertViewDelegate>

@property int width, height;
@property int totalMines;
@property int safeZones;
@property int flaged;
@property bool isFlag;
@property (strong, nonatomic) UILabel *mineLabel;
@property (strong, nonatomic) MZTimerLabel *clock;
@property (strong, nonatomic) NSMutableArray *board;
@property (strong, nonatomic) DataHandler* data;

-(id)initWithWidth:(int) width withHeight:(int) height andMines:(int) totalMines;
-(void)generateBoard;
-(UIView*)gameBoard;
-(void)revealCellAtIndex:(int)index;
-(void)setResult:(bool) result;
-(int)numberOfMinesAroundCellAtIndex:(int) index;
@end
