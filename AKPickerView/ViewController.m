//
//  ViewController.m
//  AKPickerView
//
//  Created by Anand A. Kore on 25/9/15
//  Copyright © 2015 Anand Ashok Kore. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(strong,nonatomic)NSMutableArray *arrTest;
@end


typedef enum : NSUInteger {
    SinglePicker_Example,
    MultiComponent_Example,
    Customized_UI,
} pickerType;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //--- Initialise array.
    _arrTest=[[NSMutableArray alloc] initWithObjects:@"SinglePicker_Example",@"MultiComponent_Example",@"Customized_UI",nil];
    //-- ..
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- UITableView Delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrTest.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"CellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text=_arrTest[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath :%@",_arrTest[indexPath.row]);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self sendRequest:indexPath.row];
}

#pragma mark- AKNetworkOperations Methods
-(void)sendRequest:(pickerType)type
{
    NSMutableArray *arrPickerData=[[NSMutableArray alloc]initWithObjects:@[@"Value_1",@"Value_2",@"Value_3",@"Value_4",@"Value_5",@"Value_6",@"Value_7",@"Value_8",@"Value_9",@"Value_10"], nil];
    
    
    if (type == SinglePicker_Example)
    {
        [[AKPickerView sharedInstance]showPickerWithTitle:@"Single Comp. Picker" showCancelButton:YES arraysForSections:arrPickerData delegate:self];
    }
    else if (type == MultiComponent_Example)
    {
        [arrPickerData addObject:@[@"Value_1",@"Value_2",@"Value_3",@"Value_4",@"Value_5",@"Value_6",@"Value_7",@"Value_8",@"Value_9",@"Value_10"]];
        [arrPickerData addObject:@[@"Value_1",@"Value_2",@"Value_3",@"Value_4",@"Value_5",@"Value_6",@"Value_7",@"Value_8",@"Value_9",@"Value_10"]];
        [arrPickerData addObject:@[@"Value_1",@"Value_2",@"Value_3",@"Value_4",@"Value_5",@"Value_6",@"Value_7",@"Value_8",@"Value_9",@"Value_10"]];
        [[AKPickerView sharedInstance]showPickerWithTitle:@"Multi Comp. Picker" showCancelButton:YES arraysForSections:arrPickerData delegate:self];
    }
    else if (type == Customized_UI)
    {
        [arrPickerData addObject:@[@"Value_1",@"Value_2",@"Value_3",@"Value_4",@"Value_5",@"Value_6",@"Value_7",@"Value_8",@"Value_9",@"Value_10"]];
        [arrPickerData addObject:@[@"Value_1",@"Value_2",@"Value_3",@"Value_4",@"Value_5",@"Value_6",@"Value_7",@"Value_8",@"Value_9",@"Value_10"]];
        AKPickerView *picker=[AKPickerView sharedInstance];
        picker.pickerBG=[UIColor orangeColor];
        picker.pickerBtnBG=[UIColor darkGrayColor];
        picker.pickerBtnTitleColor=[UIColor whiteColor];
        picker.pickerTitleColor=[UIColor whiteColor];
        picker.pickerTitleFont=[UIFont fontWithName:@"Helvetica" size:17];
        
        [picker showPickerWithTitle:@"Customized Picker" showCancelButton:YES arraysForSections:arrPickerData delegate:self];
    }
    else
    {
        NSLog(@"Invalid Type.");
    }
}

-(void)akPickerDidFinishPickingValue:(NSDictionary *)selectedValues
{
    NSLog(@"Selected Value :%@",selectedValues);
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Picked!!" message:[NSString stringWithFormat:@"%@",selectedValues] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:alert completion:nil];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
