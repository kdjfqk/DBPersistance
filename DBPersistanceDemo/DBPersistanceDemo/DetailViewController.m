//
//  DetailViewController.m
//  DBPersistanceDemo
//
//  Created by ldy on 17/3/23.
//  Copyright © 2017年 BJYN. All rights reserved.
//

#import "DetailViewController.h"
#import "HCGDatePickerAppearance.h"
#import "LZCityPickerView.h"
#import "LZCityPickerController.h"
#import "UserTableOperator.h"
#import "DBContant.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userIDTF;
@property (strong, nonatomic) IBOutlet UITextField *heightTF;
@property (strong, nonatomic) IBOutlet UIButton *ageBtn;
@property (strong, nonatomic) IBOutlet UIButton *birthdayBtn;
@property (strong, nonatomic) IBOutlet UIButton *addressBtn;
@property (strong, nonatomic) IBOutlet UISwitch *marriedSwitch;
@property (strong, nonatomic) IBOutlet UIButton *editBtn;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UIPickerView *agePicker;

@property (strong, nonatomic) HCGDatePickerAppearance *datePicker;
@property (strong, nonatomic) NSDate *birthday;
@property (strong, nonatomic) Address *address;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self cancelEditState];
    _userIDTF.enabled = NO;
    _datePicker = [[HCGDatePickerAppearance alloc]initWithDatePickerMode:DatePickerDateMode completeBlock:^(NSDate *date) {
        NSString *formatStr = @"yyyy年MM月dd日";
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formatStr];
        [_birthdayBtn setTitle:[dateFormatter stringFromDate:date] forState:UIControlStateNormal];
        _birthday = date;
    }];
    _agePicker.hidden = YES;
    _birthday = _user.birthday;
    _address = _user.address;
    
    [self setUIData];
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

-(void)setUser:(User *)user{
    _user = user;
    [self setUIData];
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
- (IBAction)editBtnClicked:(UIButton*)sender {
    if([sender.currentTitle isEqual: @"编辑"]){
        [self setEditState];
        [sender setTitle:@"更新" forState:UIControlStateNormal];
    }else{
        [self cancelEditState];
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        
        User *user = [[User alloc] init];
        user.userId = [_userIDTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        user.age = [_ageBtn.titleLabel.text integerValue];
        user.birthday = _birthday;
        user.married = _marriedSwitch.isOn;
        user.height = [_heightTF.text floatValue];
        user.address = _address;
        UserTableOperator *tableOper = [[UserTableOperator alloc] init];
        [tableOper insertWithObject:user updateIfExist:YES];
    }
}
- (IBAction)deleteBtnClicked:(UIButton*)sender {
    UserTableOperator *tableOper = [[UserTableOperator alloc] init];
    [tableOper deleteWithPrimayKeyValues:[NSDictionary dictionaryWithObjectsAndKeys:_user.userId,User_Id, nil]];
    [self.navigationController popViewControllerAnimated:YES];
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

-(void)setEditState{
    _ageBtn.enabled = YES;
    _birthdayBtn.enabled = YES;
    _addressBtn.enabled = YES;
    _marriedSwitch.enabled = YES;
    _heightTF.enabled = YES;
}
-(void)cancelEditState{
    _ageBtn.enabled = NO;
    _birthdayBtn.enabled = NO;
    _addressBtn.enabled = NO;
    _marriedSwitch.enabled = NO;
    _heightTF.enabled = NO;
}

-(void)setUIData{
    _userIDTF.text = _user.userId;
    [_ageBtn setTitle:[NSString stringWithFormat:@"%ld",_user.age] forState:UIControlStateNormal];
    NSString *formatStr = @"yyyy年MM月dd日";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatStr];
    [_birthdayBtn setTitle:[dateFormatter stringFromDate:_user.birthday] forState:UIControlStateNormal];
    [_addressBtn setTitle:[NSString stringWithFormat:@"%@%@%@",_user.address.province,_user.address.city,_user.address.area] forState:UIControlStateNormal];
    [_marriedSwitch setOn:_user.married];
    _heightTF.text = [NSString stringWithFormat:@"%f",_user.height];
}

@end
