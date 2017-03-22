//
//  DBPConvertorProtocol.h
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/17.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *	@brief DBPConvertor协议
 *
 *  继承与DBPConvertor的子类必须实现该协议
 */
@protocol DBPConvertorProtocol <NSObject>
/**
 *	@brief 提供 该Convertor支持转换的类，以及表字段与类属性之间的对应关系 信息
 *
 *	@return 返回 NSDictionary<NSString*,NSDictionary<NSString*,NSString*>*> 类型的字典
 *
 *  @return 键 NSString：支持转换的类的名称
 *
 *  @return 值 NSDictionary<NSString*,NSString*>：表字段与Class类型属性之间的对应关系字典，其中key为表字段名称，value为类型属性名称
 */
-(NSDictionary<NSString*,NSDictionary<NSString*,NSString*>*> *)supportedClassMap;
@end
