//
//  MainSpaceModel.h
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/10/28.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainSpaceModel : NSObject
/*店名*/
@property (nonatomic , copy) NSString              * poi_name;
/*价格*/
@property (nonatomic , strong) NSNumber            * price;
/*简介*/
@property (nonatomic , copy) NSString              * title;
/*分区*/
@property (nonatomic , copy) NSString              * category;
/*图片*/
@property (nonatomic , strong) NSArray             * front_cover_image_list;
/**/
/**/
/**/
/**/
@property (nonatomic , strong) NSNumber            * collected_num;
@property (nonatomic , copy) NSString              * time_desc;
@property (nonatomic , strong)NSDictionary         * time;
@property (nonatomic , strong) NSNumber            * show_free;
@property (nonatomic , strong) NSNumber            * want_status;
@property (nonatomic , strong) NSArray             * tags;
@property (nonatomic , copy) NSString              * consult_phone;
@property (nonatomic , strong) NSNumber            * sell_status;
@property (nonatomic , copy) NSString              * time_info;
@property (nonatomic , copy) NSString              * poi;
@property (nonatomic , copy) NSString              * jump_type;
@property (nonatomic , copy) NSString              * price_info;
@property (nonatomic , strong) NSNumber            * distance;
@property (nonatomic , strong) NSNumber            * viewed_num;
@property (nonatomic , copy) NSString              * biz_phone;
@property (nonatomic , copy) NSString              * item_type;
@property (nonatomic , strong) NSNumber            * leo_id;
@property (nonatomic , copy) NSString              * jump_data;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , strong) NSNumber            * category_id;

-(id)initWithDictinary:(NSDictionary*)dic;

@end
