class SessionSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :username, :admin, :access_token
end
