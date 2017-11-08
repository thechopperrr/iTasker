//
//  TaskProvider.m
//  iTasker
//
//  Created by andrey on 11/4/17.
//  Copyright © 2017 andrey. All rights reserved.
//

#import "TaskProvider.h"
#import "TaskLoader.h"
#import "Task.h"
#import "TaskInfo.h"


@implementation TaskProvider

- (id)init{
    self = [super init];
    if(self){
        _selectedtTasks = [[NSMutableArray alloc]init];
        _taskinfosPriorityZero = [[NSMutableArray alloc]init];
        _taskInfosPriorityOne = [[NSMutableArray alloc]init];
        _taskInfosPriorityTwo = [[NSMutableArray alloc]init];
        [self setTaskInfos];
    }
    return self;
}

- (void)setTaskInfos {
    
    for(Task* task in [TaskLoader loadTasksFromFile:@"to_do_list"]){
        TaskInfo *info =[[TaskInfo alloc]init];
        info.task = task;
        NSMutableArray* arr = [self getTaskInfosWithPriority:task.priority];
        [arr addObject:info];
    }
}

- (NSMutableArray*)getTaskInfosWithPriority:(int)priority{
    switch (priority) {
        case 0:
            return _taskinfosPriorityZero;
            break;
        case 1:
            return _taskInfosPriorityOne;
            break;
        case 2:
            return _taskInfosPriorityTwo;
            break;
            
        default:
            return nil;
            break;
    }
}

- (int)getHoursForPriority:(int)priority{
    NSMutableArray *arr = [self getTaskInfosWithPriority:priority];
    int hours = 0;
    for(TaskInfo *info in arr){
            hours += info.task.hours;
    }
    return hours;
}

- (void)saveTask:(Task *)taskToUpdate{
    
    NSMutableArray* taskArray = [self getTaskInfosWithPriority:taskToUpdate.priority];
    TaskInfo* info = [[TaskInfo alloc]init];
    info.task = taskToUpdate;
    [taskArray addObject:info];
}

- (void)deselectTaskInArray: (NSMutableArray*)tasks{
    for(TaskInfo* info in tasks)
        info.isSelected = NO;
}

- (void)deselectAllTasks{
    [self deselectTaskInArray:_taskinfosPriorityZero];
    [self deselectTaskInArray:_taskInfosPriorityOne];
    [self deselectTaskInArray:_taskInfosPriorityTwo];
}

- (NSMutableArray*)getSelectedTasksFromArray:(NSMutableArray *)tasks{
    NSMutableArray* arr = [[NSMutableArray alloc]init];
    for(TaskInfo *info in tasks){
        if(info.isSelected)
            [arr addObject:info];
    }
    return arr;
}

- (NSMutableArray*)getSelectedTasks {
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    [arr addObjectsFromArray:[self getSelectedTasksFromArray:_taskinfosPriorityZero]];
    [arr addObjectsFromArray:[self getSelectedTasksFromArray:_taskInfosPriorityOne]];
    [arr addObjectsFromArray:[self getSelectedTasksFromArray:_taskInfosPriorityTwo]];
    return arr;
}

- (BOOL)areAllSelectedWithSamePriority{
    NSArray* tasks = [self getSelectedTasks];
    TaskInfo* taskInfo = [tasks firstObject];
    _selectedPriority = taskInfo.task.priority;
    for (TaskInfo *info in tasks){
        if(info.task.priority != _selectedPriority)
            return NO;
    }
    return YES;
}

- (BOOL)isSelectedTasksNeighbours{
    if( ! [self areAllSelectedWithSamePriority])
        return NO;
    
    NSArray *selectedTasks =  [self getSelectedTasks];
    TaskInfo* info = [selectedTasks firstObject];
    int selectedPriority =  info.task.priority;
    NSMutableArray *tasksWithPriority = [self getTaskInfosWithPriority:selectedPriority];
    int selectedCount = (int)[selectedTasks count] ;
    
    for (int i = 0; i < [tasksWithPriority count]; i ++){
        TaskInfo *info = [tasksWithPriority objectAtIndex:i];
        if(info.isSelected){
            selectedCount--;
            if(selectedCount == 0){
                return YES;
            } else {
                if(i < ([tasksWithPriority count] -1 )){
                    TaskInfo *nextInfo = [tasksWithPriority objectAtIndex:i+1];
                    if( ! nextInfo.isSelected)
                        return NO;
                } 
            }
        }
    }
    return YES;
}

- (NSMutableArray *)getTasksForGroupChange {
    if([self isSelectedTasksNeighbours])
        return [self getSelectedTasks];
    return nil;
}

- (void)updateArrays{
    for(TaskInfo *info in _taskInfosPriorityOne){
        if(info.task.priority != 0){
            [self moveTaskInfoFromArrayToArray:info :_taskInfosPriorityOne :[self getTaskInfosWithPriority:info.task.priority]];
        }
    }
    for(TaskInfo *info in _taskInfosPriorityTwo){
        if(info.task.priority != 0){
            [self moveTaskInfoFromArrayToArray:info :_taskInfosPriorityTwo :[self getTaskInfosWithPriority:info.task.priority]];
        }
    }
    for(TaskInfo *info in _taskinfosPriorityZero){
        if(info.task.priority != 0){
            [self moveTaskInfoFromArrayToArray:info :_taskinfosPriorityZero :[self getTaskInfosWithPriority:info.task.priority]];
        }
    }
}

- (void)moveTaskInfoFromArrayToArray:(TaskInfo *) taskInfo :(NSMutableArray *)sourceArray : (NSMutableArray *) destinationArray{
    NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
    
    [destinationArray addObject:[taskInfo copy]];
    [sourceArray removeObject:taskInfo];
}

@end
