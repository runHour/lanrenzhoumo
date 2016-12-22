//
//  CityButton.h
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/1.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityButton : UIButton
@property (nonatomic , copy) NSString              * province_name;
@property (nonatomic , copy) NSString              * city_name;
@property (nonatomic , strong) NSNumber            * city_id;
@property (nonatomic , strong) NSNumber            * province_id;


-(instancetype)initWithFrame:(CGRect)frame fromModel:(id)model;


@end
