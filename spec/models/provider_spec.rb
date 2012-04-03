require 'spec_helper'

describe Provider do
  it 'converts a hash to url options' do
    @options      = {user_name: 'user', password: 'pass'}
    Provider.merge_options_for_url(@options).should == '?user_name=user&password=pass'
  end
end
