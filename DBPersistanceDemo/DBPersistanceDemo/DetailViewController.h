//
//  DetailViewController.h
//  DBPersistanceDemo
//
//  Created by ldy on 17/3/23.
//  Copyright © 2017年 BJYN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface DetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) User *user;

@end
