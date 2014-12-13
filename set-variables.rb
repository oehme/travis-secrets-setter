require 'travis'
Travis.access_token = Travis.github_auth(ENV['TRAVIS_TOKEN'])
repos = Travis::Repository.find_all(owner_name: 'oehme')
keys = ['ORG_GRADLE_PROJECT_bintrayApiKey', 'ORG_GRADLE_PROJECT_signingPassword', 'ORG_GRADLE_PROJECT_sonatypePassword']
repos.each do |repo|
	keys.each do |key|
		puts "Setting env var '#{key}' on project '#{repo.slug}'"
		repo.env_vars.upsert(key, "'#{ENV[key]}'", public: false)
	end
end
