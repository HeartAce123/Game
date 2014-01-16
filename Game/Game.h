//
//  Game.h
//  Game
//
//  Created by LieuHaiDang on 1/16/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Score;

@interface Game : NSManagedObject

@property (nonatomic, retain) NSString * gameName;
@property (nonatomic, retain) NSSet *contain;
@end

@interface Game (CoreDataGeneratedAccessors)

- (void)addContainObject:(Score *)value;
- (void)removeContainObject:(Score *)value;
- (void)addContain:(NSSet *)values;
- (void)removeContain:(NSSet *)values;

@end
