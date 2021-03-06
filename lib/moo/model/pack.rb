module Moo
  module Model
    class Pack
      attr_accessor :cards, :sides, :product_code, :product_version, :num_cards, :image_basket

      PRODUCT_CODES = ['businesscard', 'minicard', 'postcard', 'holidaycard', 'sticker', 'sticker_label'].freeze

      def initialize
        @cards = []
        @sides = []
        @product_version = 0
        yield self if block_given?
      end

      def product_code=code
        unless PRODUCT_CODES.include? code
          raise(ArgumentError,
            "Invalid product code '#{code}', must be one of [#{PRODUCT_CODES.join(', ')}]"
          )
        end
        @product_code = code
      end

      def to_json
        to_hash.to_json
      end

      def to_hash
        hash = {
          :numCards => num_cards,
          :productCode => product_code,
          :productVersion => product_version,
          :sides => sides.map {|s| s.to_hash }
        }
        hash[:imageBasket] = image_basket.to_hash unless image_basket.nil?
        hash
      end

      def fill_side_nums
        counter = 1
        @sides.reject {|s| s.side_num.is_a? Numeric}.each do |s|
          s.side_num = counter
          counter += 1
        end
      end
    end
  end
end
