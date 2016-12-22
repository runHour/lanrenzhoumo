//
//  CurrCityButton.m
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/9.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import "CurrCityButton.h"

@implementation CurrCityButton

-(instancetype)initWithFrame:(CGRect)frame fromDictionary:(NSDictionary *)dic{
    if (self=[super initWithFrame:frame]) {
        _dic=[NSMutableDictionary dictionaryWithDictionary:dic];
        self.titleLabel.textAlignment=NSTextAlignmentLeft;
        self.longitude=[dic[@"longitude"] floatValue];
        self.latitude=[dic[@"latitude"] floatValue];
        self.cityName=dic[@"cityName"] ;
        [_dic setValue:@0 forKey:@"city_id"];
    
    }

    return self;
}

-(void)setLatitude:(CGFloat)latitude{

    _latitude=latitude;

}

-(void)setLongitude:(CGFloat)longitude{

    _longitude=longitude;

}

-(void)setCityName:(NSString *)cityName{
    _cityName=cityName;


}
@end
