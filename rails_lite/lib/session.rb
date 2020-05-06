require 'json'

class Session

  SESSION_NAME = "_rails_lite_app".freeze
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    if session = req.cookies[SESSION_NAME]
      @session = JSON.parse(session)
    else
      @session = {}
    end
  end

  def [](key)
    @session[key]
  end

  def []=(key, val)
    @session[key] = val
    true
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.set_cookie(SESSION_NAME, {path: "/", value: @session.to_json})
  end
end
