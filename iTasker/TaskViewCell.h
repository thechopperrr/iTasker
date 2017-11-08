//
//  TaskViewCell.h
//  iTasker
//
//  Created by andrey on 11/4/17.
//  Copyright © 2017 andrey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "TaskInfo.h"

@class TaskViewCell;

@protocol TaskViewCellDelegate<NSObject>
- (void)cellSelected:(TaskViewCell *)cell;
- (void)cellDeselected:(TaskViewCell *)cell;
@end

@interface TaskViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deskriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@property TaskInfo *taskInfo;
@property (weak) id <TaskViewCellDelegate> delegate;

- (void)setUpTaskInfoAndUpdate:(TaskInfo *)info;
- (void)selectCell;
- (void)deselecttCell;

@end
