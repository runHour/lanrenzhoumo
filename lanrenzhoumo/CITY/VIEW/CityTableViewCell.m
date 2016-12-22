//
//  CityTableViewCell.m
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/1.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import "CityTableViewCell.h"
#import "CityButton.h"
#import "CityModel.h"
#import "CityView.h"
#define Width    [UIScreen mainScreen].bounds.size.width
#define Height   [UIScreen mainScreen].bounds.size.height
#define BtnWidth   (Width-LEFTPadding)/6
#define LEFTPadding   20
#define BtnHeight 30

@interface CityTableViewCell ()
@end

@implementation CityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
