# frozen_string_literal: true

def update_supporters
  require 'date'
  require 'net/http'
  require 'json'
  require 'yaml'

  url = URI.parse 'https://opencollective.com/asciidoctor/members/all.json'
  response = Net::HTTP.get_response url
  if Net::HTTPSuccess === response
    json_data = JSON.parse response.body

    tiers = {
      'Change Maker' => [],
      'Innovation Sponsor' => [],
      'Docs Sponsor' => [],
      'Pull Request Backer' => [],
      'R & D Backer' => [],
      'Q & A Backer' => [],
      'Backer' => [],
    }

    grouped_members = json_data.group_by {|it| it['tier'] || 'Backer' }

    grouped_members.each do |tier, entries|
      entries.each do |entry|
        next unless entry['isActive'] && (amount = entry['totalAmountDonated']) > 0
        name = entry['name']
        #next if name == 'Guest' || name == 'Incognito'
        if (image = entry['image'] || (name == 'Khronos Group' ? 'https://github.com/KhronosGroup.png' : nil))
          image = %(#{image}#{(image.include? '?') ? '&' : '?'}s=460)
        end
        profile = entry['profile']
        unless (url = entry['website'])
          url = profile unless profile.include? '/guest-'
        end
        tiers[tier] << {
          name: name,
          company: entry['company'],
          description: entry['description'],
          profile: profile,
          github: (entry['github'] || (name == 'r0ckarong' ? %(https://github.com/#{name}) : nil)),
          url: url,
          image: image,
          amount: amount,
          last: entry['lastTransactionAt'],
        }.reject {|_, v| v.to_s.empty? }
      end
    end

    supporters = tiers.each_with_object([]) {|(category, members), accum|
      (members = members.sort_by {|it| it[:last] }).each do |it|
        it.delete :amount
        it.delete :last
      end
      accum << { category: category, members: members }
      accum
    }

    supporters_data = supporters.to_yaml
    File.write '_config/supporters.yml', supporters_data, mode: 'w:UTF-8'
  else
    warn %(Failed to retrieve the supporters JSON file. HTTP Error: #{response.code} - #{response.message})
  end
end

desc 'Updates the current list of supporters'
task :supporters do
  update_supporters
end
