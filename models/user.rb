class User
  include Neo4j::ActiveNode
  include Neo4j::Timestamps # will give model created_at and updated_at timestamps
  # From neo4jv8.0 id_property needs to define. This define which uuid is to use for neo4j nodes internally.
  id_property :neo_id
  property :name, type: String

  has_many :out, :years, model_class: ActivityTime::Year, dependent: :delete, unique: true

end
