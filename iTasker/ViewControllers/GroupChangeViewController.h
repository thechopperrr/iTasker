//
//  GroupChangeViewController.h
//  iTasker
//
//  Created by andrey on 11/5/17.
//  Copyright © 2017 andrey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskProvider.h"
#import "UpdateTaskViewController.h"
#import "BarCodeReaderViewController.h"

@interface GroupChangeViewController : UIViewController <UIPickerViewDelegate, BarCodeReaderDelegate>

@property NSMutableArray* selectedTasks;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;
@property (weak, nonatomic) IBOutlet UIButton *qrScanButton;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancellButton;
@property (weak) id <UpdateTaskViewControllerDelegate> delegate;

@end
