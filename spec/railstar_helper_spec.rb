require './lib/railstar_helper'
require 'erb'
include RailstarHelper
include ERB::Util


describe RailstarHelper do
  it '改行コードをBRタグに変換できること' do
    text = <<-EOF
abcd
efghi
jklm
EOF
    hbr(text).should == "abcd<br />efghi<br />jklm<br />"
  end
end
