# We will be using neo4j-core gem for this
class Neo4jConnector
  NEO4J_DB_PATH =
  def initialize
    @neo4j_session = Neo4j::Session.open(:server_db, 'http://localhost:7474')
  end

  def execute(query)
    @neo4j_session.query(query)
  end

end
