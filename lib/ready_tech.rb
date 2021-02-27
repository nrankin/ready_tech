# frozen_string_literal: true

module ReadyTech
  # Processes baskets: imports from csv, calculates tax, and prints reciepts
  class ReadyTech
    def self.process_baskets
      Dir.glob(files_to_import).each do |file_path|
        # import one basket
        items = CsvImporter.import(file_path)
        basket = Basket.new(items)
        basket.calculate_taxes
        reciept = basket.receipt
        print reciept
      end

      'success'
    end

    def self.files_to_import
      File.join('data', '*.csv')
    end
  end
end
