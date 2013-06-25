//
//  TabSquareLastOrderedViewController.h
//  TabSquareMenu
//
//  Created by Nikhil Kumar on 8/21/12.
//  Copyright (c) 2012 Trendsetterz. All rights reserved.
//
#import "TabSquareNewBeerScrollController.h"

@class TabSquareMenuController;
@class TabMainMenuDetailViewController;
@class TabSquareMenuDetailController;
@class TabSquareBeerDetailController;
@class TabSquareNewBeerScrollController;

@interface TabSquareLastOrderedViewController : UIViewController
@property(nonatomic,strong)TabSquareBeerController* beveragesBeerView2;
@property(nonatomic,strong)TabSquareNewBeerScrollController *beerDetailView;

@property(nonatomic,strong)NSMutableDictionary *resultFromDB;
@property(nonatomic,strong)TabSquareMenuDetailController *customizationView;
@property(nonatomic,strong)TabMainMenuDetailViewController *itemDetailView;
@property(nonatomic,strong)TabSquareMenuController *menuView;
//@property(nonatomic,strong)TabSquareBeerDetailController *beerDetailView;
@property(nonatomic,strong)IBOutlet UITableView *lastOrderedView;
@property(nonatomic,strong)NSMutableArray *lastOrderedData;
@property(nonatomic,strong)NSMutableArray *lastOrderedId;
@property(nonatomic,strong)NSMutableArray *lastOrderedRating;
@property(nonatomic,strong)NSString *DishID;
@property(nonatomic,strong)NSString *DishName;
@property(nonatomic,strong)NSString *DishPrice;
@property(nonatomic,strong)NSString *DishDescription;
@property(nonatomic,strong)NSString *DishCatId;
@property(nonatomic,strong)UIImage *DishImage;
@property(nonatomic,strong)NSMutableArray *DishCustomization;
@property(nonatomic,strong)NSString* DishSubCatId;
@property(nonatomic,strong)NSString *custType;
@property(nonatomic,strong)NSString *fromCheckout;




-(void)loadlastOrdereddata;

-(IBAction)logOutClicked:(id)sender;


@end
