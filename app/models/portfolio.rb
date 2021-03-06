class Portfolio < ApplicationRecord
    has_many :technologies
    accepts_nested_attributes_for :technologies,
                                  reject_if: lambda { |attrs| attrs["name"].blank? }
    include Placeholder
    validates_presence_of :title, :description, :img, :thumb

    def self.angular
        where(subtitle: "Angular")
    end

    def self.by_position
      order("position ASC")
    end

    scope :ror, -> { where(subtitle: "Ruby on Rails") }

    after_initialize :set_defaults

    def set_defaults
        self.img ||= Placeholder.image_generator("600", "400")
        self.thumb ||= Placeholder.image_generator("350", "200")
    end
end
