require 'securerandom'
class Card < ActiveRecord::Base
  attr_accessible :definition, :example, :translation, :word, :image_src
  has_and_belongs_to_many :tags
  belongs_to :user

  validates_presence_of :word

  before_create :generate_uuid

  def to_param
    uuid
  end

  private
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
