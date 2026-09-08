# frozen_string_literal: true
require "openssl"
require "base64"
require "digest"

module Obfuscate
  class << self
    def cipher
      OpenSSL::Cipher.new('AES-256-CBC')
    end

    def cipher_key
      rails_cipher_key || ENV["SECRET_KEY_BASE"] ||
        raise(BpObfuscate::NoCipherKey, "you must have a an SECRET_KEY_BASE or be in a rails enviroment")
    end

    def decrypt(value)
      c = cipher.decrypt
      c.key = Digest::SHA256.digest(cipher_key)
      c.update(Base64.urlsafe_decode64(value.to_s)) + c.final
    rescue OpenSSL::Cipher::CipherError, ArgumentError
      nil
    end

    def encrypt(value)
      c = cipher.encrypt
      c.key = Digest::SHA256.digest(cipher_key)
      Base64.urlsafe_encode64(c.update(value.to_s) + c.final)
    end

    private

    # Rails.application.secrets was removed in Rails 7.1, so read the key from
    # the application itself, which resolves credentials/ENV on every version
    # since Rails 4.1.
    def rails_cipher_key
      return nil unless defined?(Rails) && Rails.respond_to?(:application) && Rails.application

      if Rails.application.respond_to?(:secret_key_base)
        Rails.application.secret_key_base
      elsif Rails.application.respond_to?(:secrets)
        Rails.application.secrets.secret_key_base
      end
    end
  end
end
