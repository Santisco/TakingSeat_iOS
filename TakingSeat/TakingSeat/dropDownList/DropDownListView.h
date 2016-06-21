

#import <UIKit/UIKit.h>
#import "DropDownChooseProtocol.h"


#define SECTION_BTN_TAG_BEGIN   1000
#define SECTION_IV_TAG_BEGIN    3000
@interface DropDownListView : UIView<UITableViewDelegate,UITableViewDataSource>{
     //NSInteger currentExtendSection;//当前展开的section ，默认－1时，表示都没有展开
}

@property (nonatomic, assign) id<DropDownChooseDelegate> dropDownDelegate;
@property (nonatomic, assign) id<DropDownChooseDataSource> dropDownDataSource;
@property (nonatomic, assign) NSInteger currentExtendSection;
@property (nonatomic, strong) UIView *mSuperView;
@property (nonatomic, strong) UIView *mTableBaseView;
@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) UIButton *mbutton;
@property (nonatomic, strong) UIButton *nbutton;
@property (nonatomic,strong)NSString *sectionBtnTitle;
@property (nonatomic,strong)NSString *chooseCellTitle;

- (id)initWithFrame:(CGRect)frame dataSource:(id)datasource delegate:(id) delegate;
- (void)setTitle:(NSString *)title inSection:(NSInteger) section;

- (BOOL)isShow;
- (void)hideExtendedChooseView;

@end
