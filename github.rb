require 'httparty'

class Github
  include HTTParty
  base_uri "https://api.github.com"

  def initialize(username, password)
    @auth = { :username => u, :password => p}
    @bitbucket_repos = [{:name => 'dotfiles', :description => 'Dotfiles'}]
    # self.class.get "/", @auth
  end

  def import
    @bitbucket_repos.each do |repo|
      `git clone git@bitbucket.org:#{@auth[:username]}/#{repo[:name]}.git`
      Dir.chdir "./#{repo[:name]}"

      create_repo repo[:name], repo[:description]
      `git remote add github git@github.com:#{@auth[:username]}/#{repo[:name]}.git`
      `git push github master`

      # Clean up
      Dir.chdir ".."
      `rm -rf #{repo[:name]}`
    end
  end

  def create_repo name, description=""
    options = {:body => {:name => name, :description => description}.to_json}
    options.merge!({:basic_auth => @auth})

    response = self.class.post("/user/repos", options)
  end

  def delete_repo name
    self.class.delete("/repos/#{@auth[:username]}/#{name}", :basic_auth => @auth)
  end

  def test_request
    reponse = self.class.get("/users/#{@auth[:username]}/repos")
  end

  def save_repo_slugs_to_file
    open('repo-slugs.txt', 'w') do |f|
      @bitbucket_repos.each do |repo|
        f.puts repo[:name]
      end
    end
  end

  private

  #def load_bitbucket_repos
  #  response = HTTParty.get "https://api.bitbucket.org/1.0/users/#{@auth[:username]}/" # My username is the same for bitbucket and github
  #  @bitbucket_repos = response['repositories'].map { |repo| {:name => repo["slug"], :description => repo['description']}}
  #end

end