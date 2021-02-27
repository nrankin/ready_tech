# frozen_string_literal: true

require 'bigdecimal'

module ReadyTech
  # An item represents one product, with it's quantity and price
  class Item
    attr_accessor :row, :tax

    def initialize(row)
      @row = row
    end

    def quantity
      row[:quantity]
    end

    def product
      row[:product]
    end

    def price
      BigDecimal(row[:price])
    end

    def price_with_tax
      raise ReadyTech::TaxesNotCalculatedError if tax.nil?

      price + tax
    end

    def receipt_line
      "#{quantity}, #{product}, #{price_with_tax}"
    end

    def product_type
      return 'book' if book?
      return 'food' if food?
      return 'medical' if medical?

      'general'
    end

    def book?
      /book/.match?(product)
    end

    def food?
      /(chocolate|apple)/.match?(product)
    end

    def medical?
      /pills/.match?(product)
    end
  end
end
