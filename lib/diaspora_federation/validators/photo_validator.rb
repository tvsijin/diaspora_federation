module DiasporaFederation
  module Validators
    # This validates a {Entities::Photo}.
    class PhotoValidator < Validation::Validator
      include Validation

      rule :guid, :guid

      rule :author, %i(not_empty diaspora_id)

      rule :public, :boolean

      rule :remote_photo_path, :not_empty

      rule :remote_photo_name, :not_empty

      rule :status_message_guid, guid: {nilable: true}

      rule :text, length: {maximum: 65_535}

      rule :height, :numeric

      rule :width, :numeric
    end
  end
end
