require 'securerandom'
class Card < ActiveRecord::Base
  DEFAULT_IMAGE = 'no-icon.png'

  attr_accessible :definition, :example, :translation, :word, :image_src
  has_and_belongs_to_many :tags
  belongs_to :user

  validates_presence_of :word

  before_create :generate_uuid
  before_save :default_image

  def to_param
    uuid
  end

  private
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def default_image
    self.image_src = DEFAULT_IMAGE if self.image_src.blank?
  end
end
