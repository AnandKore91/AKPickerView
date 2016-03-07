# AKPickerView
AKPickerView provides a simple way to use UIPickerView with multiple features.

##Usage##

>**Step 1 :**
>import "AKPickerView.h"

>**Step 2 :** Define delegate 
>@interface ViewController : UIViewController<AKPickerViewDelegate>

>**Step 3 :** Build Picker array (As per section) :

    NSMutableArray *arrPickerData=[[NSMutableArray alloc]initWithObjects:@[@"Value_1",@"Value_2",@"Value_3",@"Value_4",@"Value_5",@"Value_6",@"Value_7",@"Value_8",@"Value_9",@"Value_10"], nil];
    
>**Step 4 :** Implement showPicker method

    -(void)showPickerWithTitle:(NSString*)title showCancelButton:(BOOL)showCancelButton arraysForSections:(NSMutableArray*)arraysForSections delegate:(id)delegate;
    
    Example :(Single Component Picker)
     NSMutableArray *arrPickerData=[[NSMutableArray alloc]initWithObjects:@[@"Value_1",@"Value_2",@"Value_3",@"Value_4",@"Value_5",@"Value_6",@"Value_7",@"Value_8",@"Value_9",@"Value_10"], nil];
     [[AKPickerView sharedInstance]showPickerWithTitle:@"Single Comp. Picker" showCancelButton:YES arraysForSections:arrPickerData delegate:self];
    
>**Step 5 :** Implement delegate method 

    This will return selected values for components.
    -(void)akPickerDidFinishPickingValue:(NSDictionary *)selectedValues
    

>**Example :**

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
      [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)      {
        [alert dismissViewControllerAnimated:alert completion:nil];}]];
    
      [self presentViewController:alert animated:YES completion:nil];
    }



##Screenshots##
![Alt text](https://raw.githubusercontent.com/AnandKore91/AKPickerView/master/Screenshots/Simulator%20Screen%20Shot%2007-Mar-2016%2C%2010.17.11%20PM.png?raw=true "Optional Title")

![Alt text](https://raw.githubusercontent.com/AnandKore91/AKPickerView/master/Screenshots/Simulator%20Screen%20Shot%2007-Mar-2016%2C%2010.17.16%20PM.png?raw=true "Optional Title")

![Alt text](https://raw.githubusercontent.com/AnandKore91/AKPickerView/master/Screenshots/Simulator%20Screen%20Shot%2007-Mar-2016%2C%2010.17.18%20PM.png?raw=true "Optional Title")

![Alt text](https://raw.githubusercontent.com/AnandKore91/AKPickerView/master/Screenshots/Simulator%20Screen%20Shot%2007-Mar-2016%2C%2010.17.27%20PM.png?raw=true "Optional Title")

![Alt text](https://raw.githubusercontent.com/AnandKore91/AKPickerView/master/Screenshots/Simulator%20Screen%20Shot%2007-Mar-2016%2C%2010.17.30%20PM.png?raw=true "Optional Title")

