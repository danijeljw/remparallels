//
//  main.m
//  Bye, Parallels!
//
//  Created by Danijel James on 10/11/2013.
//  Copyright (c) 2013 Danijel James. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, const char * argv[])
{
    [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
    return NSApplicationMain(argc, argv);
}
