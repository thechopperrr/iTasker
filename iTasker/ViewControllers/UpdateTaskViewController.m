//
//  UpdateTaskViewController.m
//  iTasker
//
//  Created by andrey on 11/4/17.
//  Copyright © 2017 andrey. All rights reserved.
//

#import "UpdateTaskViewController.h"



@interface UpdateTaskViewController ()
//@property int priority;
@end

@implementation UpdateTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self setUpTexts];
    if(_taskInfo.task){
        [self updateViewsForTask:_taskInfo.task];
        self.navigationItem.title = NSLocalizedString(@"title_task", nil);
    } else {
        self.navigationItem.title = NSLocalizedString(@"title_new_task", nil);
    }
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer: tapRec];
    // Do any additional setup after loading the view.
}

- (void)setUpTexts {
    _taskDescLabel.text = NSLocalizedString(@"lbl_task_dsc", nil);
    _taskNotesLabel.text = NSLocalizedString(@"lbl_task_notes", nil);
    _hoursLabel.text =  NSLocalizedString(@"lbl_hours", nil);
    _editableLabel.text =  NSLocalizedString(@"lbl_editable", nil);
    _priorityLabel.text =  NSLocalizedString(@"lbl_priority", nil);    
    [_saveButton setTitle:NSLocalizedString(@"btn_save", nil) forState:UIControlStateNormal];
    [_cancellButton setTitle:NSLocalizedString(@"btn_cancell", nil) forState:UIControlStateNormal];
    [_qrCodeButton setTitle:NSLocalizedString(@"btn_qr_scan", nil) forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonPressed:(id)sender {
    if( [self saveOneTask])
        [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)saveOneTask{
    if ([self saveTask]){
        [_delegate saveTask:_taskInfo];
        return YES;
    } else {
        return NO;
    }
}

- (IBAction)cancellButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)updateViewsForTask: (Task*)task {
    _taskDeskTextView.text = task.taskDescription;
    _taskNotesTextView.text = task.notes;
    if(task.isEditable){
        [_editableSwitch setOn:YES];
    } else {
        [_editableSwitch setOn:NO];
         [self lockControls];
    }
    _hoursTextField.text = [@(task.hours) stringValue];
    [_priorityPickerView selectRow:task.priority inComponent:0 animated:YES];
}	

- (BOOL)saveTask {
    //if we create new task
    if( ! _taskInfo){
        _taskInfo = [[TaskInfo alloc]init];
        _taskInfo.task = [[Task alloc]init];
    }
    if([_editableSwitch isOn]){
        _taskInfo.task.isEditable = YES;
    } else {
        _taskInfo.task.isEditable = NO;
    }
    _taskInfo.task.priority = (int)[_priorityPickerView selectedRowInComponent:0];
    _taskInfo.task.taskDescription =  _taskDeskTextView.text;
   _taskInfo.task.notes = _taskNotesTextView.text;
    NSDecimal decimalValue;
    NSScanner *sc = [NSScanner scannerWithString:_hoursTextField.text];
    [sc scanDecimal:&decimalValue];
    BOOL isDecimal = [sc isAtEnd];
    if(isDecimal){
        _taskInfo.task.hours = [_hoursTextField.text doubleValue];
        return YES;
    } else {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:NSLocalizedString(@"title_error", nil)
                                                                      message:NSLocalizedString(@"hrs_error_messahe", nil)
                                                               preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okButton = [UIAlertAction actionWithTitle:NSLocalizedString(@"btn_ok", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:NULL];
        [alert addAction:okButton];
        [self presentViewController:alert animated:YES completion:nil];

        return NO;
    }
}

-(void)tap:(UITapGestureRecognizer *)tapRec{
    [[self view] endEditing: YES];
}	

- (void)lockControls{
    _taskDeskTextView.textColor = [UIColor lightGrayColor];
    _taskDeskTextView.userInteractionEnabled = NO;
    _taskNotesTextView.textColor = [UIColor lightGrayColor];
    _taskNotesTextView.userInteractionEnabled = NO;
    _hoursTextField.textColor = [UIColor lightGrayColor];
    _hoursTextField.userInteractionEnabled = NO;
    _saveButton.titleLabel.textColor = [UIColor lightGrayColor];
    _saveButton.enabled = NO;
    _priorityPickerView.userInteractionEnabled = NO;
    _editableSwitch.userInteractionEnabled = NO;
    _qrCodeButton.enabled = NO;
    _qrCodeButton.titleLabel.textColor = [UIColor lightGrayColor];
}

- (IBAction)qrNotesScanButtonPressed:(id)sender {
    
    BarCodeReaderViewController *barCodeReaderViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BarCodeReaderViewController"];
    barCodeReaderViewController.delegate = self;
    [self.navigationController pushViewController:barCodeReaderViewController animated:NO];
  //  [self presentViewController:barCodeReaderViewController animated:YES completion:NULL];
}

- (void)textDetected:(NSString *)text{
    [_taskNotesTextView setText:text];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == _taskNotesTextView || textView == _taskDeskTextView){
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            return NO;
        }
    }
    return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

@end
