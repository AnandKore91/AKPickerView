//
//  ViewController.h
//  AKPickerView
//
//  Created by Anand A. Kore on 25/9/15
//  Copyright © 2015 Anand Ashok Kore. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "AKPickerView.h"



@interface ViewController : UIViewController<AKPickerViewDelegate>

#pragma mark- Properties declarations
@property (weak, nonatomic) IBOutlet UITableView *tblView;



@end

