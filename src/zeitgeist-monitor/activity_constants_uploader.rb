class ActivityConstantsUploader

  ZEITGEIST_DB_PATH = '/home/amura/.local/share/zeitgeist/activity.sqlite'

  def initialize
    @zeitgeist_db = SQLite3::Database.new ZEITGEIST_DB_PATH
  end

  def fetch_constant_entries
    @zeitgeist_db.execute 'select * from manifestation' do |row|
      key, value = row.first, row.last.split('#').last
      ZeitgeistActivityConstant::Manifestation.create(constant_id: key, name: value)
    end
    @zeitgeist_db.execute 'select * from interpretation' do |row|
      key, value = row.first, row.last.split('#').last
      ZeitgeistActivityConstant::Interpretation.create(constant_id: key, name: value)
    end
    @zeitgeist_db.execute 'select * from mimetype' do |row|
      key, value = row.first, row.last
      ZeitgeistActivityConstant::Mimetype.create(constant_id: key, name: value)
    end
    @zeitgeist_db.execute 'select * from uri' do |row|
      key, value = row.first, row.last.split('#').last
      ZeitgeistActivityConstant::Uri.create(constant_id: key, name: value)
    end

    # constant_hash
  end
end

