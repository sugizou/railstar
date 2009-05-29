class Twitter < ActiveResource::Base
  self.user     = ''
  self.password = ''

  self.site     = "http://#{self.user}:#{self.password}@twitter.com/"
  self.logger   = Logger.new($stdout)

  class Status < Twitter
  end

  class Follower < Twitter
    def self.ids(id=self.user)
      # 5000件しか取得しないので、それ以上のFollowersも考慮するならpageオプションを仕様すること。
      # 詳細はTwitterAPI参照
      begin
        followers = self.get(:ids, :id => id)
        followers.blank? ? followers : followers.first.second.map{|id| id.to_i}
      rescue ActiveResource::ResourceNotFound
        []
      end
    end
  end

  class User < Twitter
    attr_accessor :name, :icon, :location, :url, :description, :screen_name, :friends_count, :followers_count, :created_at

    def initialize(id=self.user)
      result = User.get(:show, :id => id)
      @name            = result["name"]
      @icon            = result["profile_image_url"]
      @location        = result["location"]
      @url             = result["url"]
      @description     = result["description"]
      @screen_name     = result["screen_name"]
      @followers_count = result["followers_count"]
      @friends_count   = result["friends_count"]
      begin
        @created_at    = Date.strptime(result["created_at"], "%a %b %d %T %z %Y")
      rescue
        @created_at    = nil
      end
    end
  end
end
