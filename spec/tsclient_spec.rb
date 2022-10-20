# frozen_string_literal: true

require "spec_helper"

describe Tsclient do
  it "has a version number" do
    value(Tsclient::VERSION).wont_be_nil
  end
end
