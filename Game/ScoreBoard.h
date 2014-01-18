//
//  ScoreBoard.h
//  Minesweeper
//
//  Created by DucNM-Mac on 1/19/14.
//  Copyright (c) 2014 DucNM-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreCell.h"
#import "DataHandler.h"

@interface ScoreBoard : UIView

@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) DataHandler* dataSource;
@property (strong, nonatomic) NSMutableArray* cellArray;
-(void)loadDataOfGame: (NSString*)game andLevel: (int)lvl;
-(void)resetData;
@end
