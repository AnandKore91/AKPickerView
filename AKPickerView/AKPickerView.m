//
//  AKPickerView.m
//  AKPickerView
//
//  Created by Anand A. Kore on 25/9/15.
//  Copyright © 2015 Anand Ashok Kore. All rights reserved.
//

#import "AKPickerView.h"

@interface AKPickerView()

#pragma mark- UIButton Properties
@property(strong,nonatomic)UIButton *btnDone;
@property(strong,nonatomic)UIButton *btnClose;

#pragma mark- UILabel Properties
@property(strong,nonatomic)UILabel *lblTitle;

#pragma mark- UIView Properties
@property(strong,nonatomic)UIView *viewForSeperator1;
@property(strong,nonatomic)UIView *viewForSeperator2;

#pragma mark- UIButton Properties
@property(strong,nonatomic)UIPickerView *akPicker;

#pragma mark- Array Properties
@property(strong,nonatomic)NSMutableArray *arrNumberOfComponents;
@property(strong,nonatomic)NSMutableArray *arrCurrentData;



#pragma mark- Screen Size Values Properties
@property(nonatomic)CGRect screenSize;
@property(nonatomic)CGFloat screenWidth,screenHeight;

@end



@implementation AKPickerView

+(id)sharedInstance
{
    static AKPickerView *selfInstance=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        selfInstance=[[AKPickerView alloc]init];
    });
    return selfInstance;
}


-(void)showPickerWithTitle:(NSString*)title showCancelButton:(BOOL)showCancelButton arraysForSections:(NSMutableArray*)arraysForSections delegate:(id)delegate
{
    if (!delegate)
    {
        NSLog(@"AKPickerView Exception :Delegate not specified. Please set delegate to self.");
        return;
    }
    if (!arraysForSections)
    {
        NSLog(@"AKPickerView Exception :Picker data arraysForSections not specified. Please provide array of array.");
        return;
    }
    
    
    self.delegate=delegate;
    
    
    //----- Calculate screen size -------- //
    _screenSize=[[UIScreen mainScreen]bounds];
    _screenHeight=_screenSize.size.height;
    _screenWidth=_screenSize.size.width;
   
    _arrNumberOfComponents=[[NSMutableArray alloc]initWithArray:arraysForSections];
    
    //----- Remove Previous View --------- //
    UIViewController *delegateController=(UIViewController*)delegate;
    
    id currentView=[delegateController.view viewWithTag:447];
    [currentView removeFromSuperview];
    
    self.tag=447;
    
    UIFont *font=[UIFont fontWithName:@"Helvetica-Light" size:15];
    UIFont *fontBold=[UIFont fontWithName:@"Helvetica-BOLD" size:17];
    self.frame=CGRectMake(0, _screenHeight, _screenWidth,10);
    self.backgroundColor=[UIColor colorWithRed:(43/255.0) green:(172/255.0) blue:(139/255.0) alpha:1];
    
    [_btnDone removeFromSuperview];
    _btnDone=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-75,5,70, 30)];
    [_btnDone setTitle:@"Done" forState:UIControlStateNormal];
    _btnDone.titleLabel.font=font;
    _btnDone.backgroundColor=[UIColor lightGrayColor];
    _btnDone.layer.cornerRadius=5;
    [_btnDone addTarget:self action:@selector(btnPickerDonePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnClose removeFromSuperview];
    _btnClose=[[UIButton alloc]initWithFrame:CGRectMake(5,5,70, 30)];
    [_btnClose setTitle:@"Cancel" forState:UIControlStateNormal];
    _btnClose.titleLabel.font=font;
    _btnClose.backgroundColor=[UIColor lightGrayColor];
    _btnClose.layer.cornerRadius=5;
    [_btnClose addTarget:self action:@selector(btnPickerClosePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_lblTitle removeFromSuperview];
    _lblTitle=[[UILabel alloc]initWithFrame:CGRectMake(0,8,_screenWidth, 30)];
    _lblTitle.textAlignment=NSTextAlignmentCenter;
    _lblTitle.textColor=[UIColor blackColor];
    _lblTitle.font=fontBold;
    _lblTitle.text=title;
    
    [_viewForSeperator1 removeFromSuperview];
    _viewForSeperator1=[[UIView alloc]initWithFrame:CGRectMake(0,0,_screenWidth,1)];
    _viewForSeperator1.backgroundColor=[UIColor whiteColor];
    [self addSubview:_viewForSeperator1];
    
    [_viewForSeperator2 removeFromSuperview];
    _viewForSeperator2=[[UIView alloc]initWithFrame:CGRectMake(0,_btnClose.frame.origin.y+_btnClose.frame.size.height+5,_screenWidth,1)];
    _viewForSeperator2.backgroundColor=[UIColor whiteColor];
    [self addSubview:_viewForSeperator2];
    
    [_akPicker removeFromSuperview];
    _akPicker= [[UIPickerView alloc] initWithFrame:CGRectMake(0,32,_screenWidth, 150)];
    _akPicker.delegate=self;
    _akPicker.dataSource=self;
    _akPicker.showsSelectionIndicator = YES;
    _akPicker.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _akPicker.hidden = NO;
    _akPicker.tintColor=[UIColor whiteColor];
    
    [self updateUI];
    CGRect frameForPickerView=CGRectMake(0,_screenHeight-200,_screenWidth,200);
    [UIView animateWithDuration:0.3f animations:^{
        self.frame=frameForPickerView;
    } completion:^(BOOL finished) {
        
    }];
    [self addSubview:_akPicker];
    [self addSubview:_btnDone];
    [self addSubview:_btnClose];
    [self addSubview:_lblTitle];
    
    if ([delegate isKindOfClass:[UIViewController class]])
    {
        [delegateController.view addSubview:self];
    }
}

//------------------ Pickers Delegate Methods --------------------------------------///

#pragma mark- PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
{
    return [_arrNumberOfComponents count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSMutableArray *arrCurrentData=[[NSMutableArray alloc]initWithArray:[_arrNumberOfComponents objectAtIndex:component]];
//    NSLog(@"Number Of Rows In Component :%i",[arrCurrentData count]);
    return [arrCurrentData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView  titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSMutableArray *arrCurrentData=[[NSMutableArray alloc]initWithArray:[_arrNumberOfComponents objectAtIndex:component]];
//    NSLog(@"Title For Row:%@",arrCurrentData[row]);
    return arrCurrentData[row];
}

#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    NSMutableArray *arrCurrentData=[[NSMutableArray alloc]initWithArray:[_arrNumberOfComponents objectAtIndex:component]];
//    NSLog(@"Selected Value :%@",arrCurrentData[row]);
}
//-------------------- Pickers Delegate End --------------///



#pragma mark- Button Action Methods
-(void)btnPickerDonePressed:(UIButton*)sender
{
    NSMutableDictionary *dictResult=[[NSMutableDictionary  alloc]init];
    
    for (int i=0; i<[_arrNumberOfComponents count]; i++)
    {
        NSString *strValue=[_akPicker.delegate pickerView:_akPicker titleForRow:[_akPicker selectedRowInComponent:i] forComponent:i];
        NSLog(@"Selected Value in section %i :%@",i,strValue);
        
        NSString *strKey=[NSString stringWithFormat:@"Component:%i",i];
        [dictResult setValue:strValue forKey:strKey];
    }
    
    //------ Close AKPicker --------- //
    CGRect frameForPickerView=CGRectMake(0,_screenHeight,_screenWidth,200);
    [UIView animateWithDuration:0.3f animations:^{self.frame=frameForPickerView; } completion:^(BOOL finished)
     {
        [self resetUI];
        [self removeFromSuperview];
        [self.delegate akPickerDidFinishPickingValue:dictResult];
    }];
}

-(void)btnPickerClosePressed:(UIButton*)sender
{
    [self resetUI];
    [self closeAKPicker];
}

-(void)closeAKPicker
{
    CGRect frameForPickerView=CGRectMake(0,_screenHeight,_screenWidth,200);
    [UIView animateWithDuration:0.3f animations:^{self.frame=frameForPickerView; } completion:^(BOOL finished) {[self removeFromSuperview];}];
}

-(void)updateUI
{
    //----------- Picker UI updates
    if (_pickerBG)
    {
        self.backgroundColor=_pickerBG;
    }
    if (_pickerBtnBG)
    {
        _btnDone.backgroundColor=_pickerBtnBG;
        _btnClose.backgroundColor=_pickerBtnBG;
    }
    if (_pickerBtnTitleColor)
    {
        [_btnDone setTitleColor:_pickerBtnTitleColor forState:UIControlStateNormal];
        [_btnClose setTitleColor:_pickerBtnTitleColor forState:UIControlStateNormal];
    }
    if (_pickerTitleColor)
    {
        _lblTitle.textColor=_pickerTitleColor;
    }
    if (_pickerTitleFont)
    {
        _lblTitle.font=_pickerTitleFont;
    }
    
    //-----------------------------//
}
-(void)resetUI
{
    _pickerBG=nil;
    _pickerBtnBG=nil;
    _pickerBtnTitleColor=nil;
    _pickerTitleColor=nil;
    _pickerTitleFont=nil;
}
@end
