//
//  objectInArray.h
//  Labb3 2.0
//
//  Created by Eric Johansson on 2020-01-27.
//  Copyright © 2020 Eric Johansson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface objectInArray : NSObject
@property NSString *taskDescription;
@property (nonatomic, assign) BOOL isUrgent;
@property UIColor *backgroundColor;
@end

NS_ASSUME_NONNULL_END
