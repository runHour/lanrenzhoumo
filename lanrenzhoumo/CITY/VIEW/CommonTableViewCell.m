//
//  CommonTableViewCell.m
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/2.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "CityModel.h"
@implementation CommonTableViewCell

-(void)setModel:(CityModel *)model{
    self.province_id=model.province_id;
    self.province_name=model.province_name;
    self.city_id=model.city_id;
    self.city_name=model.city_name;
    self.begin_key=model.begin_key;

}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
