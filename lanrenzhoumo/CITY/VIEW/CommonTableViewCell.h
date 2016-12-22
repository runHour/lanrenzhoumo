//
//  CommonTableViewCell.h
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/2.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonTableViewCell : UITableViewCell
@property (nonatomic , strong) NSArray             * city_list;
@property (nonatomic , copy) NSString              * begin_key;
@property (nonatomic , copy) NSString              * province_name;
@property (nonatomic , copy) NSString              * city_name;
@property (nonatomic , strong) NSNumber            * city_id;
@property (nonatomic , strong) NSNumber            * province_id;
-(void)setModel:(id)model;
@end
