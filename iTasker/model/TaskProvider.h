//
//  TaskProvider.h
//  iTasker
//
//  Created by andrey on 11/4/17.
//  Copyright © 2017 andrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface TaskProvider : NSObject

@property  NSMutableArray *selectedtTasks;
@property NSMutableArray* taskinfosPriorityZero;
@property NSMutableArray* taskInfosPriorityOne;
@property NSMutableArray* taskInfosPriorityTwo;


@property int selectedPriority;

- (BOOL)isSelectedTasksNeighbours;
- (void)deselectAllTasks;
//- (NSMutableArray *)getSelectedTasks;
- (NSMutableArray *)getTasksForGroupChange;
- (NSMutableArray*)getTaskInfosWithPriority:(int)priority;
- (int)getHoursForPriority:(int)priority;
- (void)saveTask:(Task *)task;

@end
