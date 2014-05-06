class Page < ActiveRecord::Base
  has_paper_trail

  extend FriendlyId
  friendly_id :name, use: :slugged
  alias_attribute :value, :content

  validates_presence_of :name
  validates_uniqueness_of :slug

  def self.content_by_slug(slug)
    # Used for including a page within another page. For example, including:
    #    Page.content_by_slug('footer')
    # in your template footer will pull the copy stored in 'footer' for
    # rendering. This is needed since the page being rendered will have a
    # different @page, if any.

    p = Page.find_by_slug(slug)
    p.nil? ? "" : p.content
  end
end
