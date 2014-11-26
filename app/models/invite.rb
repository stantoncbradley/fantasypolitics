class Invite < ActiveRecord::Base
  belongs_to :league

  scope :by_session_key, ->(session_key){ where(session_key: session_key) }
  scope :active, ->{ where(active: true) }

  def json_attributes
    {
        session_key: session_key,
        league_id: league_id,
        active: active,
        created_at: created_at
    }
  end

end
