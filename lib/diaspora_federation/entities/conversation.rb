module DiasporaFederation
  module Entities
    # This entity represents a private conversation between users.
    #
    # @see Validators::ConversationValidator
    class Conversation < Entity
      # @!attribute [r] author
      #   The diaspora* ID of the person initiated the conversation
      #   @see Person#author
      #   @return [String] diaspora* ID
      property :author, xml_name: :diaspora_handle

      # @!attribute [r] guid
      #   A random string of at least 16 chars
      #   @see Validation::Rule::Guid
      #   @return [String] conversation guid
      property :guid

      # @!attribute [r] subject
      #   @return [String] the conversation subject
      property :subject

      # @!attribute [r] created_at
      #   @return [Time] Conversation creation time
      property :created_at, default: -> { Time.now.utc }

      # @!attribute [r] participants
      #   The diaspora* IDs of the persons participating the conversation separated by ";"
      #   @return [String] participants diaspora* IDs
      property :participants, xml_name: :participant_handles

      # @!attribute [r] messages
      #   @return [[Entities::Message]] Messages of this conversation
      entity :messages, [Entities::Message], default: []

      private

      def validate
        super
        messages.each do |message|
          raise ValidationError, "nested #{message} has different author: author=#{author}" if message.author != author
        end
      end
    end
  end
end
