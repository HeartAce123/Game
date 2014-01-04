//
//  StartScreen.m
//  SimpleGames
//
//  Created by LieuHaiDang on 1/2/14.
//  Copyright (c) 2014 LieuHaiDang. All rights reserved.
//

#import "StartScreen.h"
#import "PictureBoard.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "PictureHandler.h"
@interface StartScreen ()

@end

@implementation StartScreen
UIButton* start;
UIButton* level;
UIButton* chooser;
UIImageView* imgview;
int lvl = 1;
bool isIntialize = false;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initMenu];
}
-(void) initMenu
{
    start = [[UIButton alloc] initWithFrame:CGRectMake(20, 450, 100, 30)];
    start.tag = 0;
    level = [[UIButton alloc] initWithFrame:CGRectMake(170, 450, 150, 30)];
    level.tag = 1;
    chooser = [[UIButton alloc] initWithFrame:CGRectMake(10, 480, 170, 30)];
    chooser.tag = 2;
    imgview = [[UIImageView alloc] initWithFrame:CGRectMake(180, 480, 50, 50)];
    imgview.image = [PictureHandler gamePictureByImageOrDefault:nil];
    [start setTitle:@"New Game" forState:UIControlStateNormal];
    [start setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [start setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [level setTitle:@"Level: Normal" forState:UIControlStateNormal];
    [level setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [level setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [chooser setTitle:@"Choose picture" forState:UIControlStateNormal];
    [chooser setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [chooser setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [level addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [start addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [chooser addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];
    [self.view addSubview:level];
    [self.view addSubview:chooser];
    [self.view addSubview:imgview];
}
-(void) buttonClick: (id)sender
{
    UIButton* button = (UIButton*) sender;
    switch(button.tag)
    {
        case 0:
        {
            if(isIntialize)
            {
                for(PictureCell* cell in self.game.cellArray)
                {
                    [cell removeFromSuperview];
                }
                [self.game.cellArray removeAllObjects];
                [self.game.timer removeFromSuperview];
            }
            self.game = [[PictureBoard alloc] initWithLevel:lvl + 3];
            for(PictureCell* cell in self.game.cellArray)
            {
                [self.view addSubview:cell];
            }
            [self.view addSubview:self.game.timer];
            isIntialize = true;
            [self.game.timer start];
            break;
        }
        case 1:
        {
            lvl++;
            lvl = lvl % 3;
            switch (lvl)
            {
                case 1:
                {
                    [button setTitle:@"Level: Normal" forState:UIControlStateNormal];
                    break;
                }
                case 2:
                {
                    [button setTitle:@"Level: Hard" forState:UIControlStateNormal];
                    break;
                }
                case 0:
                {
                    [button setTitle:@"Level: Easy" forState:UIControlStateNormal];
                    break;
                }
            }
            break;
        }
        case 2:
        {
            UIImagePickerController* pickerController = [[UIImagePickerController alloc] init];
            pickerController.delegate = self;
            pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            pickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*) kUTTypeImage, nil];
            [self presentViewController:pickerController animated:YES completion:^{
                //code
            }];

            break;
        }
    }
}
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:(NSString*)kUTTypeImage])
    {
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [PictureHandler gamePictureByImageOrDefault:image];
        imgview.image = image;
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        //code
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
