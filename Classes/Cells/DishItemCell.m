
#import "DishItemCell.h"
#import "ShareableData.h"

#define FONT        [UIFont fontWithName:@"Century Gothic" size:19]
#define FONT_NAME   @"Century Gothic"

@implementation DishItemCell

@synthesize cellBackgroundImage;

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    lblDiscription.backgroundColor = [UIColor clearColor];
    lblDishName.backgroundColor = [UIColor clearColor];
    lblPrice.backgroundColor = [UIColor clearColor];
    
}


-(void)setLabelColor:(UILabel *)lbl
{
    NSMutableDictionary *fontDictionary = [[NSUserDefaults standardUserDefaults] valueForKey:FONT_DICTIONARY];
    
    if(fontDictionary != nil) {
        
        NSMutableDictionary *itemFont = [fontDictionary objectForKey:@"Item"];
        
        NSString *colors = [NSString stringWithFormat:@"%@", [itemFont objectForKey:@"color"]];
        NSArray *arr = [colors componentsSeparatedByString:@","];
        float _red   = [arr[0] floatValue];
        float _green = [arr[1] floatValue];
        float _blue  = [arr[2] floatValue];
        
      //  UIColor *fontColor = [UIColor whiteColor];//[UIColor colorWithRed:_red/255.0 green:_green/255.0 blue:_blue/255.0 alpha:1.0];
        
        UIColor *fontColor =[UIColor blackColor];// [UIColor colorWithRed:223/255.0 green:209/255.0 blue:196/255.0 alpha:1.0];

        [lbl setTextColor:fontColor];
    }
    else {
      //  [lbl setTextColor:[UIColor whiteColor]];//[UIColor blackColor]];
        [lbl setTextColor:[UIColor whiteColor]];
    }

}

-(void)setPrice:(NSString *)newPrice
{
    [super setPrice:newPrice];
    lblPrice.text=newPrice;
//    if([newPrice substringFromIndex:1].intValue>0){
//        lblPrice.hidden=NO;
//    }else{
//        lblPrice.hidden=YES;
//    }
    //DLog(@"FONT FAMILIES\n%@",[UIFont familyNames]);
     lblPrice.font=FONT;
    
    [self setLabelColor:lblPrice];
    
}

-(void)setDishName:(NSString *)newDishName
{
    [super setDishName:newDishName];
    lblDishName.text=newDishName;
    lblDishName.font=[UIFont fontWithName:FONT_NAME size:21];
    
    [self setLabelColor:lblDishName];
}

-(void)setDiscription:(NSString *)newDiscription
{
    [super setDiscription:newDiscription];
    lblDiscription.text=newDiscription;
    lblDiscription.hidden=YES;
    lblDiscription.font=[UIFont fontWithName:@"Copperplate-Light" size:16];
}

-(void)setBtnTag:(NSString *)newbtnTag
{
    int tag=[newbtnTag intValue];
    if(tag==-1)
    {
        b1.hidden=YES;
    }
    else
    {
        b1.hidden=NO;
    }
    b1.tag=tag;
}

-(void)setBtnTagInfo1:(NSString *)newbtnTagInfo1
{
    //int tag=[newbtnTagInfo1 intValue];
    ItemBtn.tag=newbtnTagInfo1.intValue;
}

-(void)setBtnTagInfo:(NSString *)newbtnTagInfo
{
    int tag=[newbtnTagInfo intValue];
    b2.tag=tag;
    [self setBtnTagInfo1:newbtnTagInfo];
}


@end
