//
//  Cell.h
//  Game
//
//  Created by LieuHaiDang on 1/8/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Seed.h"
@interface CaroCell : UIButton
@property Seed contain;
@property int index;
@property int score;
- (id)initWithIndex: (int)index andX: (int)x andY: (int)y;
- (void)cellClick: (id)sender;
@end
