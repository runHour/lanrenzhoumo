//
//  CityButton.m
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/1.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import "CityButton.h"
#import "CityModel.h"
@implementation CityButton
-(instancetype)initWithFrame:(CGRect)frame fromModel:(CityModel*)model {
    if (self=[super initWithFrame:frame]) {
        self.province_id=model.province_id;
        self.province_name=model.province_name;
        self.city_id=model.city_id;
        self.city_name=model.city_name;
        self.layer.cornerRadius=5;
        self.layer.borderWidth=0.4;
        self.layer.borderColor=[UIColor lightGrayColor].CGColor;
        
    }
    return self;
}

//-(void)setModel:(CityModel*)model{
//    self.province_id=model.province_id;
//    self.province_name=model.province_name;
//    self.city_id=model.city_id;
//    self.city_name=model.city_name;
//
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
