//
//  PictureHandler.h
//  Game
//
//  Created by LieuHaiDang on 1/4/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureHandler : NSObject
+(NSMutableArray*) pieceArray;
+(UIImage*) gamePictureByImageOrDefault: (UIImage*) image;
+(UIImage*) resizePicture: (UIImage*)image;
+(void) createPieceArrayBy: (UIImage*)image andLevel: (int)lvl;
@end
