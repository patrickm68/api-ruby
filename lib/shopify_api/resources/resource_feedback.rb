# frozen_string_literal: true

module ShopifyAPI
  class ResourceFeedback < Base
    class ExistingFeedbackSaved < StandardError; end
    include DisablePrefixCheck

    STATE_SUCCESS = 'success'
    STATE_REQUIRES_ACTION = 'requires_action'

    conditional_prefix :product, false

    EXISTING_FEEDBACK_SAVED_ERROR_MESSAGE = 'WARNING: Attempted call to ShopifyAPI::ResourceFeedback#save' \
      'after it was already persisted. Updating an existing ShopifyAPI::ResourceFeedback is not supported.'

    def save
      return super unless persisted?
      raise ExistingFeedbackSaved.new(EXISTING_FEEDBACK_SAVED_ERROR_MESSAGE)
    end
  end
end
