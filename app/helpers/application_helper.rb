# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	require 'hpricot'
	require 'syntax/convertors/html'

	def syntax_highlight(content) 
		h = Hpricot(content) 
		c = Syntax::Convertors::HTML.for_syntax "ruby" 
		h.search('//pre[@class="ruby"]') do |e| 
			e.inner_html = c.convert(e.inner_text,false) 
		end 
		h.to_s 
	end 
end
