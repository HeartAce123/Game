//
//  PictureCell.h
//  SimpleGames
//
//  Created by LieuHaiDang on 1/2/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PictureCell : UIButton
@property int index;
@property int realIndex;
@property bool isEmpty;
@property (strong, nonatomic) UIImage* image;
-(id) initWithIndex: (int)index withImage: (UIImage*)image andX:(int)x andY:(int)y andLevel: (int)lvl andRealIndex: (int)realIndex;
@end
