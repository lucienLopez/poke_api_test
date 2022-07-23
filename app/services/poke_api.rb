module PokeAPI
  BASE_URI = 'https://pokeapi.co/api/v2'.freeze
  PAGE_LENGTH = 60

  def self.resources_data(path, &block)
    page = 0
    remaining = 0
    until page.positive? && remaining <= 0
      result = resources_page_data(path, page)
      remaining = result[:remaining]
      result[:resources].each(&block)

      page += 1
    end
  end

  def self.pokemons(&block)
    resources_data('/pokemon', &block)
  end

  def self.types(&block)
    resources_data('/type', &block)
  end

  def self.resources_page_data(path, page = 0)
    request_body = HTTP.get("#{BASE_URI}#{path}", params: { limit: PAGE_LENGTH, offset: page * PAGE_LENGTH }).body
    data = JSON.parse(request_body)
    remaining = data['count'] - (page + 1) * PAGE_LENGTH
    resources = []

    data['results'].each do |resource_data|
      resources << JSON.parse(HTTP.get(resource_data['url']))
    end

    { resources: resources, remaining: remaining }
  rescue StandardError
    # TODO: handle exception
  end
end
