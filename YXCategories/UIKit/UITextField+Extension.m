//
//  UITextField+Extension.m
//  YXCategoriesDemo
//
//  Created by JiaQi on 2016/11/15.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "UITextField+Extension.h"
#import <objc/runtime.h>

@interface UITextField ()
@property (nonatomic, copy) void (^editingChanged)(UITextField *);
@end

@implementation UITextField (Extension)
#pragma mark - UIControlEventEditingChanged
/**
 编辑改变的时候执行block回调
 event == UIControlEventEditingChanged
 @param action 回调
 */
- (void)addEditingChangedAction:(void (^)(UITextField *textField))action;
{
    self.editingChanged = action;
    [self addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
}

static char *kEditingChangedAction = "kEditingChangedAction";
- (void)setEditingChanged:(void (^)(UITextField *))editingChanged
{
    objc_setAssociatedObject(self, kEditingChangedAction, editingChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UITextField *))editingChanged
{
    return objc_getAssociatedObject(self, kEditingChangedAction);
}

- (void)editingChanged:(UITextField *)tf
{
    if (self.editingChanged) {
        self.editingChanged(tf);
    }
}
@end
