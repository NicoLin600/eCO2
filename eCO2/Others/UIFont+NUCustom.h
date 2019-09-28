//
//  UIFont+Custom.h
//  
//
//  Created by Nico Lin on 8/7/15.
//
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface UIFont (NUCustom)
/*
TTF（TrueTypeFont）是一种字库名称。TTF（TrueTypeFont）是Apple公司和Microsoft公司共同推出的字体文件格式，随着windows的流行，已经变成最常用的一种字体文件表示方式。

TTC字体是TrueType字体集成文件(. TTC文件)，是在一单独文件结构中包含多种字体,以便更有效地共享轮廓数据,当多种字体共享同一笔画时,TTC技术可有效地减小字体文件的大小。
TTC是几个TTF合成的字库，安装后字体列表中会看到两个以上的字体。两个字体中大部分字都一样时，可以将两种字体做成一个TTC文件，常见的TTC字体，因为共享笔划数据，所以大多这个集合中的字体区别只是字符宽度不一样，以便适应不同的版面排版要求。
 */
//TTF
//+ (UIFont*)customFontWithPath:(NSString*)path size:(CGFloat)size fontStyle:(FontStyle)fontStyle;

+ (UIFont*)customFontWithPath:(NSString*)path size:(CGFloat)size;

//上面的方法对于TTF、OTF的字体都有效，但是对于TTC字体，只取出了一种字体。因为TTC字体是一个相似字体的集合体，一般是字体的组合。所以如果对字体要求比较高，所以可以用下面的方法把所有字体取出来：
//TTC
+ (NSArray*)customFontArrayWithPath:(NSString*)path size:(CGFloat)size;

@end
