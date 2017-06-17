# Need to move this connection code in main file. We can't make new connection for every model object.
require 'neo4j'
require 'neo4j/core/cypher_session/adaptors/http'
neo4j_adaptor = Neo4j::Core::CypherSession::Adaptors::HTTP.new('http://neo4j:amrut2294@localhost:7474')
Neo4j::ActiveBase.current_session = Neo4j::Core::CypherSession.new(neo4j_adaptor)

class User
  include Neo4j::ActiveNode
  # From neo4jv8.0 id_property needs to define. This define which uuid is to use for neo4j nodes internally.
  id_property :neo_id
  property :name, type: String
end
