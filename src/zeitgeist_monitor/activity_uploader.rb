class ActivityUploader

  ZEITGEIST_DB_PATH = '/home/amura/.local/share/zeitgeist/activity.sqlite'

  def initialize
    @zeitgeist_db = SQLite3::Database.new ZEITGEIST_DB_PATH
  end

  def check_dates(row)
    timestamp = row[1]
    event_datetime = DateTime.strftime(timestamp, '%Q')
    query = "match (user: User{email: #{@user[:email]}})-[:YEAR]->(year: Year{year: #{event_datetime.year}})"
    result = @neo4j_session.execute(query)
    # check year
    if !year
      query = "match (user: User{email: #{@user[:email]}}) create(year: Year{year: #{event_datetime.year}})
                (user)-[:YEAR]->(:year)"
    end

    # check month
    query = "match (user: User{email: #{@user[:email]}})-[:YEAR]->(year: Year{year: #{event_datetime.year}})
                -[:MONTH]->(month: Month{month: #{event_datetime.month}})"
    result = @neo4j_session.execute(query)
    if !result
      query = "match (user: User{email: #{@user[:email]}})-[:YEAR]->(year: Year{year: #{event_datetime.year}}) create(month: Month{month: #{event_datetime.month}}) (year)-[:MONTH]->(:month)"
    end

    # check date
    query = "match (user: User{email: #{@user[:email]}})-[:YEAR]->(year: Year{year: #{event_datetime.year}})
                -[:MONTH]->(month: Month{month: #{event_datetime .month}})-[:DATE]->(date: Date{date: #{event_datetime.date}})"
    result = @neo4j_session.execute(query)
    if !result
      query = "match (user: User{email: #{@user[:email]}})-[:YEAR]->(year: Year{year: #{event_datetime.year}})
                -[:MONTH]->(month: Month{month: #{event_datetime.month}}) create(date: Date{date: #{event_datetime.date}})
                (month)-[:DATE]->(:date)"
    end
  end #end check_dates

  def upload_zeitgeist_events
    current_time = DateTime.now
    epoch_milliseconds = current_time.strftime('%Q')
    event_rows = @zeitgeist_db.execute "select * from event_view where timestamp > #{epoch_milliseconds}"
    event_rows.each do |row|
      check_dates(row)
    end
  end # end upload_zeitgeist_events

  def create_user
    # create user of this system
    query = "match (user: User{email: #{@user[:email]}})"
    result = @neo4j_session.execute(query)
    if(!result)
      query = "create (user: User{email: #{@user[:email]}})"
      @neo4j_session.execute(query)
    end
  end # end create_user



end
# zeitgeist = ZeitgeistDataUpload.new()
# zeitgeist.fetch_constant_entries
