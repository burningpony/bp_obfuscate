# frozen_string_literal: true
require "openssl"
require "base64"

module Obfuscate
  class << self
    def cipher
      OpenSSL::Cipher.new('AES-256-CBC')
    end

    def cipher_key
      if defined?(Rails)
        Rails.application.secrets.secret_key_base
      elsif ENV["SECRET_KEY_BASE"]
        ENV["SECRET_KEY_BASE"]
      else
        raise NoCipherKey, "you must have a an SECRET_KEY_BASE or be in a rails enviroment"
      end
    end

    def decrypt(value)
      c = cipher.decrypt
      c.key = Digest::SHA256.digest(cipher_key)
      c.update(Base64.urlsafe_decode64(value.to_s)) + c.final
    rescue OpenSSL::Cipher::CipherError && ArgumentError
      return nil
    end

    def encrypt(value)
      c = cipher.encrypt
      c.key = Digest::SHA256.digest(cipher_key)
      Base64.urlsafe_encode64(c.update(value.to_s) + c.final)
    end
  end
end
