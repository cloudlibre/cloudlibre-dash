require 'rails_helper'

RSpec.describe "zones/show", type: :view do
  before(:each) do
    @zone = assign(:zone, Zone.create!(
      :name => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
  end
end
