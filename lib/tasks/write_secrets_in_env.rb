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

    print envstr
  end
end
