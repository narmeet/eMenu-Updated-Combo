//
//  TabSquareSoupViewController.h
//  TabSquareMenu
//
//  Created by Nikhil Kumar on 7/10/12.
//  Copyright (c) 2012 Trendsetterz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabSquareMenuDetailController;
@class TabSquareOrderSummaryController;
@class TabSquareMenuController;

@interface TabSquareSoupViewController : UIViewController
{
    IBOutlet UIImageView* bgImage;

    
}
@property(nonatomic,strong)TabSquareMenuController *menuView;
@property(nonatomic,strong)TabSquareOrderSummaryController *orderSummary;
@property(nonatomic,strong)IBOutlet UIView *tomatoSoup;
@property(nonatomic,strong)IBOutlet UIView *chickenSoup;
@property(nonatomic,strong)TabSquareMenuDetailController *menuDetail;
@property(nonatomic,strong)IBOutlet UIImageView* DishImage;
@property(nonatomic,strong)IBOutlet UILabel* catMenuLabel;
@property(nonatomic,strong)IBOutlet UILabel* lblheading ;
@property(nonatomic,strong)NSString* DishCatId;
@property(nonatomic,strong)IBOutlet UILabel* DishName1;
@property(nonatomic,strong)IBOutlet UILabel* DishName2;
@property(nonatomic,strong)IBOutlet UILabel* DishPrice1;
@property(nonatomic,strong)IBOutlet UILabel* DishPrice2;
@property(nonatomic,strong)IBOutlet UILabel* DishQuantity1;
@property(nonatomic,strong)IBOutlet UILabel* DishQuantity2;
@property(nonatomic,strong)IBOutlet UIButton* goToMenuBtn;
-(IBAction)addClicked:(id)sender;
-(IBAction)skipClicked:(id)sender;

-(IBAction)addTotatoSoup;
-(IBAction)minusTotatoSoup;
-(IBAction)addChickenSoup;
-(IBAction)minusChickenSoup;
-(IBAction)menuClicked:(id)sender;
@end
