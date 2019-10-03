require 'aws-sdk-dynamodb'

module Dynamodb
  class Base
    class << self
      def save(table_name, item)
        client.put_item({
            table_name: table_name,
            item: item
                        })
        true
      rescue Aws::DynamoDB::Errors::ServiceError => error
        Rails.logger.error "#{error.message}"
        false
      end

      private

      def client
        @client ||= new_connection
      end

      def new_connection
        params = { region: "ap-northeast-1" }
        if Rails.env.development? || Rails.env.test?
          params[:endpoint] = "http://dynamoDb:8000"
          params[:credentials] = Aws::Credentials.new('hogehoge', 'fugafuga')
        end
        Aws.config.update(params)
        Aws::DynamoDB::Client.new
      end
    end
  end
end
