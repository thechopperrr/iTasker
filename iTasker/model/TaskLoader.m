//
//  TaskProvider.m
//  iTasker
//
//  Created by andrey on 11/4/17.
//  Copyright © 2017 andrey. All rights reserved.
//

#import "TaskLoader.h"
#import "Task.h"

@implementation TaskLoader

+(NSMutableArray *)loadTasksFromFile: (NSString *) filename {
    
    NSMutableArray* taskArray = [[[NSMutableArray alloc]init] autorelease];
    NSArray* tasks = [self JSONFileToArray:filename];
    for(NSDictionary *taskDictionary in tasks){
        Task *task = [[Task alloc] init];
        [task setTaskId:[[taskDictionary objectForKey:@"TaskId"] intValue]];
        [task setTaskDescription:[taskDictionary objectForKey:@"TaskDescription"]];
        [task setNotes:[taskDictionary objectForKey:@"Notes"]];
        [task setIsEditable:[[taskDictionary objectForKey:@"IsEditable"] boolValue]];
        [task setPriority:[[taskDictionary objectForKey:@"Priority"]intValue]];
        [task setHours:[[taskDictionary objectForKey:@"Hours"] doubleValue]];
        [taskArray addObject:task];
        [task release];
    }
    return [taskArray copy];
}

+ (NSArray *)JSONFileToArray: (NSString*) filename {
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
