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

@property (retain) TaskInfo* taskInfo;
@property (retain, nonatomic) IBOutlet UILabel *taskDescLabel;
@property (retain, nonatomic) IBOutlet UITextView *taskDeskTextView;
@property (retain, nonatomic) IBOutlet UILabel *taskNotesLabel;
@property (retain, nonatomic) IBOutlet UITextView *taskNotesTextView;
@property (retain, nonatomic) IBOutlet UILabel *hoursLabel;
@property (retain, nonatomic) IBOutlet UITextField *hoursTextField;
@property (retain, nonatomic) IBOutlet UILabel *editableLabel;
@property (retain, nonatomic) IBOutlet UISwitch *editableSwitch;
@property (retain, nonatomic) IBOutlet UILabel *priorityLabel;
@property (retain, nonatomic) IBOutlet UIPickerView *priorityPickerView;
@property (retain, nonatomic) IBOutlet UIButton *saveButton;
@property (retain, nonatomic) IBOutlet UIButton *cancellButton;
@property (retain, nonatomic) IBOutlet UIButton *qrCodeButton;

@property (weak) id <UpdateTaskViewControllerDelegate> delegate;

@end
