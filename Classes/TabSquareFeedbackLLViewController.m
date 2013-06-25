//
//  TabSquareFeedbackLLViewController.m
//  TabSquareMenu
//

#import "TabSquareFeedbackLLViewController.h"
#import "ShareableData.h"
#import "FacebookViewC.h"
#import "SA_OAuthTwitterEngine.h"
#import "TabSquareTwitterController.h"
#import "TabFeedbackViewController.h"
#import "TabSquareLastOrderedViewController.h"
#import "TabSquareFriendListController.h"
#import "OAuthTwitterDemoiPadViewController.h"
#import "TabTwitterFollowerListControllerViewController.h"
#import "TabMainCourseMenuListViewController.h"
#import "TabSquareMenuController.h"
#import "Utils.h"

#define kOAuthConsumerKey				@"ZNdmXpbFLA5Sl70a9UEA"		//REPLACE ME
#define kOAuthConsumerSecret			@"AzgVnTgGSIg8JWrNHg4yoiUoLq9AcP42Gn2i4To80"		//REPLACE ME

@interface TabSquareFeedbackLLViewController () <SA_OAuthTwitterControllerDelegate,MBProgressHUDDelegate> {
    SA_OAuthTwitterEngine *_engine;
    SA_OAuthTwitterController *twitcontroller;
    MBProgressHUD *progressHud;
    int taskType;
    int twiterTask;
    IBOutlet UIImageView* bgImage;
}

@end

@implementation TabSquareFeedbackLLViewController

@synthesize txtLogin,txtPassword;
@synthesize _engine;
@synthesize lastOrderedView,objFacebookViewC;
@synthesize menuView;
@synthesize fbfriendView,loggedInUserData,delegate,twitfollowerView;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.frame=CGRectMake(13, 160, self.view.frame.size.width, self.view.frame.size.height);
        // Custom initialization
    }
    return self;
}

-(void)createFacebookView {
	objFacebookViewC = [[FacebookViewC alloc] init];
    objFacebookViewC.favouriteView=self;
	objFacebookViewC.loginDelegate1 = self;
}

-(void)viewWillAppear:(BOOL)animated{
    
//    NSString *img_name1 = [NSString stringWithFormat:@"%@%@_%@", PRE_NAME, POPUP_IMAGE,[ShareableData appKey]];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);;
//    NSString *libraryDirectory = [paths lastObject];
//    NSString *location = [NSString stringWithFormat:@"%@/%@%@",libraryDirectory,img_name1,@".png"];
//    
//    UIImage *img1 = [UIImage imageWithContentsOfFile:location];
//    
//    bgImage.image = img1;
    
    NSLog(@"View will appear in FeedBackLLView View Controller");
}
- (void)viewDidLoad
{
    //DLog(@"Tab Square Favorite Controller");
    [self createFacebookView];
    lastOrderedView=[[TabSquareLastOrderedViewController alloc]initWithNibName:@"TabSquareLastOrderedViewController" bundle:nil];
    lastOrderedView.fromCheckout = @"1";
    fbfriendView=[[TabSquareFriendListController alloc]initWithNibName:@"TabSquareFriendListController" bundle:nil];
    fbfriendView.fromCheckout = @"1";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    taskType=0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    // DLog(@"Tab Square Favorite Controller viewDidUnload ");
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

-(IBAction)RegisterButtonClick:(id)sender
{
    [txtLogin resignFirstResponder];
    [txtPassword resignFirstResponder];
    
    NSString *uname = [txtLogin.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *upass = [txtPassword.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([uname isEqualToString:@""]||[upass isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Tabsquare ID or Password Field are empty!!!!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else
    {
        taskType=1;
        [self showIndicator];
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    NSUInteger tapCount = [touch tapCount];
    //CGPoint location = [touch locationInView:self.view];
    
    switch (tapCount)
    {
        case 1:
        {
            [txtLogin resignFirstResponder];
            [txtPassword resignFirstResponder];
        }
            break;
    }
}

-(IBAction)facebookLoginBtnClicked
{
	[txtLogin resignFirstResponder];
    [txtPassword resignFirstResponder];
    if([[ShareableData sharedInstance].isFBLogin isEqualToString:@"0"])
    {
        [self fbLogout];
        [objFacebookViewC login];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message: @"You have already logged in to facebook" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
   	
}

- (void) clearCredentials
{
    [self._engine setClearsCookies:YES];
    [self._engine clearAccessToken];
    
}

-(void)fbLogout
{
    NSUserDefaults *userPref =  [NSUserDefaults standardUserDefaults];
    [userPref synchronize];
    
    [self clearCredentials];
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        NSString* domainName = [cookie domain];
        NSRange domainRange = [domainName rangeOfString:@"facebook"];
        if(domainRange.length > 0)
        {
            [storage deleteCookie:cookie];
        }
        
    }
}



- (void) logout
{
    
    NSUserDefaults *userPref =  [NSUserDefaults standardUserDefaults];
    [userPref synchronize];
    
    [self clearCredentials];
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        NSString* domainName = [cookie domain];
        NSRange domainRange = [domainName rangeOfString:@"twitter"];
        if(domainRange.length > 0)
        {
            [storage deleteCookie:cookie];
        }
        
    }
}



-(IBAction)twitterBtnClicked:(id)sender
{
    [txtLogin resignFirstResponder];
    [txtPassword resignFirstResponder];
    
    // Twitter Initialization / Login Code Goes Here
    if(!_engine){
        _engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
        _engine.consumerKey    = kOAuthConsumerKey;
        _engine.consumerSecret = kOAuthConsumerSecret;
    }
    
    [self logout];
    
    if(![_engine isAuthorized])
    {
        twitcontroller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:_engine delegate:self];
        twitcontroller.favouriteView=self;
        if (twitcontroller)
        {
            twiterTask=1;
            [self.navigationController pushViewController:twitcontroller animated: YES];
            //[self.view addSubview:controller.view];
        }
    }
    
}



-(void)UserAuthentication
{
    NSString *tb=@"-1";
    if(![[ShareableData sharedInstance].assignedTable1 isEqualToString:@"-1"])
        tb=[ShareableData sharedInstance].assignedTable1;
    else if(![[ShareableData sharedInstance].assignedTable2 isEqualToString:@"-1"])
        tb=[ShareableData sharedInstance].assignedTable3;
    else if(![[ShareableData sharedInstance].assignedTable3 isEqualToString:@"-1"])
        tb=[ShareableData sharedInstance].assignedTable3;
    else if(![[ShareableData sharedInstance].assignedTable4 isEqualToString:@"-1"])
        tb=[ShareableData sharedInstance].assignedTable4;
    
    NSString *post =[NSString stringWithFormat:@"table_id=%@&email=%@&password=%@&key=%@",tb,txtLogin.text,txtPassword.text, [ShareableData appKey]];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *url_string = [NSString stringWithFormat:@"%@/webs/login", [ShareableData serverURL]];
    [request setURL:[NSURL URLWithString:url_string]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *uData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:uData encoding:NSUTF8StringEncoding];
    DLog(@"Login Data :%@",data);
    
    
    if([data intValue]==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Login Failed!!!!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        [ShareableData sharedInstance].isLogin=@"0";
        
        txtLogin.text=@"";
        txtPassword.text=@"";
    }
    else
    {
       // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Login Successful!!!!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
      //  [alert show];
        [ShareableData sharedInstance].isLogin=data;
        [ShareableData sharedInstance].Customer=txtLogin.text;
        [self updateFeedback:data order_id:[ShareableData sharedInstance].OrderId];
        [self updateFeedbackAboutDish:data order_id:[ShareableData sharedInstance].OrderId];
        
        UIAlertView *alert2=[[UIAlertView alloc]initWithTitle:@"Thank You" message:@"Your Feedback has been submitted and linked with your account." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert2 show];
      //  [ShareableData sharedInstance].isLogin = @"0";
      //  [ShareableData sharedInstance].Customer = @"0";
    //    [ShareableData sharedInstance].isFBLogin = @"0";
      //  [ShareableData sharedInstance].isTwitterLogin = @"0";
        lastOrderedView.view.frame=CGRectMake(-10, 0, lastOrderedView.view.frame.size.width, lastOrderedView.view.frame.size.height);
        lastOrderedView.fromCheckout = @"1";
        [self.view addSubview:lastOrderedView.view];
       [lastOrderedView loadlastOrdereddata];
       [lastOrderedView.lastOrderedView reloadData];
       // [self.view removeFromSuperview];
        
        txtLogin.text=@"";
        txtPassword.text=@"";
    }
}
-(void)updateFeedback:(NSString*)cid order_id:(NSString*)order_id
{
    //NSString *Key=@"kinara123";
    
    NSString *post =[NSString stringWithFormat:@"key=%@&customer_id=%@&order_id=%@", [ShareableData appKey],cid,order_id];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *url_string = [NSString stringWithFormat:@"%@/webs/update_feedback", [ShareableData serverURL]];
    [request setURL:[NSURL URLWithString:url_string]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *uData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:uData encoding:NSUTF8StringEncoding];
    
    DLog(@"Result : %@",data);
}
-(void)updateFeedbackAboutDish:(NSString*)email1 order_id:(NSString*)order_id1
{
    
 //   DLog(@"ID ,NAME,RATING: %@%@%@",dish_id,dish_name1,rating1);
    
    
    NSString *post =[NSString stringWithFormat:@"email=%@&order_id=%@&key=%@",email1,order_id1, [ShareableData appKey]];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *url_string = [NSString stringWithFormat:@"%@/webs/update_dish_feedback", [ShareableData serverURL]];
    [request setURL:[NSURL URLWithString:url_string]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *uData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:uData encoding:NSUTF8StringEncoding];
    
    DLog(@"Result : %@",data);
}
-(void)loadFBfriendList
{
    fbfriendView.view.frame=CGRectMake(-10, 0, fbfriendView.view.frame.size.width, fbfriendView.view.frame.size.height);
    fbfriendView.fromCheckout = @"1";
    [self.view addSubview:fbfriendView.view];
    [fbfriendView.friendlistView reloadData];
}


-(void)UserRegistration:(NSString*)Mode emailid:(NSString*)emailid password:(NSString*)pass  tableId:(NSString*)tableId name:(NSString*)name
{
    NSString *post =[NSString stringWithFormat:@"email=%@&pass=%@&mode=%@&table_id=%@&name=%@&key=%@",emailid,pass,Mode,tableId,name, [ShareableData appKey]];
    DLog(@"Table :%@",tableId);
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *url_string = [NSString stringWithFormat:@"%@/webs/add_new_login", [ShareableData serverURL]];
    [request setURL:[NSURL URLWithString:url_string]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *uData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:uData encoding:NSUTF8StringEncoding];
    DLog(@"Login Data :%@",data);
    
    if([data intValue]==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Already Registered!!!!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else
    {
        if([[ShareableData sharedInstance].isFBLogin isEqualToString:@"0"]&&[[ShareableData sharedInstance].isTwitterLogin isEqualToString:@"0"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Registration Successful!!!!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            
            txtLogin.text=@"";
            txtPassword.text=@"";
            [ShareableData sharedInstance].isLogin=data;
            [ShareableData sharedInstance].Customer=txtLogin.text;
            
            lastOrderedView.view.frame=CGRectMake(-10, 0, lastOrderedView.view.frame.size.width, lastOrderedView.view.frame.size.height);
            [self.view addSubview:lastOrderedView.view];
            [lastOrderedView loadlastOrdereddata];
            [lastOrderedView.lastOrderedView reloadData];
            
        }
        else if ([[ShareableData sharedInstance].isFBLogin isEqualToString:@"1"])
        {
            [ShareableData sharedInstance].isLogin=data;
            [ShareableData sharedInstance].Customer=emailid;
        }
        else if ([[ShareableData sharedInstance].isTwitterLogin isEqualToString:@"1"])
        {
            [ShareableData sharedInstance].isLogin=data;
            [ShareableData sharedInstance].Customer=emailid;
        }
        
    }
}


- (IBAction)LoginButtonClick:(id)sender
{
    [txtLogin resignFirstResponder];
    [txtPassword resignFirstResponder];
    NSString *uname = [txtLogin.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *upass = [txtLogin.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([uname isEqualToString:@""]||[upass isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Tabsquare ID or Password Field are empty!!!!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else
    {
        taskType=2;
        [self showIndicator];
    }
}


-(void) showIndicator
{
   /* UIView *progressView = [[[UIView alloc]initWithFrame:CGRectMake(0,187, self.view.frame.size.width, self.view.frame.size.height)]autorelease];
	progressHud= [[MBProgressHUD alloc] initWithView:progressView];
	[self.view addSubview:progressHud];
	[self.view bringSubviewToFront:progressHud];
	//progressHud.dimBackground = YES;
	progressHud.delegate = self;
    //progressHud.labelText = @"loading....";
	[progressHud showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];*/
    [self myTask];
}

-(void)myTask
{
    if(taskType==1)
    {
        [self UserRegistration:@"normal" emailid:txtLogin.text password:txtPassword.text tableId:@"0" name:txtLogin.text];
    }
    else if(taskType==2)
    {
        [self UserAuthentication];
    }
}

- (void) viewDidAppear:(BOOL)animated
{
//    if(twiterTask==2)
//    {
//        twiterTask=3;
//        self.view.frame=CGRectMake(13, 160, 741, 720);
//        [self createtwitterView];
//        [twitfollowerView defaultServicesCalling];
//    }
}

- (void) getAllFollowers:(NSString *)cursor
{
    NSDictionary *userInfoDic = loggedInUserData;
    BOOL isAlertShouldShow = NO;
    if (userInfoDic)
    {
        NSString *userId = userInfoDic[@"id_str"];
        if(userId.length > 0)
            [self._engine getAllFollowers:userId pageNumber:cursor];
        else
            isAlertShouldShow = YES;
    }
    else
        isAlertShouldShow = YES;
    
    if(isAlertShouldShow)
    {
        //[Utils showToast:[TwtBoothAppDelegate getDelegate].window withText:@"Error, First reload the New Page"];
    }
}

- (void) getUsersInformation:(NSString *)usersId
{
    [self._engine getUsersInformation:usersId];
}

- (void) userInfo
{
    [self._engine checkUserCredentials];
    
}


//=============================================================================================================================
#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username
{
    NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

- (void) responseOfTwt:(id) response requestIdentifier:(NSString *)identifier
{
    [twitfollowerView twitterResponse:response];
}

- (void) parsingTwitterAPIError
{
    [twitfollowerView twitterServiceFailed];
}

-(void)createtwitterView
{
    // twitfollowerView.view.frame=CGRectMake(-10, 0, twitfollowerView.view.frame.size.width, twitfollowerView.view.frame.size.height);
    twitfollowerView.favouriteView=self;
    twitfollowerView.view.hidden=NO;
    [self.view addSubview:twitfollowerView.view];
}

//=============================================================================================================================
#pragma mark SA_OAuthTwitterControllerDelegate
- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username
{
    if(twiterTask==1)
    {
        twiterTask=2;
        [ShareableData sharedInstance].isTwitterLogin =@"1";
        //[self UserRegistration:@"twitter" emailid:username password:@"twit12" tableId:[ShareableData sharedInstance].assignedTable1];
    }
    
    // DLog(@"Authenicated for %@", username);
    
}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller
{
    
    DLog(@"Authentication Failed!");
    UIAlertView *aAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Authentication Failed!\n Try Again" delegate:nil cancelButtonTitle:@"O.K." otherButtonTitles: nil];
    [aAlert show];
    aAlert = nil;
}

- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller
{
	DLog(@"Authentication Canceled.");
    [controller dismissModalViewControllerAnimated:YES];
    self.view.frame=CGRectMake(13, 160, 741, 720);
    
}

//=============================================================================================================================
#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier
{
    DLog(@"Request %@ succeeded", requestIdentifier);
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error
{
    //[[TwtBoothAppDelegate getDelegate] hideIndicator];
    
    NSString *errorReason = nil;
    DLog(@"Error.Code : %i",error.code);
    if(error.code == 502)
        errorReason = @"Twitter is down or being upgraded.";
    else if(error.code == 503)
        errorReason = @"The Twitter servers are up, but overloaded with requests. Try again later.";
    else if(error.code == 406)
        errorReason = @"Returned by the Search API when an invalid format is specified in the request.";
    else if(error.code == 500)
        errorReason = @"Something is broken. Try Again";
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:errorReason delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    [alert show];
    alert = nil;
}

#pragma mark - RateView Delegates
-(void)twitterResponse:(id)response {
	
}

-(void)twitterServiceFailed {
	
}

@end
