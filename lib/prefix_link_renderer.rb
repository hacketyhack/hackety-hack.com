class PrefixLinkRenderer < WillPaginate::ActionView::LinkRenderer
  def initialize(prefix)
    @prefix = prefix
    super()
  end

  protected

  def url(page)
    @prefix + super
  end
end
