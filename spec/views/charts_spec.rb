require 'spec_helper'

describe "charts/index" do

  it "uses data stored in @chart_data_points" do
    yes = 'supercalifragilisticexpialidocious'
    assign :chart_data_points, yes
    render
    rendered.should =~ Regexp.new(yes)
  end

end
