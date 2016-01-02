require 'rails_helper'
require 'spec_helper'
require 'visit'

RSpec.describe Hosting, type: :model do

  before(:each) do
    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.add_stub(
      "11211", [{'latitude' => 40.7093358, 'longitude' => -73.9565551}]
    )

    Geocoder::Lookup::Test.add_stub(
      "9131", [{'latitude' => 0, 'longitude' => 0}]
    )
  end

  it "has a valid factory" do
    expect(FactoryGirl.create(:hosting, zipcode: "11211")).to be_valid
  end

  it "is invalid without a zipcode" do
    expect { FactoryGirl.create(:hosting, zipcode: nil) }
      .to raise_error ActiveRecord::RecordInvalid
  end

  it "is invalid with bad zipcode" do
    expect { FactoryGirl.create(:hosting, zipcode: "9131") }
      .to raise_error ActiveRecord::RecordInvalid
  end
end
