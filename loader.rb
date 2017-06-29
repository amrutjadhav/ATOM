# Need to move this connection code in main file. We can't make new connection for every model object.
require 'neo4j'
require 'neo4j/core/cypher_session/adaptors/http'
neo4j_adaptor = Neo4j::Core::CypherSession::Adaptors::HTTP.new('http://neo4j:amrut2294@localhost:7474')
Neo4j::ActiveBase.current_session = Neo4j::Core::CypherSession.new(neo4j_adaptor)


require 'bundler'
Bundler.require(:default)

# Load models
load File.expand_path("../models/user.rb",   __FILE__)
load File.expand_path("../models/zeitgeist_activity_constant.rb",   __FILE__)
Dir[File.expand_path('../models/zeitgeist_activity_constant/*.rb', __FILE__)].each { |f| load f }
Dir[File.expand_path("../src/zeitgeist-monitor/*",   __FILE__)].each {|file| load file}

ActivityConstantsUploader.new.fetch_constant_entries
