//
//  toDoCell.m
//  Labb3 2.0
//
//  Created by Eric Johansson on 2020-01-27.
//  Copyright © 2020 Eric Johansson. All rights reserved.
//

#import "toDoCell.h"

@implementation toDoCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)setUrgent:(id)sender {
    if(self.callbackBlock != nil){
     self.backgroundColor = self.callbackBlock();
    }
}

@end
