//
//  JSFileConfig.m
//  百大悦城
//
//  Created by 文长林 on 2018/5/31.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "JSFileConfig.h"

@implementation JSFileConfig

+ (instancetype)fileConfigWithfileData:(NSData *)fileData
                                  name:(NSString *)name
                              fileName:(NSString *)fileName
                              mimeType:(NSString *)mimeType {
    
    return [[self alloc] initWithfileData:fileData
                                     name:name
                                 fileName:fileName
                                 mimeType:mimeType];
}

- (instancetype)initWithfileData:(NSData *)fileData
                            name:(NSString *)name
                        fileName:(NSString *)fileName
                        mimeType:(NSString *)mimeType {
    
    if (self = [super init]) {
        
        _fileData = fileData;
        _name = name;
        _fileName = fileName;
        _mimeType = mimeType;
    }
    return self;
}
@end
