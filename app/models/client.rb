class Client < ApplicationRecord
  require 'roo'
  
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      if row['email'].present?
        client = find_by_email(row['email']) || new
        client.first_name  = row['full_name'].split(' ')[0]
        # client.last_name   = row['last_name']
        client.full_name   = row['full_name']
        client.email       = row['email']
        client.company     = row['company']
        client.phone       = row['phone']
        client.url         = row['url']
        client.save
      end
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when '.csv' then  Roo::Csv.new(file.path, nil, :ignore)
      when '.xls' then  Roo::Excel.new(file.path, packed: false, file_warning: :ignore)
      when '.xlsx' then Roo::Excelx.new(file.path, packed: false, file_warning: :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
