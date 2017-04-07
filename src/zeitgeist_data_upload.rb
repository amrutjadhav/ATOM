require 'sqlite3'
require 'byebug'

class ZeitgeistDataUpload

  ZEITGEIST_DB_PATH = '/home/amura/.local/share/zeitgeist/activity.sqlite'

  def initialize
    @zeitgeist_db = SQLite3::Database.new ZEITGEIST_DB_PATH
  end

  def fetch_constant_entries
    constant_hash = {manifestation: [], interpretation: [],  mimetype: [], uri: []}

    @zeitgeist_db.execute 'select * from manifestation' do |row|
      key, value = row.first, row.last.split('#').last
      constant_hash[:manifestation] << {key => value} if(!constant_hash[:manifestation].include?(value))
    end
    @zeitgeist_db.execute 'select * from interpretation' do |row|
      key, value = row.first, row.last.split('#').last
      constant_hash[:interpretation] << {key => value} if(!constant_hash[:interpretation].include?(value))
    end
    @zeitgeist_db.execute 'select * from mimetype' do |row|
      key, value = row.first, row.last
      constant_hash[:mimetype] << {key => value} if(!constant_hash[:mimetype].include?(value))
    end
    @zeitgeist_db.execute 'select * from uri' do |row|
      key, value = row.first, row.last.split('#').last
      constant_hash[:uri] << {key => value} if(!constant_hash[:uri].include?(value))
    end

    constant_hash
  end

  def upload_zeitgeist_events
    current_time = DateTime.now
    epoch_milliseconds = current_time.strftime('%Q')
    event_rows = @zeitgeist_db.execute "select * from event_view where timestamp > #{epoch_milliseconds}"
    event_rows.each do |row|
      timestamp = row[1]
      event_datetime = DateTime.strftime(timestamp, '%Q')
      # check the year
      # check the month
      # check date
    end

  end

  def create_user
    # create user of this system
  end



end
zeitgeist = ZeitgeistDataUpload.new()
zeitgeist.fetch_constant_entries
