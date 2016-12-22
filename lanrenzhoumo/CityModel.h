//
//  CityModel.h
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/10/28.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
/*
 result":[
 {
 "city_list":Array[15],
 "begin_key":"hot"
 },
 {
 "city_list":Array[11],
 "begin_key":"A"*/
@property (nonatomic , strong) NSArray             * city_list;
@property (nonatomic , copy) NSString              * begin_key;
@property (nonatomic , copy) NSString              * province_name;
@property (nonatomic , copy) NSString              * city_name;
@property (nonatomic , strong) NSNumber            * city_id;
@property (nonatomic , strong) NSNumber            * province_id;

-(id)initWithDictionary:(NSDictionary*)dictionary;


@end
