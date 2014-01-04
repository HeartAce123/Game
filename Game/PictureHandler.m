//
//  PictureHandler.m
//  Game
//
//  Created by LieuHaiDang on 1/4/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import "PictureHandler.h"

@implementation PictureHandler
+(NSMutableArray*)pieceArray
{
    static NSMutableArray* array;
    if(!array)
    {
        array = [[NSMutableArray alloc] init];
    }
    return array;
}
+(UIImage*)gamePictureByImageOrDefault:(UIImage *)image
{
    static UIImage* final;
    if(!final)
    {
        final = [UIImage imageNamed:@"testImg.jpg"];
    }
    if(image != nil)
    {
        final = image;
    }
    return final;
}
+(UIImage*)resizePicture:(UIImage *)image
{
    //resize image to desired size
    CGSize size = CGSizeMake(500, 500);
    UIGraphicsBeginImageContext(size);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [image drawInRect:rect];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(void)createPieceArrayBy:(UIImage *)image andLevel:(int)lvl
{
    [[self pieceArray] removeAllObjects];
    UIImage* newImage = [self resizePicture:image];
    CGSize imageSize = [newImage size];
    for(int i = 0;i < lvl*lvl;i++)
    {
        int temp = (int)imageSize.height;
        int x = (imageSize.width / lvl)*(i%lvl);
        int y = (temp / lvl)*(i/lvl);
        CGRect area = CGRectMake(x, y, imageSize.width / lvl, imageSize.height / lvl);
        CGImageRef crop = CGImageCreateWithImageInRect([newImage CGImage], area);
        UIImage* piece = [UIImage imageWithCGImage:crop];
        CGImageRelease(crop);
        [[self pieceArray] addObject:piece];
    }
}
@end
