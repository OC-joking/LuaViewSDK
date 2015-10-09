//
//  LVCustomLoadingView.m
//  LVSDK
//
//  Created by dongxicheng on 7/20/15.
//  Copyright (c) 2015 dongxicheng. All rights reserved.
//

#import "LVCustomLoading.h"
#import "LView.h"
#import "LVBaseView.h"

@implementation LVCustomLoading

static Class g_class = nil;

+ (void) setDefaultStyle:(Class) c{
    if( [c isSubclassOfClass:[LVCustomLoading class]] ){
        g_class = c;
    }
}

static int lvNewLoadingView (lv_State *L) {
    {
        if( g_class == nil ) {
            g_class = [LVCustomLoading class];
        }
        CGRect r = CGRectMake(0, 0, 0, 0);
        if( lv_gettop(L)>=4 ) {
            r = CGRectMake(lv_tonumber(L, 1), lv_tonumber(L, 2), lv_tonumber(L, 3), lv_tonumber(L, 4));
        }
        LVCustomLoading* loadingView = [[g_class alloc] initWithFrame:r];
        
        {
            NEW_USERDATA(userData, LVUserDataView);
            userData->view = CFBridgingRetain(loadingView);
            
            lvL_getmetatable(L, META_TABLE_LoadingView );
            lv_setmetatable(L, -2);
        }
        LView* view = (__bridge LView *)(L->lView);
        if( view ){
            [view containerAddSubview:loadingView];
        }
    }
    return 1; /* new userdatum is already on the stack */
}

+(int) classDefine:(lv_State *)L {
    {
        lv_pushcfunction(L, lvNewLoadingView);
        lv_setglobal(L, "UICustomLoading");
    }
    const struct lvL_reg memberFunctions [] = {
        {NULL, NULL}
    };
    
    lv_createClassMetaTable(L, META_TABLE_LoadingView);
    
    lvL_openlib(L, NULL, [LVBaseView baseMemberFunctions], 0);
    lvL_openlib(L, NULL, memberFunctions, 0);
    return 1;
}

@end





