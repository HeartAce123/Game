//
//  DataHandler.m
//  Game
//
//  Created by LieuHaiDang on 1/15/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import "DataHandler.h"
#import "AppDelegate.h"
#import "Game.h"
#import "Score.h"
@implementation DataHandler
-(id) initWithCoder
{
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.context = appDelegate.managedObjectContext;
    self.scoreList = [[NSMutableArray alloc] init];
    return self;
}

-(void) listWithDefaultValue: (NSString*) lvl andGame: (NSString*)game
{
    Score* score = [NSEntityDescription insertNewObjectForEntityForName:@"Score" inManagedObjectContext:self.context];
    score.time = @"01:00:00";
    score.level = lvl;
    Score* score1 = [NSEntityDescription insertNewObjectForEntityForName:@"Score" inManagedObjectContext:self.context];
    score1.time = @"01:00:00";
    score1.level = lvl;
    Score* score2 = [NSEntityDescription insertNewObjectForEntityForName:@"Score" inManagedObjectContext:self.context];
    score2.time = @"01:00:00";
    score2.level = lvl;
    Game* category = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:self.context];
    category.gameName = game;
    NSSet* set = [NSSet setWithObjects:score, score1, score2,nil];
    [category addContain:set];
    NSError* error;
    [self.context save:&error];
}

-(BOOL) updateScoreList: (NSString*)score inGame:(NSString *)game withLevel:(int)lvl
{
    int compareScore = [self scoreWithIntFormat:score];
    Score* delete = [self maxScore];
    NSString* level;
    if([self scoreWithIntFormat:delete.time] > compareScore)
    {
        [self removeData:delete];
        Score* newScore = [NSEntityDescription insertNewObjectForEntityForName:@"Score" inManagedObjectContext:self.context];
        level = [[NSString alloc] init];
        switch(lvl)
        {
            case 3:
            {
                level = @"easy";
                break;
            }
            case 4:
            {
                level = @"normal";
                break;
            }
            case 5:
            {
                level = @"hard";
                break;
            }
            default:
            {
                level = @"noLevel";
            }
        }
        newScore.time = score;
        newScore.level = level;
        NSFetchRequest* request = [[NSFetchRequest alloc] init];
        NSEntityDescription* entity = [NSEntityDescription entityForName:@"Game" inManagedObjectContext:self.context];
        NSPredicate* filter = [NSPredicate predicateWithFormat:@"gameName == %@", game];
        [request setPredicate:filter];
        [request setEntity:entity];
        NSError* error;
        NSArray* result = [self.context executeFetchRequest:request error:&error];
        Game* thisGame = [result objectAtIndex:0];
        [thisGame addContainObject:newScore];
        [self.context save:&error];
        return YES;
    }
    return NO;
}

- (Score*) maxScore
{
    Score* score = (Score*)[self.scoreList objectAtIndex:0];
    for(Score* check in self.scoreList)
    {
        if([self scoreWithIntFormat:check.time] > [self scoreWithIntFormat:score.time])
            score = check;
    }
    return score;
}

-(void) removeData:(NSManagedObject *)object
{
    NSError* error;
    [self.context deleteObject:object];
    [self.context save:&error];
}

-(int) scoreWithIntFormat: (NSString*)score
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSDate* dateScore = [dateFormatter dateFromString:score];
    NSTimeInterval compareScore = [dateScore timeIntervalSince1970];
    NSInteger intScore = compareScore;
    return intScore;
}

-(void) loadScoreOfGame:(NSString *)game withLevel:(int)lvl
{
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Score" inManagedObjectContext:self.context];
    [request setEntity:entity];
    NSString* level = [[NSString alloc] init];
    switch(lvl)
    {
        case 3:
        {
            level = @"easy";
            break;
        }
        case 4:
        {
            level = @"normal";
            break;
        }
        case 5:
        {
            level = @"hard";
            break;
        }
    }
    NSPredicate* filter;
    if(lvl != 0)
        filter = [NSPredicate predicateWithFormat:@"ofGame.gameName == %@ AND level == %@", game, level];
    else
        filter = [NSPredicate predicateWithFormat:@"ofGame.gameName == %@", game];
    [request setPredicate:filter];
    NSError* error;
    [self.scoreList removeAllObjects];
    self.scoreList = (NSMutableArray*)[self.context executeFetchRequest:request error:&error];
    if([self.scoreList count] == 0)
    {
        [self listWithDefaultValue:level andGame:game];
        self.scoreList = (NSMutableArray*)[self.context executeFetchRequest:request error:&error];
    }
//    NSLog(((Score*)[self.scoreList objectAtIndex:0]).time);
//    NSLog(((Score*)[self.scoreList objectAtIndex:1]).time);
//    NSLog(((Score*)[self.scoreList objectAtIndex:2]).time);
}

@end
