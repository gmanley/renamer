class MatchData

  def to_hash
    Hash[[names, captures].transpose]
  end
  alias_method :to_h, :to_hash
end
