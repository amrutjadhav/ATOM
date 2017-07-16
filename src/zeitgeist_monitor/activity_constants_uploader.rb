class ActivityConstantsUploader

  ZEITGEIST_DB_PATH = '/home/amura/.local/share/zeitgeist/activity.sqlite'

  def initialize
    @zeitgeist_db = SQLite3::Database.new ZEITGEIST_DB_PATH
  end

  def fetch_constant_entries
    @zeitgeist_db.execute 'select * from manifestation' do |row|
      key, value = row[0], row[1].split('#').last
      ZeitgeistActivityConstant::Manifestation.find_or_create_by(constant_id: key, name: value)
    end
    @zeitgeist_db.execute 'select * from interpretation' do |row|
      key, value = row[0], row[1].split('#').last
      ZeitgeistActivityConstant::Interpretation.find_or_create_by(constant_id: key, name: value)
    end
    @zeitgeist_db.execute 'select * from mimetype' do |row|
      key, value = row[0], row[1]
      ZeitgeistActivityConstant::MimeType.find_or_create_by(constant_id: key, name: value)
    end
    @zeitgeist_db.execute 'select * from uri' do |row|
      key, value = row[0], row[1].split('#').last
      ZeitgeistActivityConstant::Uri.find_or_create_by(constant_id: key, name: value)
    end

  end
end

