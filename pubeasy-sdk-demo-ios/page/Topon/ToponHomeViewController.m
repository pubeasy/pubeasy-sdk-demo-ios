#import "ToponHomeViewController.h"
#import "ToponInterstitialViewController.h"
#import "ToponRewardedViewController.h"
#import "ToponBannerViewController.h"
#import "ToponSplashViewController.h"
#import "ToponNativeViewController.h"

@interface ToponHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *items;

@end

@implementation ToponHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Topon";

    self.items = @[ @"Interstitial", @"Rewarded", @"Banner", @"Splash", @"Native" ];

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.items[indexPath.row];
    UIViewController *vc = nil;
    if ([title isEqualToString:@"Interstitial"]) {
        vc = [[ToponInterstitialViewController alloc] init];
    } else if ([title isEqualToString:@"Rewarded"]) {
        vc = [[ToponRewardedViewController alloc] init];
    } else if ([title isEqualToString:@"Banner"]) {
        vc = [[ToponBannerViewController alloc] init];
    } else if ([title isEqualToString:@"Splash"]) {
        vc = [[ToponSplashViewController alloc] init];
    } else if ([title isEqualToString:@"Native"]) {
        vc = [[ToponNativeViewController alloc] init];
    }
    if (vc != nil) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end


