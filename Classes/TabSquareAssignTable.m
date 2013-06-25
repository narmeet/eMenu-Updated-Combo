//
//  TabSquareAssignTable.m
//  TabSquareMenu
//
//  Created by Nikhil Kumar on 8/9/12.
//  Copyright (c) 2012 Trendsetterz. All rights reserved.
//

#import "TabSquareAssignTable.h"
#import "TabSquareHomeController.h"
#import <QuartzCore/CALayer.h>
#import "ShareableData.h"
#import "SBJSON.h"
#import "TabSquareTableManagement.h"


NSInteger static compareViewsByOrigin(id sp1, id sp2, void *context)
{
    // UISegmentedControl segments use UISegment objects (private API). Then we can safely
    //   cast them to UIView objects.
    float v1 = ((UIView *)sp1).frame.origin.x;
    float v2 = ((UIView *)sp2).frame.origin.x;
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}


@implementation TabSquareAssignTable

@synthesize tableNo1,tableNo2,tableNo3,tableNo4;
@synthesize noOfGueses,iPadNo,homeView1,homeView2;
@synthesize tablePicker,ipadPicker;
@synthesize hidePickerBtn,segmentControl,gotoDish,gotoTable,gotoResetAssign;
@synthesize lbltableNo1,lbltableNo2,lbltableNo3,lbltableNo4,lbliPadNo,guesesPicker;
@synthesize lbltotalGueses;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
       // Custom initialization
    }
    return self;
}

-(void)RoundTextFieldCorner
{
    tableNo1.layer.cornerRadius=10.0;
    tableNo2.layer.cornerRadius=10.0;
    tableNo3.layer.cornerRadius=10.0;
    tableNo4.layer.cornerRadius=10.0;
    
    lbltableNo1.layer.cornerRadius=10.0;
    lbltableNo2.layer.cornerRadius=10.0;
    lbltableNo3.layer.cornerRadius=10.0;
    lbltableNo4.layer.cornerRadius=10.0;
    
    noOfGueses.layer.cornerRadius=10.0;
    iPadNo.layer.cornerRadius=10.0;
    lbliPadNo.layer.cornerRadius=10.0;
    tableNo1.layer.cornerRadius=10.0;
}

-(void)HideKeyBoard
{
    [noOfGueses resignFirstResponder];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    UITouch *touch = [touches anyObject];
    NSUInteger tapCount = [touch tapCount];
    //CGPoint location = [touch locationInView:self.view];
    
    switch (tapCount)
    {
        case 1:
        {
            [noOfGueses resignFirstResponder];
        }
            break;
    }
}

-(void)getFreeTableNo
{
    //NSString *Key=@"kinara123";
    
    NSString *post =[NSString stringWithFormat:@"key=%@", [ShareableData appKey]];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *url_string = [NSString stringWithFormat:@"%@/webs/get_free_tables", [ShareableData serverURL]];
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
   // DLog(@"Data :%@",data);
    SBJSON *parser = [[SBJSON alloc] init];
    NSMutableArray *resultFromPost = [parser objectWithString:data error:nil];
    
    [tableData addObject:@"None"];
    for(int i=0;i<[resultFromPost count];i++)
    {
        [tableData addObject:[NSString stringWithFormat:@"%@",resultFromPost[i]]];
    }
}

-(void)getIpadTableNo
{
    //NSString *Key=@"kinara123";
    
    NSString *post =[NSString stringWithFormat:@"key=%@", [ShareableData appKey]];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *url_string = [NSString stringWithFormat:@"%@/webs/get_free_ipads", [ShareableData serverURL]];
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
   // DLog(@"Data :%@",data);
    SBJSON *parser = [[SBJSON alloc] init];
    NSMutableArray *resultFromPost = [parser objectWithString:data error:nil];
    for(int i=0;i<[resultFromPost count];++i)
    {
        NSMutableDictionary *dataitem=resultFromPost[i];
       // DLog(@"%@",[dataitem objectForKey:@"name"]);
        NSString *key=[NSString stringWithFormat:@"%@",dataitem[@"name"]];
        [ipadData addObject:key];
        NSString *ipad_id=[NSString stringWithFormat:@"%@",dataitem[@"id"]];
        [ipadId addObject:ipad_id];
    }
    
    // [ipadData addObject:@"k12"];
}

-(void)AssignData
{
    NSString *post =[NSString stringWithFormat:@"table1=%@&table2=%@&table3=%@&table4=%@&ipad_id=%@&no_of_guests=%@&key=%@",tableNo1.text,tableNo2.text,tableNo3.text,tableNo4.text,ipadid,noOfGueses.text, [ShareableData appKey]];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *url_string = [NSString stringWithFormat:@"%@/webs/set_order", [ShareableData serverURL]];
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
    [ShareableData sharedInstance].OrderId=data;
    //DLog(@"%@",data);
}
-(void)AssignTAData
{
    
    NSString *post =[NSString stringWithFormat:@"table1=%@&table2=%@&table3=%@&table4=%@&ipad_id=%@&no_of_guests=%@&key=%@",@"1234",@"",@"",@"",ipadid,@"1", [ShareableData appKey]];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *url_string = [NSString stringWithFormat:@"%@/webs/set_order", [ShareableData serverURL]];
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
    [ShareableData sharedInstance].OrderId=data;
    //DLog(@"%@",data);
}



-(BOOL)AuthenticateWater:(NSString*)passtext
{
    NSString *post =[NSString stringWithFormat:@"password=%@&key=%@",passtext, [ShareableData appKey]];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *url_string = [NSString stringWithFormat:@"%@/webs/authenticate_staff", [ShareableData serverURL]];
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
    if([data isEqualToString:@"1"])
    {
        return true;
    }
    else {
        return false;
    }
    // DLog(@"%@",data);
}

-(void)assignTableNo:(NSString*)tableNo
{
    // self.tableNo1.text=tableNo;
    self.tableNo1.textAlignment=NSTextAlignmentCenter;
}

-(void)createHomeView
{
    homeView=[[TabSquareHomeController alloc]initWithNibName:@"TabSquareHomeController" bundle:nil];
}

-(void)addGuesespickerData
{
    for(int i=1;i<41;++i)
    {
        NSString *noGueses=[NSString stringWithFormat:@"%d",i];
        [guesesData addObject:noGueses];

    }
}




- (void)viewDidLoad
{
    
    [self.segmentControl addTarget:self action:@selector(didChangeSegmentControl:) forControlEvents:UIControlEventValueChanged];
    self.segmentControl.selectedSegmentIndex=0;
    //unselectedColor=[[segmentControl.subviews objectAtIndex:1]
    [self didChangeSegmentControl:nil];
    
    taskType=0;
    tableData=[[NSMutableArray alloc]init];
    ipadData=[[NSMutableArray alloc]init];
    ipadId=[[NSMutableArray alloc]init];
    guesesData=[[NSMutableArray alloc]init];
    tableNo1.inputView=tablePicker;
    tableNo2.inputView=tablePicker;
    tableNo3.inputView=tablePicker;
    tableNo4.inputView=tablePicker;
    noOfGueses.inputView=guesesPicker;
    iPadNo.inputView=ipadPicker;
    [self createHomeView];
    
    //get a free table no and ipad
    [self getFreeTableNo];
    //[self getIpadTableNo];
    [self addGuesespickerData];
    [self RoundTextFieldCorner];
    
    [super viewDidLoad];
    
    
    
   
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidAppear:(BOOL)animated{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);;
    NSString *libraryDirectory = [paths lastObject];
    NSString *location = [libraryDirectory stringByAppendingString:@"/orderarrays.plist"];
    
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"orderarrays" ofType:@"plist"];
    // NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:location];
    if (array !=nil){
        taskType = 51;
        [self myTask];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}


-(IBAction)assignBtnClicked:(id)sender
{
    [self HideKeyBoard];
    
    // open an alert with two custom buttons
    NSString *trimmedString = [noOfGueses.text stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([trimmedString isEqualToString:@""])
    {
        noOfGueses.text=@"0"; 
    }
    
    
    if([[ShareableData sharedInstance].assignedTable1 isEqualToString:@"-1"] &&
       [[ShareableData sharedInstance].assignedTable2 isEqualToString:@"-1"] &&
       [[ShareableData sharedInstance].assignedTable3 isEqualToString:@"-1"] &&
       [[ShareableData sharedInstance].assignedTable4 isEqualToString:@"-1"] )
    {
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Table Not Selected!!!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert1 show];
    }
   /* else if([iPadNo.text isEqualToString:@""])
    {
        UIAlertView *alert2=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"IPad Not Selected!!!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert2 show];
        [alert2 release];
    }*/
    else if([self checkDigit:noOfGueses.text]==1)
    {
        UIAlertView *alert3=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Number of guests not valid!!!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert3 show];
    }
    else if([noOfGueses.text isEqualToString:@"0"])
    {
        UIAlertView *alert3=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Number of guests not valid!!!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert3 show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Enter a 4 digit password:"
                                                       delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
        UITextField * alertTextField = [alert textFieldAtIndex:0];
        alertTextField.keyboardType = UIKeyboardTypeNumberPad;
        [alert show];
        alertNo=1;
    }
}
-(IBAction)assignTakeawayClicked:(id)sender
{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Enter a 4 digit password:"
                                                       delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeNumberPad;
    alertNo = 5;
        [alert show];
        //alertNo=1;
    
}


-(NSInteger)checkDigit:(NSString*)amount
{
    int j=0;
    for (int i=0;i<[amount length];i++) 
    {
        
        char c = [amount characterAtIndex:i];
       // DLog(@"%c",c);
        if(!(c=='0' || c=='1' || c=='2'|| c=='3'|| c=='4'|| c=='5'|| c=='6'|| c=='7'|| c=='8'|| c=='9'))
        {
            j=1;
        }
    }
    return j;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    UITextField *password = [alertView textFieldAtIndex:0];
   // DLog(@"Password: %@", password.text);
    
    if([password.text length]>=4)
    {
        
        if([title isEqualToString:@"OK"]&&alertNo==1)
        {
            BOOL authenticate=[self AuthenticateWater:password.text];
            if(authenticate)
            {
                taskType=1;
                [self showIndicator];
                
            }
            else 
            {
                alertNo=2;
                UIAlertView *alert4 = [[UIAlertView alloc] initWithTitle:nil message:@"please enter correct password"
                                                                delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert4 show];
                
            }
            
        }
        else if([title isEqualToString:@"OK"]&&alertNo==3)
        {
            BOOL authenticate=[self AuthenticateWater:password.text];
            if(authenticate)
            {
                
                TabSquareTableManagement *SalesReport1=[[TabSquareTableManagement alloc]initWithNibName:@"TabSquareTableManagement" bundle:nil];
                [self dismissModalViewControllerAnimated:NO];
                [self presentModalViewController:SalesReport1 animated:YES]; 
            }
            else 
            {
                alertNo=2;
                UIAlertView *alert4 = [[UIAlertView alloc] initWithTitle:nil message:@"please enter correct password"
                                                                delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert4 show];
                
            }
            
        }else if([title isEqualToString:@"OK"]&&alertNo==5)
        {
            BOOL authenticate=[self AuthenticateWater:password.text];
            if(authenticate)
            {
                
                taskType=50;
                [self showIndicator];
            }
            else
            {
                alertNo=2;
                UIAlertView *alert4 = [[UIAlertView alloc] initWithTitle:nil message:@"please enter correct password"
                                                                delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert4 show];
                
            }
            
        }
    }
    else
    {
        UIAlertView *alert4 = [[UIAlertView alloc] initWithTitle:nil message:@"Please Enter 4 digit Password" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert4 show];
    }
    
}

-(IBAction)doorOpenClick:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    btn.hidden=YES;
    
    homeView1.layer.anchorPoint = CGPointMake(0, 0.5); // hinge around the left edge
    homeView1.frame = CGRectMake(0, 0, 384, 1004); //reset view position
    
    homeView2.layer.anchorPoint = CGPointMake(1.0, 0.5); //hinge around the right edge
    homeView2.frame = CGRectMake(384, 0, 384, 1004); //reset view position
    
    [UIView animateWithDuration:1.75 animations:^{
        CATransform3D leftTransform = CATransform3DIdentity;
        leftTransform.m34 = -1.0f/500; //dark magic to set the 3D perspective
        leftTransform = CATransform3DRotate(leftTransform, -M_PI_2, 0, 1, 0);
        homeView1.layer.transform = leftTransform;
        
        CATransform3D rightTransform = CATransform3DIdentity;
        rightTransform.m34 = -1.0f/500; //dark magic to set the 3D perspective
        rightTransform = CATransform3DRotate(rightTransform, M_PI_2, 0, 1, 0);
        homeView2.layer.transform = rightTransform;
    }];
}

-(IBAction)hidePickerBtn:(id)sender
{
    [noOfGueses resignFirstResponder];
    [guesesPicker setHidden:YES];
    [tablePicker setHidden:YES];
    [iPadNo setHidden:YES];
    [hidePickerBtn setHidden:YES];
}

-(IBAction)showTable1List:(id)sender
{
    ipadPicker.hidden=true;
    [guesesPicker setHidden:YES];
    [noOfGueses resignFirstResponder];
    tableNo=1;
    [tablePicker setHidden:NO];
    [tablePicker reloadAllComponents];
    tablePicker.frame=CGRectMake(lbltableNo1.frame.origin.x,( lbltableNo1.frame.origin.y+lbltableNo1.frame.size.height), tablePicker.frame.size.width, tablePicker.frame.size.height);
}
-(IBAction)showTable2List:(id)sender
{
    ipadPicker.hidden=true;
    [guesesPicker setHidden:YES];
    [noOfGueses resignFirstResponder];
    tableNo=2;
    [tablePicker setHidden:NO];
    [tablePicker reloadAllComponents];
    tablePicker.frame=CGRectMake(lbltableNo2.frame.origin.x,( lbltableNo2.frame.origin.y+lbltableNo2.frame.size.height), tablePicker.frame.size.width, tablePicker.frame.size.height);
}
-(IBAction)showTable3List:(id)sender
{
    ipadPicker.hidden=true;
    [guesesPicker setHidden:YES];
    [noOfGueses resignFirstResponder];
    tableNo=3;
    [tablePicker setHidden:NO];
    [tablePicker reloadAllComponents];
    tablePicker.frame=CGRectMake(lbltableNo3.frame.origin.x,( lbltableNo3.frame.origin.y+lbltableNo3.frame.size.height), tablePicker.frame.size.width, tablePicker.frame.size.height);
}
-(IBAction)showTable4List:(id)sender
{
    ipadPicker.hidden=true;
    [guesesPicker setHidden:YES];
    [noOfGueses resignFirstResponder];
    tableNo=4;
    [tablePicker setHidden:NO];
    [tablePicker reloadAllComponents];
    tablePicker.frame=CGRectMake(lbltableNo4.frame.origin.x,( lbltableNo4.frame.origin.y+lbltableNo4.frame.size.height), tablePicker.frame.size.width, tablePicker.frame.size.height);
}

-(IBAction)showIpad:(id)sender
{
    [tablePicker setHidden:YES];
    [noOfGueses resignFirstResponder];
    if([ipadData count]!=0)
    {
        //[ipadPicker setHidden:NO];[self publish1:[ShareableData sharedInstance].feedDishName rating:[ShareableData sharedInstance].feedDishRating];    
    }
    
    [ipadPicker reloadAllComponents];
}

-(IBAction)showGuesesPicker:(id)sender
{
    [tablePicker setHidden:YES];
    [noOfGueses resignFirstResponder];
    if([guesesData count]!=0)
    {
        [guesesPicker setHidden:NO];
         guesesPicker.frame=CGRectMake(guesesPicker.frame.origin.x,( lbltotalGueses.frame.origin.y+lbltotalGueses.frame.size.height), guesesPicker.frame.size.width, guesesPicker.frame.size.height);  
    }
    
    [guesesPicker reloadAllComponents];
}






-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [hidePickerBtn setHidden:NO];
    [tablePicker setHidden:YES];
    [guesesPicker setHidden:YES];
    [ipadPicker setHidden:YES];
    if (tableNo1.editing == YES||tableNo2.editing==YES||tableNo3.editing==YES||tableNo4.editing==YES)
    {
        [textField resignFirstResponder];
        [noOfGueses resignFirstResponder];
        tableNo=textField.tag;
        [tablePicker setHidden:NO];
        [tablePicker reloadAllComponents];
        tablePicker.frame=CGRectMake(textField.frame.origin.x,( textField.frame.origin.y+textField.frame.size.height), tablePicker.frame.size.width, tablePicker.frame.size.height);
        
    }
    else if (noOfGueses.editing == YES) { 
        
        [textField resignFirstResponder];
        [noOfGueses resignFirstResponder];
        if([guesesData count]!=0)
        {
            [guesesPicker setHidden:NO];
        }
        
        [guesesPicker reloadAllComponents];
        
    }   
    
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if (CGRectContainsPoint([self.tableNo1 frame], [touch locationInView:self.view])
        ||CGRectContainsPoint([self.tableNo2 frame], [touch locationInView:self.view])
        ||CGRectContainsPoint([self.tableNo3 frame], [touch locationInView:self.view])
        ||CGRectContainsPoint([self.tableNo4 frame], [touch locationInView:self.view])
        ||CGRectContainsPoint([self.noOfGueses frame], [touch locationInView:self.view])
        )
    {
        
    }
    else
    {
        [noOfGueses resignFirstResponder];
        [tablePicker setHidden:YES];
        [ipadPicker setHidden:YES];
        [guesesPicker setHidden:YES];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    if(pickerView==guesesPicker)
    {
        return  [guesesData count];
    }
    else {
        return [tableData count];
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{   
    if(pickerView==guesesPicker)
    {
        return guesesData[row];
    }
    else {
        return tableData[row];
    }
    return @"0";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView==guesesPicker)
    {
        noOfGueses.text=guesesData[row];
        //ipadid=[ipadId objectAtIndex:row];
        guesesPicker.hidden=true;
        lbltotalGueses.text=noOfGueses.text;
    }
    else if(tableNo==1)
    {
        tableNo1.text=tableData[row];
        if([tableNo1.text isEqualToString:@"None"])
        {
            [ShareableData sharedInstance].assignedTable1=@"-1";
            tableNo1.text=@"";
        }
        else
            [ShareableData sharedInstance].assignedTable1=tableNo1.text;
        tablePicker.hidden=true;
        lbltableNo1.text=tableNo1.text;
    }
    else if(tableNo==2)
    {
        tableNo2.text=tableData[row];
        if([tableNo2.text isEqualToString:@"None"])
        {
            [ShareableData sharedInstance].assignedTable2=@"-1";
            tableNo2.text=@"";
        }
        else
            [ShareableData sharedInstance].assignedTable2=tableNo2.text; 
        tablePicker.hidden=true;
        lbltableNo2.text=tableNo2.text;
    }
    else if(tableNo==3)
    {
        tableNo3.text=tableData[row];
        if([tableNo3.text isEqualToString:@"None"])
        {
            [ShareableData sharedInstance].assignedTable3=@"-1";
            tableNo3.text=@"";
        }
        else
            [ShareableData sharedInstance].assignedTable3=tableNo3.text;
        tablePicker.hidden=true;
        lbltableNo3.text=tableNo3.text;
    }
    else if(tableNo==4)
    {
        tableNo4.text=tableData[row];
        if([tableNo4.text isEqualToString:@"None"])
        {
            [ShareableData sharedInstance].assignedTable4=@"-1";
            tableNo4.text=@"";
        }
        else
            [ShareableData sharedInstance].assignedTable4=tableNo4.text; 
        tablePicker.hidden=true;
        lbltableNo4.text=tableNo4.text;
    }
    
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
    if(taskType==1)
    {
        [[ShareableData sharedInstance].IsEditOrder isEqualToString:@"0"];
        [self AssignData];
        if (homeView !=nil){
            [self createHomeView];
        }

        //[self dismissModalViewControllerAnimated:NO];
        [self presentModalViewController:homeView animated:YES]; 
    }
    else if(taskType==2)
    {
        //[self dismissModalViewControllerAnimated:NO];
        [self presentModalViewController:homeView animated:YES]; 
    }else if(taskType ==50){
        [ShareableData sharedInstance].ViewMode = 2;
        [[ShareableData sharedInstance].IsEditOrder isEqualToString:@"0"];
        [ShareableData sharedInstance].assignedTable1=@"1234";
        [ShareableData sharedInstance].assignedTable2=@"-1";
        [ShareableData sharedInstance].assignedTable3=@"-1";
        [ShareableData sharedInstance].assignedTable4=@"-1";
        [self AssignTAData];
        if (homeView !=nil){
            [self createHomeView];
        }
        
        
        //[self dismissModalViewControllerAnimated:NO];
        [self presentModalViewController:homeView animated:YES];
        
    }else if(taskType ==51){
        DLog(@"Crash Loaded");
        [ShareableData sharedInstance].performUpdateCheck = @"1";
        [ShareableData sharedInstance].ViewMode = 2;
        [[ShareableData sharedInstance].IsEditOrder isEqualToString:@"0"];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);;
        NSString *libraryDirectory = [paths lastObject];
        NSString *location = [libraryDirectory stringByAppendingString:@"/orderarrays.plist"];
        
        //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"orderarrays" ofType:@"plist"];
        // NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:location];
       // NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"orderstrings" ofType:@"plist"];
       // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);;
       // NSString *libraryDirectory = [paths objectAtIndex:0];
        NSString *location2 = [libraryDirectory stringByAppendingString:@"/orderstrings.plist"];
        // NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        NSArray *array2 = [[NSArray alloc] initWithContentsOfFile:location2];
        
        
        
        [ShareableData sharedInstance].assignedTable1 = [array2[1] copy];
        [ShareableData sharedInstance].assignedTable2 = [array2[2] copy];
        [ShareableData sharedInstance].assignedTable3 = [array2[3] copy];
        [ShareableData sharedInstance].assignedTable4 = [array2[4] copy];
        [ShareableData sharedInstance].OrderId = [array2[0] copy];
       // [[ShareableData sharedInstance].OrderItemID release];
        [ShareableData sharedInstance].OrderItemID = [array[0] mutableCopy];
       // [[ShareableData sharedInstance].OrderItemName release];
        [ShareableData sharedInstance].OrderItemName =[array[1] mutableCopy];
       // [[ShareableData sharedInstance].OrderItemRate release];
        [ShareableData sharedInstance].OrderItemRate =[array[2] mutableCopy];
       // [[ShareableData sharedInstance].OrderCatId release];
        [ShareableData sharedInstance].OrderCatId =[array[3] mutableCopy];
       // [[ShareableData sharedInstance].IsOrderCustomization release];
        [ShareableData sharedInstance].IsOrderCustomization =[array[4] mutableCopy];
       // [[ShareableData sharedInstance].OrderCustomizationDetail release];
        [ShareableData sharedInstance].OrderCustomizationDetail =[array[5] mutableCopy];
      //  [[ShareableData sharedInstance].OrderSpecialRequest release];
        [ShareableData sharedInstance].OrderSpecialRequest =[array[6] mutableCopy];
      //  [[ShareableData sharedInstance].OrderItemQuantity release];
        [ShareableData sharedInstance].OrderItemQuantity =[array[7] mutableCopy];
     //   [[ShareableData sharedInstance].confirmOrder release];
        [ShareableData sharedInstance].confirmOrder =[array[8] mutableCopy];
        [ShareableData sharedInstance].salesNo =[array2[5] copy];
        
        

        
        
     
        //[self AssignTAData];
        if (homeView !=nil){
            [self createHomeView];
        }
        
        
        //[self dismissModalViewControllerAnimated:NO];
        [self presentModalViewController:homeView animated:YES];
        
    }
}

-(IBAction)gotoDishMenu:(id)sender
{
    [self HideKeyBoard];
    [ShareableData sharedInstance].isLogin=@"0";
    taskType=2;
    [self showIndicator];
}

-(IBAction)gotoTableManagement:(id)sender
{
    [self HideKeyBoard];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Enter a 4 digit password:"
                                                   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeNumberPad;
    [alert show];
    alertNo=3;
}

- (void)didChangeSegmentControl:(UISegmentedControl *)control 
{
    int index=control.selectedSegmentIndex;
    // DLog(@"%d",index);
    //UIColor *color;
    int numSegments = [segmentControl.subviews count];
    
    // Reset segment's color (non selected color)
    for( int i = 0; i < numSegments; i++ )
    {
        // reset color
        [(segmentControl.subviews)[i] setTintColor:nil];
        [(segmentControl.subviews)[i] setTintColor:[UIColor blackColor]];
    }
    
    // Sort segments from left to right
    NSArray *sortedViews = [segmentControl.subviews sortedArrayUsingFunction:compareViewsByOrigin context:NULL];
    
    // Change color of selected segment
    [sortedViews[segmentControl.selectedSegmentIndex] setTintColor:[UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1]];
    
    // Remove all original segments from the control
    for (id view in segmentControl.subviews) {
        [view removeFromSuperview];
    }
    
    // Append sorted and colored segments to the control
    for (id view in sortedViews) {
        [segmentControl addSubview:view];
    }
    
    [ShareableData sharedInstance].ViewMode=index+1;
   // DLog(@"Index : %d",index+1);   
    
    if(![ShareableData sharedInstance].isInternetConnected && [ShareableData sharedInstance].ViewMode==2)
    {
        UIAlertView *alert3=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please check internet connection" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil]; 
        [alert3 show];
        [ShareableData sharedInstance].ViewMode=1;
    }
    
    if([ShareableData sharedInstance].ViewMode==1)
    {
        gotoResetAssign.hidden=true;
        gotoTable.hidden=true;
    }
    else
    {
        gotoResetAssign.hidden=false;
        gotoTable.hidden=false;
    }
    
}



@end
