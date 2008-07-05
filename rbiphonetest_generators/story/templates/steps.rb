require "<%= class_name %>.bundle"
OSX::ns_import :<%= class_name %>

steps_for(:<%= name %>) do
  Given "a <%= class_name %> instance" do
    @tame = OSX::<%= class_name %>.alloc.init
  end
end