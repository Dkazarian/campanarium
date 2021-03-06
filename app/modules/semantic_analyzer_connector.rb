class SemanticAnalyzerConnector
  class << self
    def group_notices(task_id = '')
      body = {
        corpus: [],
        metadata: {},
        url: "#{AppConfiguration.semantic_analyzer_response_url}?task_id=#{task_id}"
      }
      notices = Notice.where("length(categories) > 0").where(notice_group_id: nil).order("random()").limit(20)

      notices.each do |notice|
        if(notice.body.present?)
          body[:corpus].push({
            document: notice.body.truncate(600, separator: " ").gsub(/(\n|\"|\.\.\.)/, ""),
            category: notice.categories[0].name.to_s,
            keywords: notice.keywords,
            user_info: notice.id
          })
        end
      end

      if(body[:corpus].length == 0)then puts("No notices to group"); return; end

      body[:metadata][:nmb_of_centroids] = [(notices.length / [notices.pluck(:source).uniq.count, 2].max).to_i, 10].min

      code, response = ExternalServiceCall.new().post(url("analyzer"), body)
      if(code == 200)
        puts("Request success")
      else
        puts("Request failed: #{response['error']}" ) if response
      end
      return [code, response]
    end

    def manage_response(response, status)
      if(status == 200)
        response["result_set"]["result"].each do |result|
          NoticeGroup.create(notices: Notice.find(result["grouped_documents"].map{|document| document["user_info"]}))
        end
      else
        puts("Request failed: #{response['error']}" )
      end
    end

    def url(route)
      "http://#{AppConfiguration.configuration[:semantic_analyzer_host]}:#{AppConfiguration.configuration[:semantic_analyzer_port]}/#{route}"
    end
  end
end