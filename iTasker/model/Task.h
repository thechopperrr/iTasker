//
//  Task.h
//  iTasker
//
//  Created by andrey on 11/4/17.
//  Copyright © 2017 andrey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property int taskId;
@property NSString *taskDescription;
@property NSString *notes;
@property BOOL isEditable;
@property int priority;
@property double hours;

@end
