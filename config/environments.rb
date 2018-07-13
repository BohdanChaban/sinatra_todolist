# The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path
configure :production, :development do
  set :show_exceptions, true

  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/todo')

  ActiveRecord::Base.establish_connection(
    adapter: db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    host: db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..-1],
    encoding: 'utf8'
  )

  ActiveRecord::Base.class_eval do
    def self.reset_autoincrement(options = {})
      options[:to] ||= 1
      case connection.adapter_name
      when 'MySQL'
        connection.execute "ALTER TABLE #{self.table_name} AUTO_INCREMENT=#{options[:to]}"
      when 'PostgreSQL'
        connection.execute "ALTER SEQUENCE #{self.table_name}_id_seq RESTART WITH #{options[:to]};"
      end
    end
  end
end