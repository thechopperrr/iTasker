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

@property (assign) NSMutableArray* selectedTasks;
@property (retain, nonatomic) IBOutlet UILabel *notesLabel;
@property (retain, nonatomic) IBOutlet UITextView *notesTextView;
@property (retain, nonatomic) IBOutlet UIButton *qrScanButton;
@property (retain, nonatomic) IBOutlet UILabel *priorityLabel;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerView;
@property (retain, nonatomic) IBOutlet UIButton *saveButton;
@property (retain, nonatomic) IBOutlet UIButton *cancellButton;
@property (weak) id <UpdateTaskViewControllerDelegate> delegate;

@end
