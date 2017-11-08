//
//  TaskViewCell.m
//  iTasker
//
//  Created by andrey on 11/4/17.
//  Copyright © 2017 andrey. All rights reserved.
//

#import "TaskViewCell.h"

@interface TaskViewCell ()
@property (nonatomic) Task *task;
@property bool isSelected;
@end

@implementation TaskViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _selectButton.layer.masksToBounds = true;
    _selectButton.layer.cornerRadius = _selectButton.frame.size.width/2;
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

- (IBAction)selectButtonPressed:(id)sender {
    if(_taskInfo.isSelected){
        [_delegate cellDeselected:self];
    } else {
        [_delegate cellSelected:self];
    }
}

- (void)setUpTaskInfoAndUpdate:(TaskInfo *)info{
    _taskInfo = info;
    if(  _taskInfo.isSelected)
        _selectButton.backgroundColor = [UIColor cyanColor];
    else
        _selectButton.backgroundColor = [UIColor lightGrayColor];
    _timeLabel.text =  [NSString stringWithFormat:NSLocalizedString(@"lbl_cell_hours", nil) ,_taskInfo.task.hours];
    _deskriptionLabel.text = _taskInfo.task.taskDescription;
}

- (void)selectCell{
    _selectButton.backgroundColor = [UIColor cyanColor];
    _taskInfo.isSelected = YES;
}

- (void)deselecttCell{
    _selectButton.backgroundColor = [UIColor lightGrayColor];
    _taskInfo.isSelected = NO;
}

@end
