# _plugins/meilisearch_indexer.rb
require 'httpparty'
require 'json'

module Jekyll
  class MeilisearchIndexer < Jekyll::Generator
    # This runs automatically when you build your site
    def generate(site)
        puts "Starting Meilisearch indexing..." # Add this
      # Meilisearch
      settings (customize these)
            meilisearch_url = 'http://localhost:7700' # Change if hosted elsewhere
            api_key = ENV['MEILISEARCH_API_KEY'] || 'your-api-key-here' # Set via environment variable
            index_name = 'jekyll_posts'

            # Collect posts
            documents = site.posts.docs.map do |post|
              {
                id: post.id.gsub('/', '-'), # Unique ID
                title: post.data['title'],
                content: post.content,
                url: post.url,
                date: post.date.strftime('%Y-%m-%d')
              }
            end

            # Send to Meilisearch
            response = HTTParty.post(
              "#{meilisearch_url}/indexes/#{index_name}/documents",
              body: documents.to_json,
              headers: {
                'Content-Type' => 'application/json',
                'Authorization' => "Bearer #{api_key}"
              }
            )

            # Log result
            if response.success?
              puts "Indexed #{documents.size} posts to Meilisearch!"
            else
              puts "Failed to index: #{response.code} - #{response.body}"
            end
    end
  end
end
