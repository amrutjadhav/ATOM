class  ZeitgeistActivityConstant
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  id_property :neo_id
  property :constant_id, type: Integer
  property :name, type: String
end
