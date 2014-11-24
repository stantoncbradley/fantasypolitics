class Invite < ActiveRecord::Base
  belongs_to :league

  def json_attributes
    {
        session_key: session_key,
        league_id: league_id,
        active: active,
        created_at: created_at
    }
  end

end
