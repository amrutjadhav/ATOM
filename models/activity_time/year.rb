class ActivityTime::Year < ActivityTime

  include Neo4j::ActiveNode

  has_one :in, :user, model_class: User
  has_many :out, :months, model_class: ActivityTime::Month, dependent: :delete, unique: true

end
