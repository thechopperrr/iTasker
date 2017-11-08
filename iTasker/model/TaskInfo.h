//
//  TaskInfo.h
//  iTasker
//
//  Created by andrey on 11/7/17.
//  Copyright © 2017 andrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface TaskInfo : NSObject

@property Task *task;
@property BOOL isSelected;

@end
