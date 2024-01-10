
Elasticsearch::Model.client = Elasticsearch::Client.new(url: ENV['http://localhost:9200'] || 'http://localhost:9200')
