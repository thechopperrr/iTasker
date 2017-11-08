//
//  UpdateTaskViewController.h
//  iTasker
//
//  Created by andrey on 11/4/17.
//  Copyright © 2017 andrey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskInfo.h"
#import "HomeViewController.h"
#import "BarCodeReaderViewController.h"

@protocol UpdateTaskViewControllerDelegate<NSObject>
- (void)saveTask:(TaskInfo *)taskInfo;
@end

@interface UpdateTaskViewController : UIViewController <UIPickerViewDelegate, BarCodeReaderDelegate>

@property TaskInfo* taskInfo;
@property (weak, nonatomic) IBOutlet UILabel *taskDescLabel;
@property (weak, nonatomic) IBOutlet UITextView *taskDeskTextView;
@property (weak, nonatomic) IBOutlet UILabel *taskNotesLabel;
@property (weak, nonatomic) IBOutlet UITextView *taskNotesTextView;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UITextField *hoursTextField;
@property (weak, nonatomic) IBOutlet UILabel *editableLabel;
@property (weak, nonatomic) IBOutlet UISwitch *editableSwitch;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *priorityPickerView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancellButton;
@property (weak, nonatomic) IBOutlet UIButton *qrCodeButton;

@property (weak) id <UpdateTaskViewControllerDelegate> delegate;

@end
