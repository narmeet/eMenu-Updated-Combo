
#import "ShareableData.h"
#import "TabSquareDBFile.h"
#import "LanguageControler.h"


@implementation ShareableData

@synthesize OrderItemID,OrderItemName, currentLanguage,OrderItemRate,OrderItemQuantity,categoryIdList,categoryList,SubCategoryList,AllItemData,ViewMode,TaskType;
@synthesize OrderCatId,isConfermOrder,SearchAllItemData,HomeCatId,HomeSubCatId,OrderSubCatId;
@synthesize tableData,tableStatus,swipeView;
@synthesize confirmOrder,OrderId;
@synthesize TaxNameValue,TaxList,Discount,TaxID,isDeduction,inFormat,isLogin;
@synthesize DishQuantity,DishName,DishRate,DishId;
@synthesize TDishQuantity,TDishName,TDishRate;
@synthesize assignedTable1,assignedTable2,assignedTable3,assignedTable4,isConfromHomePage,isTakeaway,Customer,performUpdateCheck;
@synthesize OrderCustomizationDetail,IsOrderCustomization,OrderBeverageContainerId,IsDBUpdated,isFeedbackDone;
@synthesize IsGetCMSData,IsViewPage,isFBLogin,OrderSpecialRequest;
@synthesize feedDishName,feedDishRating,feedDishImage,isInternetConnected,AddItemFromTakeaway,isTwitterLogin,OrderDishImage;
@synthesize IsEditOrder,tableNumber,TempOrderID,isQuickOrder,rootLoaded,salesNo,splitNo;
@synthesize serverUrl, dishTag, categoryID,bevCat,isSpecialReq, currentTable, totalFreeTables;


static ShareableData *abc;

+(ShareableData*) sharedInstance
{
    if(!abc)
    {
        abc=[[ShareableData alloc]init];
    }
    return abc;
}

-(void) allocateArray
{
    self.currentLanguage = [NSString stringWithFormat:@"%@", ENGLISH];
    self.currentTable = [NSString stringWithFormat:@"%@", DEFAULT_TABLE];
    
    isInternetConnected=FALSE;
    
    OrderItemID=[[NSMutableArray alloc]init];
    OrderItemName=[[NSMutableArray alloc]init];
    OrderItemRate=[[NSMutableArray alloc]init];
    IsOrderCustomization=[[NSMutableArray alloc]init];
    OrderItemQuantity=[[NSMutableArray alloc]init];
    OrderCustomizationDetail=[[NSMutableArray alloc]init];
    IsViewPage=[[NSMutableArray alloc]init];
    OrderCatId=[[NSMutableArray alloc]init];
    OrderSubCatId=[[NSMutableArray alloc]init];
    confirmOrder=[[NSMutableArray alloc]init];
    OrderBeverageContainerId=[[NSMutableArray alloc]init];
    categoryList=[[NSMutableArray alloc]init];
    categoryIdList=[[NSMutableArray alloc]init];
    OrderDishImage=[[NSMutableArray alloc]init];
    IsGetCMSData=[[NSMutableArray alloc]init];
    TempOrderID=[[NSMutableArray alloc]init];
    IsEditOrder=[[NSString alloc]init];
    isSpecialReq=[[NSString alloc]init];
    
    OrderSpecialRequest=[[NSMutableArray alloc]init];
    [IsGetCMSData addObject:@"0"];
    ViewMode=2;  
    isConfermOrder=FALSE;
    SubCategoryList=[[NSMutableArray alloc]init];
    AllItemData=[[NSMutableArray alloc]init];
    HomeCatId=[[NSMutableArray alloc]init];
    HomeSubCatId=[[NSMutableArray alloc]init];
    tableData=[[NSMutableArray alloc]init];
    tableStatus=[[NSMutableArray alloc]init];
    SearchAllItemData=[[NSMutableArray alloc]init];
    OrderId=[[NSString alloc]init];
    TaskType=@"1";
    isLogin=[[NSString alloc]init];
    isQuickOrder = [[NSString alloc]init];
    isFBLogin=[[NSString alloc]init];
    IsDBUpdated=[[NSMutableArray alloc]init];
    DishName=[[NSMutableArray alloc]init];
    DishId=[[NSMutableArray alloc]init];
    
    TDishName=[[NSMutableArray alloc]init];
    
    feedDishName=[[NSString alloc]init];
    feedDishRating=[[NSString alloc]init];
    feedDishImage=[[NSString alloc]init];
    DishQuantity=[[NSMutableArray alloc]init];
    TDishQuantity=[[NSMutableArray alloc]init];

    DishRate=[[NSMutableArray alloc]init];
    TDishRate=[[NSMutableArray alloc]init];
    
    TaxList=[[NSMutableArray alloc]init];;
    TaxNameValue=[[NSMutableArray alloc]init];;
    TaxID=[[NSMutableArray alloc]init];
    isDeduction=[[NSMutableArray alloc]init];
    inFormat=[[NSMutableArray alloc]init];
    tableNumber=[[NSString alloc]init];
    salesNo=[[NSString alloc]init];
    splitNo=[[NSString alloc]init];
    bevCat=[[NSString alloc]init];
    
    Discount=@"0";
    
    OrderId=@"-1";
    
    isLogin=@"0";
    isFBLogin=@"0";
    isTwitterLogin=@"0";
    IsEditOrder=@"0";
    assignedTable1=@"-1";
    assignedTable2=@"-1";
    assignedTable3=@"-1";
    assignedTable4=@"-1";
    performUpdateCheck=@"0";
    isQuickOrder=@"0";
    rootLoaded=@"0";
    
    isConfromHomePage=@"0";
    isSpecialReq=@"1";
    
    isTakeaway=@"0";
    AddItemFromTakeaway=@"0";
    Customer=@"";
    isFeedbackDone=@"0";
    categoryID=@"1";
    bevCat=@"-1";
    
}


+(NSString *)serverURL
{
    NSString *url_string = [[NSUserDefaults standardUserDefaults] valueForKey:SERVER_URL];
    
    if([url_string length] == 0) {
        url_string = [NSString stringWithFormat:@"%@", DEFAULT_URL];
    }
    
    
    return url_string;
}

+(NSString *)appKey
{
    NSString *url_string = [[NSUserDefaults standardUserDefaults] valueForKey:APP_KEY];
    
    if([url_string length] == 0) {
        url_string = [NSString stringWithFormat:@"%@", DEFAULT_KEY];
    }
    
    url_string = @"511dcaa2b99651360906914";
    
    return url_string;
}


+(BOOL)dishTagStatus
{
    BOOL value = TRUE;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults objectForKey:DISH_TAG] != nil) {
        
        value = [[NSUserDefaults standardUserDefaults] boolForKey:DISH_TAG];
    }
    else {
        value = TRUE;
    }
    
    
    return value;
}

+(BOOL)multiLanguageStatus
{
    BOOL value = TRUE;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults objectForKey:MULTILANGUAGE] != nil) {
        
        value = [[NSUserDefaults standardUserDefaults] boolForKey:MULTILANGUAGE];
    }
    else {
        value = TRUE;
    }
    
    return value;
}



+(BOOL)hasAccess:(NSString *)password level:(NSString *)access
{
    BOOL status = FALSE;
    
    NSMutableDictionary *access_dict = [[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_DICTIONARY];
    
    if(access_dict == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Error in performing operation." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
        
        return status;
    }
    
    BOOL contains_password = [[access_dict allKeys] containsObject:password];
    
    if(contains_password) {
        
        NSMutableDictionary *user_access_dict = [access_dict objectForKey:password];
        NSMutableArray *user_array_dict = user_access_dict[@"arry"];
        
        if([user_array_dict containsObject:access])
            status = TRUE;
    }
    else {
        status = FALSE;
    }
    
    
    if(!status) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Sorry, you are not an authorized user." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
    }
    
    return status;
}



+(float)discountAmount
{
    NSString *percentage = [[NSUserDefaults standardUserDefaults] valueForKey:DICSOUNT];
    
    if([percentage length] == 0) {
        percentage = [NSString stringWithFormat:@"%@", DEFAULT_DISCOUNT];
        
        return [percentage floatValue];
    }
    
    float value = 0.0;
    
    NSCharacterSet *_NumericOnly = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:percentage];
    
    if([_NumericOnly isSupersetOfSet: myStringSet])
    {
        //String entirely contains decimal numbers only.
        value = [percentage floatValue];
    }
    else {
        percentage = [NSString stringWithFormat:@"%@", DEFAULT_DISCOUNT];
        value = [percentage floatValue];
    }
    
    return value;
    
}

/*Filtering active languages from app settings*/
+(NSMutableArray *)activeLanguages
{
    NSMutableArray *flags  = [[NSMutableArray alloc] init];
    
    /*=================English========================*/
    BOOL value = TRUE;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [flags addObject:@"english_flag.png"]; // Forcely on English
    /*===================Chinese======================*/
    
    if([defaults objectForKey:@"chineselanguagekey"] != nil) {
        value = [[NSUserDefaults standardUserDefaults] boolForKey:@"chineselanguagekey"];
    }
    else {
        value = TRUE;
    }
    
    if(value) {
        [flags addObject:@"china_flag.png"];
    }
    value = TRUE;
    
    /*================Japanese=========================*/
    
    if([defaults objectForKey:@"japaneselanguagekey"] != nil) {
        value = [[NSUserDefaults standardUserDefaults] boolForKey:@"japaneselanguagekey"];
    }
    else {
        value = TRUE;
    }
    
    if(value) {
        [flags addObject:@"japan_flag.png"];
    }
    value = TRUE;
    
    /*===================Korean======================*/
    
    if([defaults objectForKey:@"koreanlanguagekey"] != nil) {
        value = [[NSUserDefaults standardUserDefaults] boolForKey:@"koreanlanguagekey"];
    }
    else {
        value = TRUE;
    }
    
    if(value) {
        [flags addObject:@"korea_flag.png"];
    }
    value = TRUE;
    
    /*===================Indonesian======================*/
    
    if([defaults objectForKey:@"indonesianlanguagekey"] != nil) {
        value = [[NSUserDefaults standardUserDefaults] boolForKey:@"indonesianlanguagekey"];
    }
    else {
        value = TRUE;
    }
    
    if(value) {
        [flags addObject:@"indonesia_flag.png"];
    }
    value = TRUE;
    
    /*===================French======================*/
    
    if([defaults objectForKey:@"frenchlanguagekey"] != nil) {
        value = [[NSUserDefaults standardUserDefaults] boolForKey:@"frenchlanguagekey"];
    }
    else {
        value = TRUE;
    }
    
    if(value) {
        [flags addObject:@"france_flag.png"];
    }
    
    
    return flags;
}




+(BOOL)bestSellersON
{
    return TRUE;
}

/*=========These settings are for multilanguage==========*/
-(void)saveBestsellers
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:BEST_SELLER_DATA] != nil)
        return;
    
    /*=======This comes from CMS========*/
    NSString *key_in_db = @"Bestseller";
    NSMutableDictionary *dict = [[TabSquareDBFile sharedDatabase] bestSellerNames:key_in_db];
    if(dict != nil){
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:BEST_SELLER_DATA];
    }
    else{
        //[self saveBestsellers];
      //  [self performSelector:@selector(saveBestsellers:) withObject:nil afterDelay:0.8];
        //[self performSelector:@selector(saveBestsellers) withObject:nil afterDelay:0.3];

    }
}


-(NSString *)activeBestsellerName
{
    NSMutableDictionary *seller_dict = [[NSUserDefaults standardUserDefaults] objectForKey:BEST_SELLER_DATA];
    
    NSString *search_key = @"Bestseller";
    
    if(seller_dict != nil) {
        search_key = [seller_dict objectForKey:[LanguageControler activeLanguage:@"name"]];
        
        if([search_key length] == 0)
            search_key = @"Bestseller";
    }
    
    return search_key;
    
}

+(void)showAlert:(NSString *)title message:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}



@end