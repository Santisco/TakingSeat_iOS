


#import <Foundation/Foundation.h>

@protocol DropDownChooseDelegate <NSObject>

@optional

-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index;
@end

@protocol DropDownChooseDataSource <NSObject>
-(NSInteger)numberOfSections;
-(NSInteger)numberOfRowsInSection:(NSInteger)section;
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index;
-(NSInteger)defaultShowSection:(NSInteger)section;

@end



