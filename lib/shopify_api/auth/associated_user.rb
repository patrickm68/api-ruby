# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    class AssociatedUser < T::Struct
      extend T::Sig

      prop :id, Integer
      prop :first_name, String
      prop :last_name, String
      prop :email, String
      prop :email_verified, T::Boolean
      prop :account_owner, T::Boolean
      prop :locale, String
      prop :collaborator, T::Boolean

      alias_method :eql?, :==
      sig { params(other: AssociatedUser).returns(T::Boolean) }
      def ==(other)
        id == other.id &&
          first_name == other.first_name &&
          last_name == other.last_name &&
          email == other.email &&
          email_verified == other.email_verified &&
          account_owner == other.account_owner &&
          locale == other.locale &&
          collaborator == other.collaborator
      end
    end
  end
end
