//
//  RBAdaptFontViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/6/1.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBAdaptFontViewController.h"
#import "RBAdaptFontCell.h"

@interface RBAdaptFontViewController ()

/** 段数组 */
@property (nonatomic, strong) NSMutableArray<RBParagraph *> *paragraphs;

@end

@implementation RBAdaptFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = self.tableView.backgroundColor = [UIColor whiteColor] ;
}

#pragma mark - tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.paragraphs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.paragraphs[indexPath.row].height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RBAdaptFontCell *cell = [RBAdaptFontCell adaptFontCellWithTableView:tableView];

    cell.paragraph = self.paragraphs[indexPath.row];

    return cell;
}


#pragma mark 重写BaseViewController设置内容

- (UIColor *)rbNavigationBackgroundColor:(RBNavigationBar *)navigationBar
{
    return [UIColor RandomColor];
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(RBNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonEvent:(UIButton *)sender navigationBar:(RBNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
}

- (void)titleClickEvent:(UILabel *)sender navigationBar:(RBNavigationBar *)navigationBar
{
    NSLog(@"%@", sender);
}

- (NSMutableAttributedString*)rbNavigationBarTitle:(RBNavigationBar *)navigationBar
{
    return [self changeTitle:@"字体适配"];;
}

- (UIImage *)rbNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(RBNavigationBar *)navigationBar
{
    [leftButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateHighlighted];

    return [UIImage imageNamed:@"navigationButtonReturnClick"];
}



//- (UIImage *)rbNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(RBNavigationBar *)navigationBar
//{
//
//    rightButton.backgroundColor = [UIColor RandomColor];
//
//    return nil;
//}



#pragma mark 自定义代码

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];

    [title addAttribute:NSForegroundColorAttributeName value:[UIColor RandomColor] range:NSMakeRange(0, title.length)];

    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, title.length)];

    return title;
}


- (NSMutableArray<RBParagraph *> *)paragraphs
{
    if(!_paragraphs)
    {
        NSArray *datas = [NSMutableArray arrayWithArray:@[@"苹果公司（Apple Inc. ）是美国一家高科技公司。由史蒂夫·乔布斯、斯蒂夫·沃兹尼亚克和罗·韦恩(Ron Wayne)等人于1976年4月1日创立，并命名为美国苹果电脑公司（Apple Computer Inc. ），2007年1月9日更名为苹果公司，总部位于加利福尼亚州的库比蒂诺。",@"苹果公司1980年12月12日公开招股上市，2012年创下6235亿美元的市值记录，截至2014年6月，苹果公司已经连续三年成为全球市值最大公司。苹果公司在2016年世界500强排行榜中排名第9名。 [1]  2013年9月30日，在宏盟集团的“全球最佳品牌”报告中，苹果公司超过可口可乐成为世界最有价值品牌。2014年，苹果品牌超越谷歌（Google），成为世界最具价值品牌。",@"2016年7月20日，《财富》世界500强排行榜，苹果公司名列第九名 [2]  。2016年9月8日凌晨1点，2016苹果秋季新品发布会在美国旧金山的比尔·格雷厄姆市政礼堂举行 [3]  。10月，苹果公司成为2016年全球100大最有价值品牌第一名。2017年1月6日早晨8点整，“红色星期五”促销活动在苹果官网正式上线，瞬间大量用户涌入官网进行抢购，仅两分钟所有参与活动的耳机便被抢光；2月，Brand Finance发布2017年度全球500强品牌榜单，苹果公司排名第二； [4]  6月7日，2017年《财富》美国500强排行榜发布，苹果公司排名第3位； [5]  7月20日，2017年世界500强排名第9位。 [6]  2018年5月21日，2018年《财富》美国500强排行榜发布，苹果公司位列第四。",@"苹果公司创立之初，主要开发和销售的个人电脑，截至2014年致力于设计、开发和销售消费电子、计算机软件、在线服务和个人计算机。苹果的Apple II于1970年代开启了个人电脑革命，其后的Macintosh接力于1980年代持续发展。该公司硬件产品主要是Mac电脑系列、iPod媒体播放器、iPhone智能手机和iPad平板电脑；在线服务包括iCloud、iTunes Store和App Store；消费软件包括OS X和iOS操作系统、iTunes多媒体浏览器、Safari网络浏览器，还有iLife和iWork创意和生产套件。苹果公司在高科技企业中以创新而闻名世界。",@"1971年，16岁的史蒂夫·乔布斯（Steve Jobs）和21岁的史蒂芬·沃兹涅克（Stephen Wozniak）经朋友介绍而结识。",@"1976年，乔布斯成功说服沃兹装配机器之余跟他去推销，他们另一位朋友，罗·韦恩（Ron Wayne）也加入，三人在1976年4月1 [8]  日组成了苹果电脑公司（Apple Computer Inc.）。同年5月，乔布斯与一间本地电脑商店The Byte Shop洽商，店主保罗·泰瑞尔（Paul Terrell）订购50部后来被称为Apple I的设备，并在交货时支付每部500美元。乔布斯取得了这份订单后，出售自己贵重物品进行筹款，并且说服大型电子零件分销商Cramer Electronics店铺信用部经理，先给零件后付款，最终乔布斯成功的完成这笔交易",@"1977年1月，苹果电脑公司正式注册成为“苹果电脑公司”。同年，沃兹已成功设计出比Apple I更先进的Apple II。乔布斯想将公司扩充并向银行贷款，但韦恩因为冒险投资失败导致的心理阴影而退出了（另一说法为韦恩为了健康选择放弃疯狂的工作）。当时的苹果电脑公司缺乏资金来源。乔布斯最后遇到麦克·马库拉（Mike Markkula），麦克·马库拉注资9.2万美元并和乔布斯联合签署了25万美元的银行贷款。",@"2012年4月，苹果以超过5200亿美元的市值稳坐世界第一的位置。6月12日凌晨1时（北京时间），苹果公司在旧金山举办的全球开发者大会（WWDC）上正式发布新一代移动操作系统iOS 6，并推出全新MacBook Pro笔记本电脑等新产品，以及自主研发的3D地图应用。 [15]  9月12日，苹果发布了新一代iPhone5以及iPod touch 5。官网停售iPhone3GS并宣布停产iPhone3GS。9月20日（北京时间），苹果公司新系统iOS 6正式上线更新。"]];

        _paragraphs = [NSMutableArray array];
        __weak typeof (self) weakSelf = self ;
        [datas enumerateObjectsUsingBlock:^(NSString  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            RBParagraph *pa = [[RBParagraph alloc] init];
            pa.words = obj;
            pa.date = [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
            [weakSelf.paragraphs addObject:pa];
        }];
    }
    return _paragraphs;
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
