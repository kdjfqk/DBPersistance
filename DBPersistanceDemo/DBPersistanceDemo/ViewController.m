//
//  ViewController.m
//  DBPersistanceDemo
//
//  Created by ldy on 17/3/21.
//  Copyright © 2017年 BJYN. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "DetailViewController.h"
#import "HCGDatePickerAppearance.h"
#import "LZCityPickerView.h"
#import "LZCityPickerController.h"
#import "UserTableOperator.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userIDTF;
@property (strong, nonatomic) IBOutlet UITextField *heightTF;
@property (strong, nonatomic) IBOutlet UIButton *ageBtn;
@property (strong, nonatomic) IBOutlet UIButton *birthdayBtn;
@property (strong, nonatomic) IBOutlet UIButton *addressBtn;
@property (strong, nonatomic) IBOutlet UISwitch *marriedSwitch;
@property (strong, nonatomic) IBOutlet UIButton *insertBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIPickerView *agePicker;

@property (strong, nonatomic) HCGDatePickerAppearance *datePicker;

@property (strong, nonatomic) NSArray<User*> *users;
@property (strong, nonatomic) NSDate *birthday;
@property (strong, nonatomic) Address *address;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.tableFooterView = [[UIView alloc] init];
    
    _agePicker.hidden = YES;
    
    _datePicker = [[HCGDatePickerAppearance alloc]initWithDatePickerMode:DatePickerDateMode completeBlock:^(NSDate *date) {
        NSString *formatStr = @"yyyy年MM月dd日";
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formatStr];
        [_birthdayBtn setTitle:[dateFormatter stringFromDate:date] forState:UIControlStateNormal];
        _birthday = date;
    }];
}


-(void)viewWillAppear:(BOOL)animated{
    UserTableOperator *tableOper = [[UserTableOperator alloc] init];
    _users = [tableOper selectObjectWithWhereCondition:nil resultClass:[User class]];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ageBtnClicked:(id)sender {
    _agePicker.hidden = NO;
}

- (IBAction)birthdayBtnClicked:(id)sender {
    [_datePicker show];
}

- (IBAction)addressBtnClicked:(id)sender {
    [LZCityPickerController showPickerInViewController:self selectBlock:^(NSString *address, NSString *province, NSString *city, NSString *area) {
        // 选择结果回调
        if(_address == nil){
            _address = [[Address alloc] init];
        }
        _address.province = province;
        _address.city = city;
        _address.area = area;
        [self.addressBtn setTitle:address forState:UIControlStateNormal];
    }];
}

- (IBAction)insertBtnClicked:(id)sender {
    User *user = [[User alloc] init];
    user.userId = [_userIDTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    user.age = [_ageBtn.titleLabel.text integerValue];
    user.birthday = _birthday;
    user.married = _marriedSwitch.isOn;
    user.height = [_heightTF.text floatValue];
    user.address = _address;
    
    UserTableOperator *tableOper = [[UserTableOperator alloc] init];
    [tableOper insertWithObject:user updateIfExist:YES];
    
    _users = [tableOper selectObjectWithWhereCondition:nil resultClass:[User class]];
    [_tableView reloadData];
}

#pragma UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _users[indexPath.row].userId;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewControllerID"];
    detailVC.user = _users[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 100;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%ld",row+1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _agePicker.hidden = YES;
    [_ageBtn setTitle:[NSString stringWithFormat:@"%ld",row+1] forState:UIControlStateNormal];
}

#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
