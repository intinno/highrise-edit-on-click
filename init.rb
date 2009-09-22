require File.dirname(__FILE__) + "/lib/common"
require File.dirname(__FILE__) + "/lib/edit_on_click"
ActionView::Helpers.send :include, HighriseStyle::Helpers::EditOnClick
ActionView::Helpers::FormBuilder.send :include, HighriseStyle::FormBuilder::EditOnClick
