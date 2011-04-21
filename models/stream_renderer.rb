class StreamRenderer < WillPaginate::LinkRenderer
  
  def prepare col, opt, template
    @collection = col
    @options = opt
    @options[:container] = nil
    @template = template
    @total_pages = @collection.total_pages
  end

  def page_link(page, text, attr = {})
    "<a href='/#{root_page}?page=#{page}'>#{text}</a>"
  end

  def root_page
    "stream"
  end

  def page_span(page, text, attr = {})
    "<span>#{text}</span>"
  end
end

WillPaginate::ViewHelpers.pagination_options[:renderer] = StreamRenderer

