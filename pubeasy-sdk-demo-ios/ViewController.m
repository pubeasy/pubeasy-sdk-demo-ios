//
//  ViewController.m
//  pubeasy-sdk-demo-ios
//
//  Created by gy on 2025/9/2.
//

#import "ViewController.h"
#import "page/Pubeasy/PubeasyHomeViewController.h"
#import "page/Admob/AdmobHomeViewController.h"
#import "page/Topon/ToponHomeViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Demo";

    self.items = @[ @"Pubeasy", @"Admob", @"Topon" ];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.items[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *item = self.items[indexPath.row];
    if ([item isEqualToString:@"Pubeasy"]) {
        UIViewController *vc = [[PubeasyHomeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([item isEqualToString:@"Admob"]) {
        UIViewController *vc = [[AdmobHomeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([item isEqualToString:@"Topon"]) {
        UIViewController *vc = [[ToponHomeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

@end
