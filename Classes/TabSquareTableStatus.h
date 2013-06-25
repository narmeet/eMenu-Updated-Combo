//
//  TabSquareTableStatus.h
//  TabSquareMenu
//
//  Created by Nikhil Kumar on 8/9/12.
//  Copyright (c) 2012 Trendsetterz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface TabSquareTableStatus : UIViewController<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,UIAlertViewDelegate>
{
    MBProgressHUD *progressHud;
    
    int taskType;
    IBOutlet UIButton* voidTable;
    IBOutlet UIImageView *bgImage;
}

@property(nonatomic,strong)IBOutlet UILabel *noOfGuest;
@property(nonatomic,strong)IBOutlet UILabel *guestName;
@property(nonatomic,strong)IBOutlet UILabel *guestlastVisit;
@property(nonatomic,strong)IBOutlet UILabel *guestMonthVisit;
@property(nonatomic,strong)IBOutlet UILabel *timeAssigned;
@property(nonatomic,strong)IBOutlet UILabel *timelastOrder;

@property(nonatomic,strong)IBOutlet UITableView *ReportSummaryTable;


@property(nonatomic,strong)NSString *tableNumber;
@property(nonatomic,strong)NSString *salesNo;
@property(nonatomic,strong)IBOutlet UILabel *lblTableNumber;

@property(nonatomic,strong)IBOutlet UIView *v1;

-(IBAction)discountClicked:(id)sender;
-(IBAction)editOrderClicked:(id)sender;
-(IBAction)checkOutClicked:(id)sender;
-(IBAction)voidTableNow:(id)sender;
-(IBAction)previewBill:(id)sender;

@end
