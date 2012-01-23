class ApiConstraint
  def self.matches?(request)
    request.subdomain.present? and (# do we have one?
    request.subdomain == 'api' or # in production?
    request.subdomain == 'api.hackety-hack') # with pow?
  end
end

