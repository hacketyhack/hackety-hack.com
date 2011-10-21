class StaticController < ApplicationController
  def root
    @platform = request.user_agent.match(/Mac|Linux|Windows/).try(:[], 0)
  end

  def download
    @platform = params[:platform]
    @download_url = case @platform
      when 'mac' then 'https://github.com/downloads/hacketyhack/hacketyhack/hacketyhack-1.0.1.dmg'
      when 'windows' then 'https://github.com/downloads/hacketyhack/hacketyhack/hacketyhack-1.0.1.exe.zip'
      when 'linux' then 'https://github.com/downloads/hacketyhack/hacketyhack/hacketyhack-1.0.1-linux.run'
      else 'https://github.com/downloads/hacketyhack/hacketyhack/hacketyhack-1.0.1.dmg'
      end
    @locals = {
      :resource => User.new,
      :resource_name => "user"
    }
    @other_platforms = ["mac", "windows", "linux"] - [@platform]
  end

  def api_root; render :layout => "api"; end
  def newest_version
    render :json => {:version => "1.0.0"}
  end
end
