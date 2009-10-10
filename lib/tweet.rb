class Tweet < ActiveRecord::Base
  def to_time
    created_at.to_time.ctime
  end

  def to_time!
    self.created_at = created_at.to_time.ctime
  end
end
