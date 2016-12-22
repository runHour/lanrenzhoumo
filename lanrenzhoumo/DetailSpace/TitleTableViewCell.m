//
//  TitleTableViewCell.m
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/7.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import "TitleTableViewCell.h"

@implementation TitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.title.numberOfLines=2;    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
