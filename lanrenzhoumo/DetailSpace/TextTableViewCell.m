//
//  TextTableViewCell.m
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/5.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import "TextTableViewCell.h"

@implementation TextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentlabel.numberOfLines=0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
