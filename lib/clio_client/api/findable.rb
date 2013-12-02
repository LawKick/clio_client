module ClioClient
  module Api
    module Findable
      
      def find(id)
        response = session.get("#{end_point_url}/#{id}")
        data_item(response[singular_resource])
      end

    end
  end
end