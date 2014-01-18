//
//  ScoreCell.h
//  Minesweeper
//
//  Created by DucNM-Mac on 1/19/14.
//  Copyright (c) 2014 DucNM-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreCell : UIView

@property int index;
@property (strong, nonatomic) NSString *score;
@property (strong, nonatomic) UILabel *indexLabel;
@property (strong, nonatomic) UILabel *scoreLabel;

-(void)setCellIndex:(int)index;
-(void)setCellScore:(NSString *)score;

@end
