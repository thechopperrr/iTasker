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
        TaskInfo *info =[[[TaskInfo alloc]init] autorelease];
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

- (void)saveTask:(TaskInfo *)taskToUpdate{
    NSMutableArray* taskArray = [self getTaskInfosWithPriority:taskToUpdate.task.priority];
    if( ! [self containsObjectWithId:taskToUpdate.task.taskId :taskArray]){
        [taskArray addObject:taskToUpdate];
    }
}

- (BOOL)containsObjectWithId:(int)taskId : (NSMutableArray *)tasks{
    for(TaskInfo *info in tasks){
        if(info.task.taskId == taskId)
            return YES;
    }
    return NO;
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
    [self relocateTasksFromArray:_taskinfosPriorityZero withPriority:0];
    [self relocateTasksFromArray:_taskInfosPriorityOne withPriority:1];
    [self relocateTasksFromArray:_taskInfosPriorityTwo withPriority:2];
}


- (void)relocateTasksFromArray:(NSMutableArray *)array withPriority: (int)priority{
    NSMutableArray *tasksToDelete = [[NSMutableArray alloc]init];
    for(TaskInfo *info in array){
        if(info.task.priority != priority){
            NSMutableArray *arrayToUpdate = [self getTaskInfosWithPriority:info.task.priority];
            if( ! [self containsObjectWithId:info.task.taskId :arrayToUpdate])
                [arrayToUpdate addObject:info];
                [tasksToDelete addObject:info];
        }
    }
    [array removeObjectsInArray:tasksToDelete];
    [tasksToDelete release];
}

-(void)dealloc {
     _selectedtTasks = nil;
    [_selectedtTasks release];
   _taskinfosPriorityZero = nil;
    [_taskinfosPriorityZero release];
    _taskInfosPriorityOne = nil;
    [_taskInfosPriorityOne release];
    _taskInfosPriorityTwo = nil;
    [_taskInfosPriorityTwo release];
    [super dealloc];
}

@end
