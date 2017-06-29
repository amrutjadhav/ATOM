class User
  include Neo4j::ActiveNode
  # From neo4jv8.0 id_property needs to define. This define which uuid is to use for neo4j nodes internally.
  id_property :neo_id
  property :name, type: String
end
