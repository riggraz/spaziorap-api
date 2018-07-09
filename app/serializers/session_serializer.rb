class SessionSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :access_token
end
