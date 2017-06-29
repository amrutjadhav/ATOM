class  ZeitgeistActivityConstant
  include Neo4j::ActiveNode

  id_property :neo_id
  property :constant_id, type: Integer, index: :exact
  property :name, type: String
end
