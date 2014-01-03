//
//  PictureCell.m
//  SimpleGames
//
//  Created by LieuHaiDang on 1/2/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import "PictureCell.h"

@implementation PictureCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            }
    return self;
}
-(id)initWithIndex:(int)index withImage:(UIImage *)image andX:(int)x andY:(int)y andLevel:(int)lvl andRealIndex:(int)realIndex
{
    self = [[PictureCell alloc] initWithFrame:CGRectMake(x, y, 300/lvl, 300/lvl)];
    self.image = image;
    [self setBackgroundImage:self.image forState:UIControlStateNormal];
    self.realIndex = realIndex;
    self.index = index;
    self.isEmpty = NO;
    return self;
}
@end
