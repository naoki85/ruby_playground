class Tasks::WriteSecretsInEnv
  def self.execute
    mysql_secrets = AwsSecretManager.get_secret("prod/bookRecorder/Mysql")
    envstr = "PRODUCTION_DB_USER=" + mysql_secrets['username'] + "\n"
    envstr += "PRODUCTION_DB_PASSWORD=" + mysql_secrets['password'] + "\n"
    envstr += "PRODUCTION_DB_NAME=" + mysql_secrets['dbname'] + "\n"
    envstr += "PRODUCTION_DB_HOST=" + mysql_secrets['host'] + "\n"

    key_secrets = AwsSecretManager.get_secret("prod/bookRecorder/keys")
    envstr += "S3_ACCESS_KEY_ID=" + key_secrets['s3_access_key_id'] + "\n"
    envstr += "S3_SECRET_KEY=" + key_secrets['s3_secret_key'] + "\n"
    envstr += "FOG_DIRECTORY=" + key_secrets['fog_directory'] + "\n"
    envstr += "TWITTER_CONSUMER_KEY=" + key_secrets['twitter_consumer_key'] + "\n"
    envstr += "TWITTER_CONSUMER_SECRET=" + key_secrets['twitter_consumer_secret'] + "\n"
    envstr += "TWITTER_ACCESS_TOKEN=" + key_secrets['twitter_access_token'] + "\n"
    envstr += "TWITTER_ACCESS_TOKEN_SECRET=" + key_secrets['twitter_access_token_secret'] + "\n"
    envstr += "RECOMMENDED_BOOKS_DYNAMODB_TABLE=" + key_secrets['recommended_books_dynamodb_table'] + "\n"

    print envstr
  end
end
