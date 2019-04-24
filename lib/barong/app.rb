# frozen_string_literal: true

module Barong
  class App
    class Error < ::StandardError; end

    class << self
      def define
        yield self
      end

      def set(key, default = nil)
        $config ||= OpenStruct.new

        if by_env(key)
          $config[key] = by_env(key)

        elsif Rails.application.credentials[key]
          config[key] = Rails.application.credentials[key]

        else
          raise Error, "Config #{key} missing" unless default
          $config[key] = default

        end
      end

      def by_env(key)
        ENV[key.to_s.upcase]
      end

      def config
        $config ||= OpenStruct.new
        $config
      end
    end
  end
end
