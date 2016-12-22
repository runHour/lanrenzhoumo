//
//  CityModel.m
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/10/28.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }

    return self;

}



@end
