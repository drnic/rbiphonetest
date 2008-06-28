//
//  <%= class_name %>.h
//  <%= class_name %>
//
//  Created by FIXME on <%= Date.today %>.
//  Copyright <%= Date.today.year %> FIXME. All rights reserved.
//

#import "<%= class_name %>.h"


@implementation <%= class_name %>

@end

// This initialization function gets called when we import the Ruby module.
// It doesn't need to do anything because the RubyCocoa bridge will do
// all the initialization work.
// The iphoneruby test framework automatically generates bundles for 
// each objective-c class containing the following line. These
// can be used by your tests.
void Init_<%= class_name %>() { }