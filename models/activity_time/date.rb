class ActivityTime::Date < ActivityTime

  include Neo4j::ActiveNode

  has_one :in, :month, model_class: ActivityTime::Month
  # has_many :out, :zetgeist_activities, model_class: ZeitgeistActivities

end
