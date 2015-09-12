require 'json'

PAPERCLIP_BUCKET_NAME = "images"

# create the bucket if there are no directories within the Swift container
# uses a direct fog connection
def create_bucket_if_needed(swift_service)
  connection = Fog::Storage.new({
     :provider => 'HP',
     :hp_access_key => swift_service["credentials"]["user_name"],
     :hp_secret_key => swift_service["credentials"]["password"],
     :hp_tenant_id => swift_service["credentials"]["tenant_id"],
     :hp_auth_uri => swift_service["credentials"]["authentication_uri"],
     :hp_use_upass_auth_style => true,
     :hp_avl_zone => swift_service["credentials"]["availability_zone"]
  })

  if connection.directories.get(PAPERCLIP_BUCKET_NAME).nil?
    puts "The bucket with key=#{PAPERCLIP_BUCKET_NAME} wasn't found. Creating bucket with key=#{PAPERCLIP_BUCKET_NAME}"
    bucket = connection.directories.create key: PAPERCLIP_BUCKET_NAME

    # set the directory to be public
    bucket.public = true
    bucket.save

    connection = nil
  end
end

if Rails.env.production?
  # parse the VCAP_SERVICES environment variable
  SERVICES = JSON.parse(ENV["VCAP_SERVICES"])
  swift_service = SERVICES["swift-1.0"].first

  create_bucket_if_needed(swift_service)

  # configure paperclip to use the credentials provided by the anynines environment
  Paperclip::Attachment.default_options.update(
    {
      :path => ":class/:id/:attachment/:style/img_:fingerprint",
      :storage => :fog,
      :fog_credentials => {
        :provider => 'HP',
        :hp_access_key => swift_service["credentials"]["user_name"],
        :hp_secret_key => swift_service["credentials"]["password"],
        :hp_tenant_id => swift_service["credentials"]["tenant_id"],
        :hp_auth_uri => swift_service["credentials"]["authentication_uri"],
        :hp_use_upass_auth_style => true,
        :hp_avl_zone => swift_service["credentials"]["availability_zone"]
      },
      :fog_directory => PAPERCLIP_BUCKET_NAME,
      :fog_public => true,
      :fog_host => "https://swift.hydranodes.de/v1/AUTH_#{swift_service["credentials"]["tenant_id"]}/#{PAPERCLIP_BUCKET_NAME}"
    })
end
