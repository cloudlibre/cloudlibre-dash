require 'rails_helper'

RSpec.describe "zones/index", type: :view do
  before(:each) do
    assign(:zones, [
      Zone.create!(
        :name => "MyText"
      ),
      Zone.create!(
        :name => "MyText"
      )
    ])
  end

  it "renders a list of zones" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
