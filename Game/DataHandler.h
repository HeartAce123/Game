//
//  DataHandler.h
//  Game
//
//  Created by LieuHaiDang on 1/15/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHandler : NSObject
@property (strong, nonatomic) NSMutableArray* scoreList;
@property (strong, nonatomic) NSManagedObjectContext* context;
-(id) initWithCoder;
-(void) loadScoreOfGame: (NSString*)game withLevel: (int)lvl;
-(BOOL) updateScoreList: (NSString*)score inGame: (NSString*)game withLevel: (int)lvl;
-(NSMutableArray*) sortedScoreList;
@end
