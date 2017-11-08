//
//  Task.m
//  iTasker
//
//  Created by andrey on 11/4/17.
//  Copyright © 2017 andrey. All rights reserved.
//

#import "Task.h"

@implementation Task

-(id) copyWithZone: (NSZone *) zone {
    Task *copy = [[Task allocWithZone: zone] init];
    copy.taskId = self.taskId;
    copy.taskDescription = self.taskDescription;
    copy.notes = self.notes;
    copy.isEditable = self.isEditable;
    copy.priority = self.priority;
    copy.hours = self.hours;
    return copy;
}

@end
