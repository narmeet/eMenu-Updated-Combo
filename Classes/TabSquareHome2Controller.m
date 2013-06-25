//
//  TabSquareHome2Controller.m
//  TabSquareMenu
//
//  Created by Nikhil Kumar on 7/5/12.
//  Copyright (c) 2012 Trendsetterz. All rights reserved.
//

#import "TabSquareHome2Controller.h"
#import "TabSquareMenuController.h"
#import "SBJSON.h"
#import "ShareableData.h"
#import "TabSquareDBFile.h"
#import "TabSquareQuickOrder.h"

@implementation TabSquareHome2Controller
@synthesize backhomeView,menu,menuQ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)getHomeImageInDB
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);;
    NSString *libraryDirectory = [paths lastObject];
    NSString *location = [NSString stringWithFormat:@"%@/%@%@_%@.png",libraryDirectory, PRE_NAME,HOME_IMAGE2, [ShareableData appKey]];
    UIImage *img = [UIImage imageWithContentsOfFile:location];
    backhomeView.image = img;
}


-(void)updateHomeImageInDB:(NSData*)imagedata
{
    //[[TabSquareDBFile sharedDatabase]openDatabaseConnection];
    //[[TabSquareDBFile sharedDatabase]updateHomeImageRecordTable:@"2" imageData:imagedata];
   // [[TabSquareDBFile sharedDatabase]closeDatabaseConnection];
}



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //get image from DB
    [self getHomeImageInDB];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
     //DLog(@"Tab Square Home2 Controller viewDidUnload ");
    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    progressHud.delegate = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    progressHud.delegate = self;
}
-(void)viewDidAppear:(BOOL)animated{
    if ([[ShareableData sharedInstance].isQuickOrder isEqualToString:@"1"]){
        [ShareableData sharedInstance].isConfromHomePage=@"1";
        menu=[[TabSquareMenuController alloc]initWithNibName:@"TabSquareMenuController" bundle:nil];
        // menu = [[TabSquareQuickOrder alloc] initWithNibName:@"TabSquareQuickOrder" bundle:nil];
        menu.view.frame=CGRectMake(0,[UIScreen mainScreen].bounds.size.width, menu.view.frame.size.width, menu.view.frame.size.height);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        menu.view.frame=CGRectMake(0,0, menu.view.frame.size.width, menu.view.frame.size.height);
        [UIView commitAnimations];
        //  [self presentViewController:menu animated:YES completion:nil];
        [self.navigationController pushViewController:menu animated:NO];
        //[self.view addSubview:menu.view];
    }
    
}



-(IBAction)tapClicked:(id)sender
{
    [ShareableData sharedInstance].isConfromHomePage=@"1";
    menu=[[TabSquareMenuController alloc]initWithNibName:@"TabSquareMenuController" bundle:nil];
   // menu = [[TabSquareQuickOrder alloc] initWithNibName:@"TabSquareQuickOrder" bundle:nil];
   // menu.view.frame=CGRectMake(0,[UIScreen mainScreen].bounds.size.width, menu.view.frame.size.width, menu.view.frame.size.height);
  //  [UIView beginAnimations:nil context:nil];
  //  [UIView setAnimationDuration:0.5];
   // menu.view.frame=CGRectMake(0,0, menu.view.frame.size.width, menu.view.frame.size.height);
  //  [UIView commitAnimations];
     // [self presentViewController:menu animated:YES completion:nil];
    [self.navigationController pushViewController:menu animated:NO];
   // [self.view addSubview:menu.view];
    //[menu release];
    
   /* menu = [[TabSquareQuickOrder alloc] initWithNibName:@"TabSquareQuickOrder" bundle:nil];
    menu.view.frame=CGRectMake(0,[UIScreen mainScreen].bounds.size.width, menu.view.frame.size.width, menu.view.frame.size.height);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    menu.view.frame=CGRectMake(0,80, menu.view.frame.size.width, menu.view.frame.size.height);
    [UIView commitAnimations];
    [self.view addSubview:menu.view];*/
}


-(void) showIndicator
{
    UIView *progressView = [[UIView alloc]initWithFrame:CGRectMake(0,187, self.view.frame.size.width, self.view.frame.size.height)];
	progressHud= [[MBProgressHUD alloc] initWithView:progressView];
	[self.view addSubview:progressHud];
	[self.view bringSubviewToFront:progressHud];
	//progressHud.dimBackground = YES;
	progressHud.delegate = self;
    //progressHud.labelText = @"loading....";
	[progressHud showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)myTask
{
    
    
}


@end
