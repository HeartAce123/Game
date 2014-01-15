//
//  AppDelegate.h
//  Game
//
//  Created by LieuHaiDang on 1/4/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartScreen.h"
#import "PlayScreen.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UINavigationController* navController;
@property (strong, nonatomic) StartScreen* main;
@property (strong, nonatomic) PlayScreen* main2;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
