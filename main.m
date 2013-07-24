// Avoid inclusion of <CarbonCore/AIFF.h> which typedef's ID to a different size than ruby.h
#define __AIFF__

#include <Foundation/Foundation.h>
#include <unistd.h>
#include "ruby.h"

int main()
{
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    chdir([resourcePath UTF8String]);
    NSString *mainPath = [[resourcePath stringByAppendingPathComponent:@"main.rb"] retain];
    [pool drain];

    char *argv[] = { "ruby", (char *)[mainPath UTF8String], 0 };
    int argc = 2;
    
    char **argvPointer = argv;
    ruby_sysinit(&argc, &argvPointer);
    { 
        RUBY_INIT_STACK;
        
        ruby_init();
        
        // Pretend we've already loaded rubygems
        rb_eval_string("$LOADED_FEATURES << 'rubygems.rb'");
        
        // Replace the load path
        rb_eval_string("$LOAD_PATH.clear");
        rb_eval_string("$LOAD_PATH << Dir.pwd");
        rb_eval_string("$LOAD_PATH << $LOAD_PATH[0] + '/lib'");
        
        // Let the application know it is being run from the Mac app wrapper.
        rb_eval_string("OSX_EXECUTABLE = true");

        return ruby_run_node(ruby_options(argc, argv)); 
    }
}
