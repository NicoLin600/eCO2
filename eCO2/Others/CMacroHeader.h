//
//  CMacroHeader.h
//  Carbon
//
//  Created by Nic on 28/09/2019.
//  Copyright © 2019 NicLin. All rights reserved.
//

#ifndef CMacroHeader_h
#define CMacroHeader_h

typedef NS_ENUM(NSUInteger, CVehicleType) {
    CCar = 1100,
    CBus,
    CSUV
};

#define CScreenBounds                  [[UIScreen mainScreen] bounds]
#define CScreenSize                    [[UIScreen mainScreen] bounds].size
#define CScreenScale                   [UIScreen  mainScreen].scale
#define CScreenWidth                   [UIScreen mainScreen].bounds.size.width
#define CScreenHeight                  [UIScreen mainScreen].bounds.size.height
#define DeviceIsX                       (CScreenHeight >= 812.0f && CScreenWidth >= 375.0f)


#define CTopEdge                       (DeviceIsX ? ((40.0f) * [UIScreen mainScreen].bounds.size.height / 812.0f) : 0.0f)
#define CMainTopHeight                 (82.0f + CTopEdge)
#define CEdgePadding                   15.0f
#define CTopTextPadding                (40.0f + CTopEdge*2/3)

#define CRGBAColor(r,g,b,a)            [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define CRGBColor(r,g,b)               [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(1.0f)]
#define CRedColor       CRGBColor(178, 34, 34)
#define CGreenColor     CRGBColor(50, 205, 50)
#define CBlackColor     CRGBAColor(0, 0, 0, 0.6)

#define CFont(num)   [UIFont customFontWithPath:[[NSBundle mainBundle] pathForResource:@"ClarendonLTStd-Light" ofType:@"otf"] size:num]

#endif /* CMacroHeader_h */
