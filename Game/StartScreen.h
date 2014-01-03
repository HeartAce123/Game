//
//  StartScreen.h
//  SimpleGames
//
//  Created by LieuHaiDang on 1/2/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureBoard.h"
@interface StartScreen : UIViewController
@property (strong, nonatomic) PictureBoard* game;
-(void) buttonClick: (id)sender;
@end
