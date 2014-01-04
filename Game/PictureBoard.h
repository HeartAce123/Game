//
//  PictureBoard.h
//  SimpleGames
//
//  Created by LieuHaiDang on 1/2/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PictureCell.h"
#import "MZTimerLabel.h"
@interface PictureBoard : NSObject <UIAlertViewDelegate>
@property (strong, nonatomic) NSMutableArray* cellArray;
@property (strong, nonatomic) MZTimerLabel* timer;
@property int level;
-(id)initWithLevel: (int)lvl;
-(void)cellClick: (id)sender;
@end
