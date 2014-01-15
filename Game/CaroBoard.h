//
//  CaroBoard.h
//  Game
//
//  Created by LieuHaiDang on 1/8/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MZTimerLabel.h"
#import "Cell.h"
#import "GameState.h"
@interface CaroBoard : NSObject
@property (strong, nonatomic) NSMutableArray* cellArray;
@property (strong, nonatomic) MZTimerLabel* timer;
@property GameState gameState;
@property Seed currentPlayer;
@property int level;
- (void)cellClick: (id)sender;
- (id)initWithLevel: (int)lvl;
@end
