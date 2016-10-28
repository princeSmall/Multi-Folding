//
//  ViewController.m
//  二级联动
//
//  Created by tongle on 2016/10/26.
//  Copyright © 2016年 tongle. All rights reserved.
//

#import "ViewController.h"
#import "HeaderFooterView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView1;
@property (nonatomic,strong)UITableView * tableView2;
@property (nonatomic,strong)NSArray * numberArray1;
@property (nonatomic,strong)NSArray * numberArray2;
@property (nonatomic,strong)NSMutableDictionary * foldDictionary;
@property (nonatomic,strong)UIButton * btn;


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.btn = [[UIButton alloc]init];
    _foldDictionary= [NSMutableDictionary dictionaryWithDictionary:@{
                                                  @"0":@"0",
                                                  @"1":@"0"}];
    self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 0.25*self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView1.delegate =self;
    self.tableView1.dataSource =self;
    self.numberArray1=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    [self.view addSubview:self.tableView1];
    self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0.25*self.view.frame.size.width, 64, 0.75*self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView2.delegate =self;
    self.tableView2.dataSource =self;
    self.numberArray2=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    [self.view addSubview:self.tableView2];


}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    NSInteger rows = [self.tableView2 numberOfRowsInSection:indexPath.row];
    if (rows == 0) {
        return;
    }
    if (tableView==self.tableView1) {
           NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
             [self.tableView2 selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.tableView1) {
        return 0.00000000001;
    }
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString * key = [NSString stringWithFormat:@"%ld",(long)section];
    BOOL fold = [[_foldDictionary objectForKey:key]boolValue];
    if (tableView==self.tableView2) {
        if (section==0) {
            return fold? 0:self.numberArray2.count;
        }
        if (section==1) {
            return fold? 0:self.numberArray2.count;
        }if (section==2) {
            return fold? 0:self.numberArray2.count;
        }if (section==3) {
            return fold? 0:self.numberArray2.count;
        }if (section==4) {
            return fold? 0:self.numberArray2.count;
        }if (section==5) {
            return fold? 0:self.numberArray2.count;
        }if (section==6) {
            return fold? 0:self.numberArray2.count;
        }if (section==7) {
            return fold? 0:self.numberArray2.count;
        }
        else
            return self.numberArray2.count;
       
    }else
        return self.numberArray1.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tableView2) {
        return self.numberArray2.count;
    }else
        return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeaderFooterView * headView = [[HeaderFooterView alloc]init];
   headView.frame =CGRectMake(0, 0, self.tableView2.frame.size.width, self.tableView2.frame.size.height);
    NSString *key = [NSString stringWithFormat:@"%ld",section];
    BOOL fold =[[ _foldDictionary objectForKey:key]boolValue];
    headView.fold = fold;
    headView.layer.borderWidth = 1;
    headView.layer.borderColor = [UIColor grayColor].CGColor;
    [headView addBtn:_btn andSection:section canFold:YES];
    headView.btn.tag = section +100;
    [headView.btn setTitle:[NSString stringWithFormat:@"%ld",section] forState:UIControlStateNormal];
    [headView.btn addTarget:self action:@selector(foldView:) forControlEvents:UIControlEventTouchUpInside];
    return headView;
}
-(void)foldView:(UIButton *)sender{
    NSLog(@"%ld",sender.tag);
    NSString *key = [NSString stringWithFormat:@"%d",(int)sender.tag-100];
    BOOL fold =[[ _foldDictionary objectForKey:key]boolValue];
    NSString * foldString = fold ? @"0" : @"1";
    [_foldDictionary setValue:foldString forKey:key];
    NSMutableIndexSet *set = [NSMutableIndexSet indexSetWithIndex:(int)sender.tag-100];
    [self.tableView2 reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
   
   
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return  nil;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (tableView == self.tableView1) {
        cell.textLabel.text = self.numberArray1[indexPath.row];
    }else{
        cell.textLabel.text = self.numberArray2[indexPath.row];
    }
    
    return cell;
}
















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
