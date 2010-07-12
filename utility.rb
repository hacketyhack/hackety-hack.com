def require_directory dirname
	Dir.glob("#{File.expand_path(File.dirname(__FILE__))}/#{dirname}/*.rb").each do |f|
		require f
	end
end
