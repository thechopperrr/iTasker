//
//  GroupChangeViewController.m
//  iTasker
//
//  Created by andrey on 11/5/17.
//  Copyright © 2017 andrey. All rights reserved.
//

#import "GroupChangeViewController.h"
#import "TaskInfo.h"

@interface GroupChangeViewController ()<UITextViewDelegate>

@end

@implementation GroupChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"title_group_change", nil);
    self.navigationItem.hidesBackButton = YES;
    
    _notesLabel.text = NSLocalizedString(@"lbl_task_notes", nil);
    _priorityLabel.text = NSLocalizedString(@"lbl_priority", nil);
    [_qrScanButton setTitle:NSLocalizedString(@"btn_qr_scan", nil) forState:UIControlStateNormal];
    [_cancellButton setTitle:NSLocalizedString(@"btn_cancell", nil) forState:UIControlStateNormal];
    [_saveButton setTitle:NSLocalizedString(@"btn_save", nil) forState:UIControlStateNormal];
    
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer: tapRec];
    
    [self setUptexts];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUptexts{
   
}

- (IBAction)saveButtonPressed:(id)sender {
    for(TaskInfo *info in _selectedTasks){
        if(info.task.isEditable) {
            info.task.priority = (int)[_pickerView selectedRowInComponent:0];
            info.task.notes = _notesTextView.text;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancellButtonPressed:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)qrScanButtonPressed:(id)sender {
    BarCodeReaderViewController *barCodeReaderViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BarCodeReaderViewController"];
    barCodeReaderViewController.delegate = self;
    [self.navigationController pushViewController:barCodeReaderViewController animated:NO];
    
}

- (void)textDetected:(NSString *)text{
     _notesTextView.text = text;
}

-(void)tap:(UITapGestureRecognizer *)tapRec{
    [[self view] endEditing: YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [@(row) stringValue];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == _notesTextView){
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            return NO;
        }
    }
    return YES;
}


@end
