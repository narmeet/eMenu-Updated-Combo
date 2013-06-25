
#import <UIKit/UIKit.h>

@interface ComboSetDishIcon : UIButton {
    
    NSString    *dishTitle;
    NSString    *dishHeader;
    NSString    *dishType;
    NSString    *preSelected;
    NSString    *isSelected;
    NSString    *dishID;
    UIImage     *dishImage;
 
    NSString    *groupId;
    NSString    *groupDishItem;
    NSString    *maxSelection;
    NSString    *groupName;
    NSString    *selectionHeader;
    
    BOOL        gradient_status;
    BOOL        paidgroup;
    BOOL        optionalgroup;

    int         groupIndex;
    
}

@property(nonatomic, assign, getter = isPaidGroup) BOOL paidgroup;
@property(nonatomic, assign, getter = isOptionalGroup) BOOL optionalgroup;

@property(nonatomic, retain) NSString *dishPrice;
@property(nonatomic, retain) NSString *pluId;
@property(nonatomic, retain) NSString *dishTitle;
@property(nonatomic, retain) NSString *dishHeader;
@property(nonatomic, retain) NSString *dishType;
@property(nonatomic, retain) NSString *preSelected;
@property(nonatomic, retain) NSString *isSelected;
@property(nonatomic, retain) NSString *dishID;
@property(nonatomic, retain) UIImage  *dishImage;
@property(nonatomic, retain) NSString *groupId;
@property(nonatomic, retain) NSString *groupDishItem;
@property(nonatomic, retain) NSString *maxSelection;
@property(nonatomic, retain) NSString *groupName;
@property(nonatomic, retain) NSString *selectionHeader;


-(void)customizeIcon;

-(void)setGroupIndex:(int)_index;
-(int)groupIndex;
-(BOOL)isOptional;
-(void)setOptional:(BOOL)_status;
-(void)setPaid:(BOOL)_status;


@end
