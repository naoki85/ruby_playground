class Tasks::WriteSecretsInEnv
  def self.execute
    asm = AwsSecretManager.new
    secrets = asm.get_secret
    envstr = "PRODUCTION_DB_USER=" + secrets['username'] + "\n"
    envstr += "PRODUCTION_DB_PASSWORD=" + secrets['password'] + "\n"
    envstr += "PRODUCTION_DB_NAME=" + secrets['dbname'] + "\n"
    envstr += "PRODUCTION_DB_HOST=" + secrets['host'] + "\n"

    print envstr
  end
end
