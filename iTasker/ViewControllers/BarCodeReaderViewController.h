//
//  BarCodeReaderViewController.h
//  iTasker
//
//  Created by andrey on 11/8/17.
//  Copyright © 2017 andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BarCodeReaderDelegate<NSObject>
- (void)textDetected:(NSString *)text;
@end

@interface BarCodeReaderViewController : UIViewController

@property (weak) id <BarCodeReaderDelegate> delegate;

@end
