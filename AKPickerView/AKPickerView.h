//
//  AKPickerView.h
//  AKPickerView
//
//  Created by Anand A. Kore on 25/9/15.
//  Copyright © 2015 Anand Ashok Kore. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark- Protocol Declarations
@protocol AKPickerViewDelegate <NSObject>
-(void)akPickerDidFinishPickingValue:(NSDictionary*)selectedValues;
@end


@interface AKPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

#pragma mark- Properties declarations
@property(strong,nonatomic)id<AKPickerViewDelegate> delegate;


@property(strong,nonatomic)UIColor *pickerBG;

@property(strong,nonatomic)UIColor *pickerBtnBG;
@property(strong,nonatomic)UIColor *pickerBtnTitleColor;

@property(strong,nonatomic)UIColor *pickerTitleColor;
@property(strong,nonatomic)UIFont *pickerTitleFont;



#pragma mark- Method Declaration
+(id)sharedInstance;
-(void)showPickerWithTitle:(NSString*)title showCancelButton:(BOOL)showCancelButton arraysForSections:(NSMutableArray*)arraysForSections delegate:(id)delegate;




@end
