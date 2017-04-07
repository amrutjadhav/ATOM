class Neo4jConnector
  NEO4J_DB_PATH =
  def initialize
    @neo4j_connection = Neo4j::Session.open(:server_db, 'http://localhost:7474')
  end

end
