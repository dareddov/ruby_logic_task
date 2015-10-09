class UsersImporter
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def call
    display_errors = []
    importing_count = 0
    not_importing_count = 0
    sheet.each(name: 'Imię', surname: 'Nazwisko', email: 'Email', expiration_date: 'Data ważności konta') do |user_params|
      user = UserCreator.new(user_params).call
      if user.save
        importing_count += 1
      else
        display_errors << errors_for_user(user)
        not_importing_count += 1
      end
    end
    puts display_errors
    puts "Importing rows: #{importing_count}"
    puts "Not importing rows: #{not_importing_count}"
  end

  def errors_for_user(user)
    errors = "#{user.name} #{user.surname} -"
    user.errors.each do |attribute, message|
      errors += " #{attribute.to_s} #{message.to_s},"
    end
    errors.chomp(',')
  end

  private

  def spreedsheet
    Roo::Spreadsheet.open(path)
  end

  def sheet
    spreedsheet.sheet(spreedsheet.sheets.first)
  end
end