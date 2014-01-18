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
#import "KHFlatButton.h"
@interface StartScreen ()

@end

@implementation StartScreen
UIButton* start;
UIButton* level;
UIButton* chooser;
UIImageView* imgview;
UIImageView* view;
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
    [self initGame];
    [self.view setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:150.0/255.0 alpha:1.0]];
    [[self.navigationController navigationBar] setBarTintColor:[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:150.0/255.0 alpha:1.0]];
    view = [[UIImageView alloc] initWithFrame:CGRectMake(self.board.frame.origin.x, self.board.frame.origin.y, self.board.frame.size.width, self.board.frame.size.height)];
    view.image = [PictureHandler gamePictureByImageOrDefault:nil];
    start = [KHFlatButton buttonWithFrame:CGRectMake(self.board.frame.origin.x, self.board.frame.origin.y + self.board.frame.size.height + 30, 130, 40) withTitle:@"New Game" backgroundColor:[UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0]];
    //start = [[UIButton alloc] initWithFrame:CGRectMake(self.board.frame.origin.x, self.board.frame.origin.y + self.board.frame.size.height + 30, 130, 30)];
    //[start setBackgroundColor:[UIColor colorWithRed:120.0/255 green:190.0/255 blue:50.0/255 alpha:1.0]];
    start.tag = 0;
    level = [KHFlatButton buttonWithFrame:CGRectMake(self.board.frame.origin.x + self.board.frame.size.width - 130, self.board.frame.origin.y  + self.board.frame.size.height + 30, 130, 40) withTitle:@"Normal" backgroundColor:[UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0]];
    //level = [[UIButton alloc] initWithFrame:CGRectMake(self.board.frame.origin.x + self.board.frame.size.width - 130, self.board.frame.origin.y  + self.board.frame.size.height + 30, 130, 30)];
    //[level setBackgroundColor:[UIColor colorWithRed:120.0/255 green:190.0/255 blue:50.0/255 alpha:1.0]];
    level.tag = 1;
    chooser = [KHFlatButton buttonWithFrame:CGRectMake(start.frame.origin.x, start.frame.origin.y + start.frame.size.height + 10, 130, 40) withTitle:@"Picture" backgroundColor:[UIColor colorWithRed:120.0/255.0 green:190.0/255.0 blue:50.0/255.0 alpha:1.0]];
    //chooser = [[UIButton alloc] initWithFrame:CGRectMake(start.frame.origin.x, start.frame.origin.y + start.frame.size.height + 10, 130, 30)];
    //[chooser setBackgroundColor:[UIColor colorWithRed:120.0/255 green:190.0/255 blue:50.0/255 alpha:1.0]];
    chooser.tag = 2;
    imgview = [[UIImageView alloc] initWithFrame:CGRectMake(level.frame.origin.x, chooser.frame.origin.y, 50, 50)];
    imgview.image = [PictureHandler gamePictureByImageOrDefault:nil];
    [imgview setUserInteractionEnabled:YES];
    UILongPressGestureRecognizer* recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(holdAction:)];
    recognizer.minimumPressDuration = 0.01;
    [imgview addGestureRecognizer:recognizer];
    //[start setTitle:@"New Game" forState:UIControlStateNormal];
    //[start setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    //[level setTitle:@"Normal" forState:UIControlStateNormal];
    //[level setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    //[chooser setTitle:@"Picture" forState:UIControlStateNormal];
    //[chooser setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [level addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [start addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [chooser addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];
    [self.view addSubview:level];
    [self.view addSubview:chooser];
    [self.view addSubview:imgview];
}
-(void) holdAction:(UILongPressGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateBegan)
    {
        [self.view addSubview:view];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        [view removeFromSuperview];
    }
}
-(void) clearScreen
{
    [self.board removeFromSuperview];
    [self.game.cellArray removeAllObjects];
    [self.game.timer removeFromSuperview];
}
-(void) initGame
{
    if(isIntialize)
    {
        [self clearScreen];
    }
    self.game = [[PictureBoard alloc] initWithLevel:lvl + 3];
    self.board = [[UIView alloc] init];
    self.board = [self.game boardGame];
    self.board.center = [self.view convertPoint:self.view.center fromView:self.view];
    self.board.frame = CGRectMake(self.board.frame.origin.x, 120, self.board.frame.size.width, self.board.frame.size.height);
    self.game.timer.center = [self.view convertPoint:self.view.center fromView:self.view];
    self.game.timer.frame = CGRectMake(self.game.timer.frame.origin.x,self.board.frame.origin.y - 40 , self.game.timer.frame.size.width, self.game.timer.frame.size.height);
    [self.view addSubview:self.board];
    [self.view addSubview:self.game.timer];
    isIntialize = true;
    view.frame = CGRectMake(self.board.frame.origin.x, self.board.frame.origin.y, self.board.frame.size.width, self.board.frame.size.height);
    [self.game.timer start];
}
-(void) buttonClick: (id)sender
{
    UIButton* button = (UIButton*) sender;
    switch(button.tag)
    {
        case 0:
        {
            [self initGame];
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
                    [button setTitle:@"Normal" forState:UIControlStateNormal];
                    break;
                }
                case 2:
                {
                    [button setTitle:@"Hard" forState:UIControlStateNormal];
                    break;
                }
                case 0:
                {
                    [button setTitle:@"Easy" forState:UIControlStateNormal];
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
        view.image = image;
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        [self initGame];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
