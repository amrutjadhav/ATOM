class  ZeitgeistActivityConstant
  include Neo4j::ActiveNode

  id_property :neo_id
  property :constant_id, type: Integer
  property :name, type: String
end
