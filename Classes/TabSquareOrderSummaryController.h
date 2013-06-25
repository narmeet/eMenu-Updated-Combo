//
//  TabSquareOrderSummaryController.h
//  TabSquareMenu
//
//  Created by Nikhil Kumar on 7/10/12.
//  Copyright (c) 2012 Trendsetterz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderCell.h"
#import "MBProgressHUD.h"
#import "TabSquareNewBeerScrollController.h"
#import "CustomBadge.h"

@class TabMainMenuDetailViewController;
@class TabSquareSoupViewController;
@class TabSquareMenuController;
@class TabSquareBeerDetailController;
@class TabSquareBeerController;
@class TabSquareNewBeerScrollController;


@interface TabSquareOrderSummaryController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,MBProgressHUDDelegate,UIAlertViewDelegate,UIWebViewDelegate,UIPrintInteractionControllerDelegate>
{
    MBProgressHUD *progressHud;
    int selectedItemIndex;
    NSString *placeId;
    NSString *CatId;
    int totalOrderCat;
    NSString *orderCatId;
    NSString *orderCatName;
    NSMutableArray *orderCatIdList;
    NSMutableArray *orderCatNameList;
    UITapGestureRecognizer *gestureView;
   //  TabSquareBeerDetailController *beerDetailView;
    NSString *subCatId;
    UIImage *image;
    int categoryTag;
    CGFloat custOriginY;
    UIWebView *webView;
    NSString* itemOrderId;
    NSString *itemCustomisationId;
    IBOutlet UIImageView* bgImage;
   // NSString *wholeOrderId;
    CustomBadge *summaryTotalBadge;
}

@property(assign,readwrite)int categoryTag;
@property(nonatomic,strong)TabSquareMenuController *menuView;
@property(nonatomic,strong)TabSquareSoupViewController *soupView;
@property(nonatomic,strong)TabMainMenuDetailViewController *menudetailView;
//@property(nonatomic,strong)TabSquareBeerDetailController *beerDetailView;
@property(nonatomic,strong)TabSquareNewBeerScrollController *beerDetailView;

@property(nonatomic,strong)IBOutlet UILabel *lblSplReq;
@property(nonatomic,strong)IBOutlet UILabel *summaryTitle;
@property(nonatomic,strong)IBOutlet UITableView *OrderList;
@property (nonatomic,strong)IBOutlet OrderCell *tmpCell;
@property (nonatomic,strong)IBOutlet UILabel *lblTotal;
@property (nonatomic,strong)IBOutlet UILabel *lblTotalPrice;
@property (nonatomic,strong)IBOutlet UILabel *lblGST;
@property (nonatomic,strong)IBOutlet UILabel *lblSubTotal;
@property(nonatomic,strong)IBOutlet UITextView* specialRequest;
@property(nonatomic,strong)IBOutlet UILabel *totalTitle;

@property(nonatomic,strong)IBOutlet UILabel *subTotal;
@property(nonatomic,strong)IBOutlet UILabel *grandTotal;
@property(nonatomic,strong)IBOutlet UILabel *onlyTotal;
@property(nonatomic,strong)IBOutlet UIButton *confirmButton;

@property(nonatomic,strong)NSMutableArray *sortCatId;
@property(nonatomic,strong)NSMutableArray *sortDishId;
@property(nonatomic,strong)NSMutableArray *subSortId;
@property(nonatomic,strong) NSMutableArray *DishID;
@property(nonatomic,strong) NSMutableArray *DishName;
@property(nonatomic,strong) NSMutableArray *DishPrice;
@property(nonatomic,strong) NSMutableArray *DishImage;
@property(nonatomic,strong) NSMutableArray *DishCat;
@property(nonatomic,strong) NSMutableArray *data;
@property(nonatomic,strong) NSString *salesRef;
@property(nonatomic,strong)TabSquareBeerController* beveragesBeerView2;

-(IBAction)infoClicked:(id)sender;
-(IBAction)removeClicked:(id)sender;
-(IBAction)minusClicked:(id)sender;
-(IBAction)plusClicked:(id)sender;

-(IBAction)confirmOrderClicked:(id)sender;
-(IBAction)closeClicked:(id)sender;
-(void)showRequestbox;
-(void)CalculateTotal;
-(void)filterData;
-(void)confirmOrder;
-(void)resetTheDataWhileReactivationOfFixedViewMode;///to remove the data from the ordersumarry page after changing the mode......

@end
