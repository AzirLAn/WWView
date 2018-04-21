//
//  ListCarInfoViewController.m
//  在view绘制图形区分点击事件
//
//  Created by cheBaidu on 2018/4/21.
//  Copyright © 2018年 车佰度. All rights reserved.
//

#import "ListCarInfoViewController.h"
#import "TNCustomSegment.h"

@interface ListCarInfoViewController ()<UITableViewDelegate,UITableViewDataSource,TNCustomSegmentDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation ListCarInfoViewController
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
      
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
 
    NSArray *items = @[@"第一",@"第二"];
    
    TNCustomSegment *segment = [[TNCustomSegment alloc] initWithItems:items withFrame:CGRectMake(10, 80, [UIScreen mainScreen].bounds.size.width - 20, 40) withSelectedColor:nil withNormolColor:nil withFont:nil];
    segment.delegate = self;
    segment.selectedIndex = 1;
    [self.view addSubview:segment];
    [self.view addSubview:_tableView];
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(segment.frame) + 5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(segment.frame) + 5);
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.selectIndex == 0) {
        return 5;
    }else if (self.selectIndex == 1){
        return 10;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld_____%ld",self.selectIndex,indexPath.row];
    
    return cell;
}

#pragma mark - TNCustomsegmentDelegate
- (void)segment:(TNCustomSegment *)segment didSelectedIndex:(NSInteger)selectIndex{
    
    self.selectIndex = selectIndex;
    
    [self.tableView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
