# typed: strict
# frozen_string_literal: true

require "oj"

module ShopifyAPI
  module Auth
    class FileSessionStorage
      extend T::Sig
      extend T::Helpers
      include ShopifyAPI::Auth::SessionStorage

      sig { params(path: String).void }
      def initialize(path: "/tmp/shopify_api_sessions")
        @path = path
        FileUtils.mkdir_p(path) unless Dir.exist?(path)
      end

      sig do
        override.params(session: Session)
          .returns(T::Boolean)
      end
      def store_session(session)
        File.write(session_file_path(session.id), Oj.dump(session)) > 0
      end

      sig do
        override.params(id: String)
          .returns(T.nilable(Session))
      end
      def load_session(id)
        session_path = session_file_path(id)
        if File.exist?(session_path)
          Oj.load(File.read(session_path))
        end
      end

      sig do
        override.params(id: String)
          .returns(T::Boolean)
      end
      def delete_session(id)
        session_path = session_file_path(id)
        File.delete(session_path) if File.exist?(session_path)
        true
      end

      private

      sig do
        params(id: String)
          .returns(String)
      end
      def session_file_path(id)
        "#{@path}/#{id}"
      end
    end
  end
end
