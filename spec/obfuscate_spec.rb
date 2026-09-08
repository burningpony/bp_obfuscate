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

  it "returns nil when decrypting garbage" do
    expect(Obfuscate.decrypt("not-real-ciphertext")).to be_nil
  end

  context "without any key available" do
    before { ENV.delete("SECRET_KEY_BASE") }

    it "raises NoCipherKey" do
      expect { Obfuscate.encrypt("test-data") }.to raise_error(BpObfuscate::NoCipherKey)
    end
  end

  context "in a Rails 7.1+ application, where Rails.application.secrets is gone" do
    let(:application) { double("application", secret_key_base: "test-key") }

    before do
      ENV.delete("SECRET_KEY_BASE")
      stub_const("Rails", double("Rails", application: application))
    end

    it "reads the key from Rails.application.secret_key_base" do
      expect(Obfuscate.decrypt("rIMK7MWO-u-gLdi7qVKU8A==")).to eq("test-data")
    end
  end

  context "in a legacy Rails application that only exposes secrets" do
    let(:secrets) { double("secrets", secret_key_base: "test-key") }
    let(:application) { double("application", secrets: secrets) }

    before do
      ENV.delete("SECRET_KEY_BASE")
      stub_const("Rails", double("Rails", application: application))
    end

    it "falls back to Rails.application.secrets.secret_key_base" do
      expect(Obfuscate.decrypt("rIMK7MWO-u-gLdi7qVKU8A==")).to eq("test-data")
    end
  end
end
