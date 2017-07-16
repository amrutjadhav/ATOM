class  ActivityTime
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  id_property :neo_id
  property :value, type: String
end
