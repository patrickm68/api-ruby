# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    class Session
      extend T::Sig

      sig { returns(String) }
      attr_reader :id

      sig { returns(T.nilable(String)) }
      attr_accessor :state, :access_token

      sig { returns(String) }
      attr_accessor :shop

      sig { returns(AuthScopes) }
      attr_accessor :scope

      sig { returns(T.nilable(AuthScopes)) }
      attr_accessor :associated_user_scope

      sig { returns(T.nilable(Time)) }
      attr_accessor :expires

      sig { returns(T.nilable(AssociatedUser)) }
      attr_accessor :associated_user

      sig { returns(T::Boolean) }
      def online?
        @is_online
      end

      sig do
        params(
          shop: String,
          id: T.nilable(String),
          state: T.nilable(String),
          access_token: T.nilable(String),
          scope: T.any(T::Array[String], String),
          associated_user_scope: T.nilable(T.any(T::Array[String], String)),
          expires: T.nilable(Time),
          is_online: T.nilable(T::Boolean),
          associated_user: T.nilable(AssociatedUser)
        ).void
      end
      def initialize(shop:, id: nil, state: nil, access_token: "",
        scope: [], associated_user_scope: nil, expires: nil, is_online: nil, associated_user: nil)
        @id = T.let(id || SecureRandom.uuid, String)
        @shop = shop
        @state = state
        @access_token = access_token
        @scope = T.let(AuthScopes.new(scope), AuthScopes)
        @associated_user_scope = T.let(
          associated_user_scope.nil? ? nil : AuthScopes.new(associated_user_scope), T.nilable(AuthScopes)
        )
        @expires = expires
        @associated_user = associated_user
        @is_online = T.let(is_online || !associated_user.nil?, T::Boolean)
      end

      sig { returns(String) }
      def serialize
        Oj.dump(self)
      end

      sig { params(str: String).returns(Session) }
      def self.deserialize(str)
        Oj.load(str)
      end

      sig do
        params(
          shop: String
        ).returns(Auth::Session)
      end
      def self.create_for_private_app(shop:)
        Session.new(shop: shop, access_token: Context.api_secret_key, scope: Context.scope.to_a)
      end

      alias_method :eql?, :==
      sig { params(other: T.nilable(Session)).returns(T::Boolean) }
      def ==(other)
        if other
          T.must(
            id == other.id &&
            shop == other.shop &&
            state == other.state &&
            scope == other.scope &&
            associated_user_scope == other.associated_user_scope &&
            (!(expires.nil? ^ other.expires.nil?) && (expires.nil? || expires.to_i == other.expires.to_i)) &&
            online? == other.online? &&
            associated_user == other.associated_user
          )
        else
          false
        end
      end
    end
  end
end
