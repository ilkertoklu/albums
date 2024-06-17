class AvatarService
  def self.fetch_avatar_url(user_id)
    response = Faraday.get("https://picsum.photos/id/#{user_id}/info")
    data = JSON.parse(response.body)
    data['download_url']
  rescue StandardError => e
    Rails.logger.error "Avatar URL fetch error: #{e.message}"
    nil
  end
end
