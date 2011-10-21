class StaticController < ApplicationController
  def root
    @platform = platform
  end

  def download
    @platform = params[:platform]
    unless @platform
      redirect_to downloads_path(platform)
      return
    end

    @download_url = case @platform
      when 'mac' then 'https://github.com/downloads/hacketyhack/hacketyhack/hacketyhack-1.0.1.dmg'
      when 'windows' then 'https://github.com/downloads/hacketyhack/hacketyhack/hacketyhack-1.0.1.exe.zip'
      when 'linux' then 'https://github.com/downloads/hacketyhack/hacketyhack/hacketyhack-1.0.1.run'
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

  protected

  def platform
    request.user_agent.match(/Mac|Linux|Windows/).try(:[], 0).try(:downcase)
  end
end
