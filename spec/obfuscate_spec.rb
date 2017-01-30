require_relative "../lib/bp_obfuscate"

RSpec.describe Obfuscate do
  before do
    ENV["SECRET_KEY_BASE"] = "test-key"
  end

  it "can encrypt text" do
    expect(Obfuscate.encrypt("test-data")).to_not eq("test-data")
  end

  it "can decrypt text" do
    expect(Obfuscate.decrypt("rIMK7MWO-u-gLdi7qVKU8A==")).to eq("test-data")
  end
end
