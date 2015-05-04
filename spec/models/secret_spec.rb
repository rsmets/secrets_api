require 'spec_helper'

describe Secret do
  let(:secret) { FactoryGirl.build :secret }
  subject { secret }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:published) }
  it { should respond_to(:user_id) }

  it { should not_be_published }

  it { should validate_presence_of :title }
  it { should validate_presence_of :description}
  it { should validate_presence_of :user_id }

end