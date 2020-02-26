//
//  toDoCell.h
//  Labb3 2.0
//
//  Created by Eric Johansson on 2020-01-27.
//  Copyright © 2020 Eric Johansson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface toDoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *toDoView;
@property (weak, nonatomic) IBOutlet UIButton *urgentButton;
@property (nonatomic, copy) UIColor*(^callbackBlock)(void);
@end

NS_ASSUME_NONNULL_END
