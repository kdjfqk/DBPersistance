# DBPersistance
基于FMDB提供更加简洁的数据库增删改查API；支持数据库加密；通过自定义转换器可以直接存取Model对象

## 类说明
### DBPTableOperator
* DBPTableOperator是类库的核心类，提供了增删改查方法，每种操作都提供了字典和Model类型两种API
* 开发者需要为每个表创建一个DBPTableOperator的子类

#### Insert


```
/**
 *	@brief 使用具体对象实例作为数据源，插入一条记录
 *
 *	@param obj		对象实例，该对象实例的类型必须是该表的DBPConvertor所支持转换的类型
 *	@param update	当检测到记录已经存在时，是否更新数据，YES则更新，NO则不更新
 *
 *	@return 插入成功返回YES，否则返回NO
 */
-(BOOL)insertWithObject:(id)obj updateIfExist:(BOOL)update;
/**
 *	@brief 使用具体对象实例作为数据源，插入多条记录
 *
 *	@param obj		对象实例数组，数组中每一个对象实例的类型必须是该表的DBPConvertor所支持转换的类型
 *	@param update	当检测到记录已经存在时，是否更新数据，YES则更新，NO则不更新
 *
 *	@return 插入成功返回YES，否则返回NO
 */
-(BOOL)insertWithObjects:(NSArray*)objs updateIfExist:(BOOL)update;
/**
 *	@brief 插入一条记录
 *
 *	@param keyValue	要插入的记录的字典表示形式，key为列名称，value为该列的值
 *	@param update 当检测到记录已经存在时，是否更新数据，YES则更新，NO则不更新
 *
 *	@return 插入成功返回YES，否则返回NO
 */
-(BOOL)insertWithKeyValue:(NSDictionary*)keyValue updateIfExist:(BOOL)update;
/**
 *	@brief 插入多条记录
 *
 *	@param keyValueArray 数组中每一条为要插入的记录的字典表示形式，key为列名称，value为该列的值
 *	@param update 当检测到记录已经存在时，是否更新数据，YES则更新，NO则不更新
 *
 *	@return 插入成功返回YES，否则返回NO
 */
-(BOOL)insertWithKeyValueArray:(NSArray<NSDictionary*>*)keyValueArray updateIfExist:(BOOL)update;
```

#### Delete

```
/**
 *	@brief 删除记录,使用主键作为匹配条件
 *
 *	@param pKeyValues	包含主键信息的字典，其中key为主键字段名称，value为主键的值
 *
 *	@return 删除成功返回YES，否则返回NO
 */
-(BOOL)deleteWithPrimayKeyValues:(NSDictionary *)pKeyValues;
/**
 *	@brief 删除记录
 *
 *	@param condition	where条件，删除所有记录则传nil
 *
 *	@return 删除成功返回YES，否则返回NO
 */
-(BOOL)deleteWithWhereCondition:(DBPWhereCondition*)condition;
```

#### Update

```
/**
 *	@brief 使用具体对象实例作为数据源，更新记录
 *
 *	@param obj				对象实例，该对象实例的类型必须是该表的DBPConvertor所支持转换的类型
 *	@param pKeyValues	包含主键信息的字典，其中key为主键字段名称，value为主键的值
 *
 *	@return 更新成功返回YES，否则返回NO
 */
-(BOOL)updateWithObject:(id)obj primayKeyValues:(NSDictionary *)pKeyValues;
/**
 *	@brief 使用具体对象实例作为数据源，更新记录
 *
 *	@param obj			对象实例，该对象实例的类型必须是该表的DBPConvertor所支持转换的类型
 *	@param conditon	更新的where条件
 *
 *	@return 更新成功返回YES，否则返回NO
 */
-(BOOL)updateWithObject:(id)obj whereCondition:(DBPWhereCondition*)conditon;
/**
 *	@brief 更新记录
 *
 *	@param keyValue		要更新的列信息，key为列名称，value为该列的值
 *	@param pKeyValues	包含主键信息的字典，其中key为主键字段名称，value为主键的值
 *
 *	@return 更新成功返回YES，否则返回NO
 */
-(BOOL)updateWithKeyValue:(NSDictionary *)keyValue primayKeyValues:(NSDictionary *)pKeyValues;
/**
 *	@brief 更新记录
 *
 *	@param keyValue	要更新的列信息，key为列名称，value为该列的值
 *	@param conditon	where条件
 *
 *	@return 更新成功返回YES，否则返回NO
 */
-(BOOL)updateWithKeyValue:(NSDictionary*)keyValue whereCondition:(DBPWhereCondition*)conditon;
```

#### Select

```
/**
 *	@brief 查询记录，以指定的类型返回查询结果
 *
 *	@param pKeyValues	包含主键信息的字典，其中key为主键字段名称，value为主键的值
 *	@param resultClass	返回的数组中所存数据的类型
 *
 *	@return 满足where条件的所有记录组成的数组，每一条均为resultClass类型
 */
-(NSArray*)selectObjectWithPrimayKeyValues:(NSDictionary *)pKeyValues resultClass:(Class)resultClass;
/**
 *	@brief 查询记录，以指定的类型返回查询结果
 *
 *	@param condition		查询的where条件
 *	@param resultClass	返回的数组中所存数据的类型
 *
 *	@return 满足where条件的所有记录组成的数组，每一条均为resultClass类型
 */
-(NSArray*)selectObjectWithWhereCondition:(DBPWhereCondition*)condition resultClass:(Class)resultClass;

/**
 *	@brief 查询记录，以指定的类型返回查询结果
 *
 *	@param criterion		select sql语句构造标准
 *	@param resultClass	返回的数组中所存数据的类型
 *
 *	@return 满足where条件的所有记录组成的数组，每一条均为resultClass类型
 */
-(NSArray*)selectObjectWithCriterion:(DBPSqlCriterion*)criterion resultClass:(Class)resultClass;
/**
 *	@brief 查询记录，以字典数组的形式返回查询结果
 *
 *	@param pKeyValues	包含主键信息的字典，其中key为主键字段名称，value为主键的值
 *
 *	@return  满足where条件的所有记录组成的数组，每一条记录以字典的形式表示，key为列名称，value为该列的值
 */
-(NSArray<NSDictionary*>*)selectWithPrimayKeyValues:(NSDictionary *)pKeyValues;
/**
 *	@brief 查询记录，以字典数组的形式返回查询结果
 *
 *	@param condition	where条件
 *
 *	@return 满足where条件的所有记录组成的数组，每一条记录以字典的形式表示，key为列名称，value为该列的值
 */
-(NSArray<NSDictionary*>*)selectWithWhereCondition:(DBPWhereCondition*)condition;
/**
 *	@brief 查询记录，以字典数组的形式返回查询结果
 *
 *	@param criterion	select sql语句构造标准
 *
 *	@return 满足criterion参数的所有记录组成的数组，每一条记录以字典的形式表示，key为列名称，value为该列的值
 */
-(NSArray<NSDictionary*>*)selectWithCriterion:(DBPSqlCriterion*)criterion;
```

### DBPTableOperatorProtocol
TableOperator协议，所有继承DBPTableOperator的子类必须实现该协议

```
@required
/**
 *	@brief 设置表名称
 *
 *	@return 表名称字符串
 */
-(NSString*)tableName;
/**
 *	@brief 设置表的每一列的列名和数据类型。创建表时会将key和value以"key value"的形式进行组合
 *
 *	@return 包含 列 信息的字典
 *
 *  其中，key为列名，value为数据类型（需要的话，数据类型后面可以有约束，也可以将约束信息放在-(NSDictionary*)constraints方法中），数据类型可设置为TEXT、INTEGER、BLOB
 */
-(NSDictionary*)columns;
/**
 *	@brief 设置表的主键，应该和 -(NSDictionary*)columnInfo方法返回的信息中对主键的设置保持一致
 *
 *	@return 表的主键，以数组的形式返回
 */
-(NSArray*)primaryKeys;
/**
 *	@brief 设置表使用的convertor
 *
 *	@return Class类型必须继承于DBPConvertor，并实现DBPConvertorProtocol协议
 */
-(Class)convertorClass;

@optional
/**
 *	@brief 设置表的约束。创建表时会将key和value以"key value"的形式进行组合
 *
 *	@return 包含 约束 信息的字典
 *
 *  其中，key为PRIMARY KEY、FOREIGN KEY、CHECK、UNIQUE等，value按照写CREATE TABLE sql语句时的写法进行设置
 *
 *  示例：@{@"PRIMARY KEY":@(userId,orderId)}
 */
-(NSDictionary*)constraints;
```

## DBPConvertor
* Convertor类定义了数据库表字段与Model属性之间的对应关系
* 如果直接存取Model对象，则必须为表创建Convertor的子类
* 开发者不会直接使用DBPConvertor的方法，只需要继承该类，并实现DBPConvertorProtocol协议即可

## DBPConvertorProtocol
Convertor协议，所有继承DBPConvertor的子类必须实现该协议

```
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
```

## 使用说明

#### 工程引入FMDB
* 引入方式见[FMDB](https://github.com/ccgus/fmdb)
> 注：由于用到加密功能，需要使用`FMDB/SQLCipher`

#### 工程引入DBPersistance
* 下载DBPersistance文件夹，并将整个文件夹拖入到工程

#### 为每个表创建TableOperator类
* 该类必须继承`DBPTableOperator`，并实现`DBPTableOperatorProtocol`协议
#### 为每个表创建Convertor类
* 该类必须继承`DBPConvertor`，并实现`DBPConvertorProtocol`协议
* 可以为一张表创建多个Convertor，然后在TableOperator的convertorClass方法中写具体使用哪个Convertor的判断逻辑
> Convertor类定义了数据库表字段与Model属性之间的对应关系，会有硬编码问题，为了后期方便维护，建议使用单独的文件定义表名称和字段名称

#### AppDelegate中设置是否启用数据库加密
* 默认为启用
* 设置方法：

```
 [DBPTableOperator setEncrypt:YES/NO];
```

## 使用示例
见Demo
