#import "KsirPlugin.h"
#if __has_include(<ksir/ksir-Swift.h>)
#import <ksir/ksir-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ksir-Swift.h"
#endif

@implementation KsirPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftKsirPlugin registerWithRegistrar:registrar];
}
@end
