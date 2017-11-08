//
//  TaskInfo.m
//  iTasker
//
//  Created by andrey on 11/7/17.
//  Copyright © 2017 andrey. All rights reserved.
//

#import "TaskInfo.h"

@implementation TaskInfo

-(id) copyWithZone: (NSZone *) zone {
    TaskInfo *copy = [[TaskInfo allocWithZone: zone] init];
    copy.task = self.task;
    copy.isSelected = self.isSelected;
    return copy;
}

@end
