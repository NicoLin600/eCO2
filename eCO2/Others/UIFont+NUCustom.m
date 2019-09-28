//
//  UIFont+Custom.m
//  
//
//  Created by Nico Lin on 8/7/15.
//
//

#import "UIFont+NUCustom.h"

@implementation UIFont (NUCustom)

//+ (UIFont*)customFontWithPath:(NSString*)path size:(CGFloat)size
//{
//    return [self customFontWithPath:path size:size];
//}


+ (UIFont*)customFontWithPath:(NSString*)path size:(CGFloat)size
//                    fontStyle:(FontStyle)fontStyle
{
    NSURL *fontUrl = [NSURL fileURLWithPath:path];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    if (fontDataProvider == nil)
    {
        return nil;
    }
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
//    UIFont *font = [UIFont fontWithName:fontName size:size fontStyle:fontStyle];
    UIFont *font = [UIFont fontWithName:fontName size:size];
    CGFontRelease(fontRef);
    return font;
}


+ (NSArray*)customFontArrayWithPath:(NSString*)path size:(CGFloat)size
{
    CFStringRef fontPath = CFStringCreateWithCString(NULL, [path UTF8String], kCFStringEncodingUTF8);
    CFURLRef fontUrl = CFURLCreateWithFileSystemPath(NULL, fontPath, kCFURLPOSIXPathStyle, 0);
    CFRelease(fontPath);
    CFArrayRef fontArray =CTFontManagerCreateFontDescriptorsFromURL(fontUrl);
    CFRelease(fontUrl);
    CTFontManagerRegisterFontsForURL(fontUrl, kCTFontManagerScopeNone, NULL);
    NSMutableArray *customFontArray = [NSMutableArray array];
    for (CFIndex i = 0 ; i < CFArrayGetCount(fontArray); i++){
        CTFontDescriptorRef  descriptor = CFArrayGetValueAtIndex(fontArray, i);
        CTFontRef fontRef = CTFontCreateWithFontDescriptor(descriptor, size, NULL);
        NSString *fontName = CFBridgingRelease(CTFontCopyName(fontRef, kCTFontPostScriptNameKey));
        CFRelease(fontRef);
        UIFont *font = [UIFont fontWithName:fontName size:size];
        [customFontArray addObject:font];
    }
    CFRelease(fontArray);
    
    return customFontArray;
}


@end
