//
//  Score.h
//  Game
//
//  Created by LieuHaiDang on 1/16/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game;

@interface Score : NSManagedObject

@property (nonatomic, retain) NSString * level;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) Game *ofGame;

@end
