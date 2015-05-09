class Beer < ActiveRecord::Base
    belongs_to :user
    
    def self.search(query)
        query = query.downcase
        where("lower(name) like :q or lower(brewery) like :q or lower(beertype) like :q", q: "%#{query}%")
    end    
    
    def self.import(file)
        spreadsheet = open_spreadsheet(file)
        header = spreadsheet.row(1)
        (2..spreadsheet.last_row).each do |i|
            row = Hash[[header, spreadsheet.row(i)].transpose]
            beer = find_by_name(row['name']) || new
            beer.attributes = row.to_hash
            beer.save!
        end
    end
  
    def self.open_spreadsheet(file)
      case File.extname(file.original_filename)
          when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
          when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
          when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
          when "gdoc" then Roo::Google.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
      end
    end
end
