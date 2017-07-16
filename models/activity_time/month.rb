class ActivityTime::Month < ActivityTime

  include Neo4j::ActiveNode

  has_one :in, :year, model_class: ActivityTime::Year
  has_many :out, :dates, model_class: ActivityTime::Date, dependent: :delete, unique: true

end
