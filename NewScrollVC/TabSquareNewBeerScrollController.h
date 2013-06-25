//
//  TabSquareNewBeerScrollController.h
//  TabSquareMenu
//
//  Created by ManojRai on 15/2/13.
//  Copyright (c) 2013 Trendsetterz. All rights reserved.
// hello hello from Sankaran

#import <UIKit/UIKit.h>
#import "PagedFlowView.h"
#import "MBProgressHUD.h"
#import "Global.h"
#import "TabSquareMenuDetailController.h"
#import "TabSquareMenuController.h"

@class TabSquareOrderSummaryController;
@class TabMainDetailView;
@class TabMainCourseMenuListViewController;
@class TabSquareBeerListController;
@class TabSquareBeerController;
@class TabSquareMenuDetailController;

@interface TabSquareNewBeerScrollController : UIViewController<PagedFlowViewDelegate,PagedFlowViewDataSource,MBProgressHUDDelegate,UITextViewDelegate,UIScrollViewDelegate>{
    
    
     id mParent;

    IBOutlet UIView *bgBlackView;
    
    MBProgressHUD *progressHud;
    int nextOrPrev;
    TabMainDetailView *currentdetailView;
    int currentIndex;
    NSString *currentCatId;
    NSString *currentSubId;
    bool currentMove;
    IBOutlet UIImageView* bggg,*bgImage;
    NSTimer* tt;
    UIImageView *imageView;
    
    
    TabSquareBeerListController *beerListView;
    int currentindex,selectedItemIndex;
    int beverageSkuIndex;
    int tempDishID;
    IBOutlet UIButton* leftArrow;
    IBOutlet UIButton* rightArrow;
    IBOutlet UIImageView* bgg;
    
    NSString *orderScreenFlag;
    
    NSString *drinkNameFromOrderSummary,*drinkDescriptionFromOrderSummary;
    
}
@property(nonatomic,strong)NSString *drinkNameFromOrderSummary;
@property(nonatomic,strong)NSString *drinkDescriptionFromOrderSummary;

@property(nonatomic,strong)NSString *orderScreenFlag;
@property(nonatomic,assign)int selectedItemIndex;
@property (nonatomic) id mParent;
@property (nonatomic, retain) UIView *bgBlackView;

@property (nonatomic, retain) IBOutlet PagedFlowView *hFlowView;
@property (nonatomic, retain) IBOutlet PagedFlowView *vFlowView;
@property (nonatomic, retain) IBOutlet UIPageControl *hPageControl;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property(nonatomic)IBOutlet UIButton *mcloseButton;


@property(nonatomic,strong) TabSquareMenuDetailController *customizationView;
@property(nonatomic,strong)IBOutlet UIView* detailImageView;
@property(nonatomic,strong)IBOutlet UILabel* drinkName;
@property(nonatomic,strong)IBOutlet UILabel* drinkDiscription;
@property(nonatomic,strong)IBOutlet UIImageView *drinkImage;
@property(nonatomic,strong)IBOutlet UITableView *beverageSkUView;
@property(nonatomic,strong)TabSquareBeerListController *beerListView;
@property(nonatomic,strong)TabSquareBeerController *beverageView;
@property(nonatomic,strong)IBOutlet UIButton* leftArrow;
@property(nonatomic,strong)IBOutlet UIButton* rightArrow;
@property(nonatomic,strong)NSMutableArray *addBeverageId;
@property(nonatomic,strong)NSMutableArray *addBeverageQunatity;
@property(nonatomic,strong)NSString* beverageCatId;
@property(nonatomic,strong)NSMutableArray *beverageSKUDetail;
@property(nonatomic,strong)NSMutableArray *beverageCustomization;
@property(nonatomic,strong)NSMutableArray *beverageCutType;
@property(nonatomic,strong)NSString *selectedIndex;
@property(nonatomic)IBOutlet UIImageView *KDishImage;

@property(nonatomic)int tempDishID;

-(IBAction)closeClicked:(id)sender;
-(void)loadBeverageData:(int)index;
-(IBAction)leftClicked:(id)sender;
-(IBAction)rightClicked:(id)sender;
-(void)setParent:(id)sender;

@end
