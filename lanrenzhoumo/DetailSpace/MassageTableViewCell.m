//
//  MassageTableViewCell.m
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/5.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import "MassageTableViewCell.h"

@implementation MassageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentLabel.numberOfLines=0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
