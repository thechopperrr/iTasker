//
//  TaskProvider.h
//  iTasker
//
//  Created by andrey on 11/4/17.
//  Copyright © 2017 andrey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskLoader : NSObject

+ (NSMutableArray *)loadTasksFromFile: (NSString *) filename;

@end

